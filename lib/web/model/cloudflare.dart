import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cloudflare.g.dart';

class CloudflareBrowserState {
  const CloudflareBrowserState({
    required this.cookies,
    required this.localStorage,
    required this.userAgentHeaders,
  });

  final List<Cookie> cookies;
  final Map<String, String> localStorage;
  final Map<String, String> userAgentHeaders;
}

class BrowserCookieSelection {
  const BrowserCookieSelection({
    required this.cookies,
    required this.inputCount,
    required this.duplicateNames,
  });

  final List<Cookie> cookies;
  final int inputCount;
  final List<String> duplicateNames;

  int get discardedCount => inputCount - cookies.length;
}

String diagnosticValueFingerprint(String value) {
  final digest = sha256.convert(utf8.encode(value)).toString();
  return 'sha256:${digest.substring(0, 12)}';
}

String diagnosticUserAgentFingerprint(String value) {
  var hash = 0x811c9dc5;
  for (final codeUnit in value.codeUnits) {
    hash ^= codeUnit & 0xff;
    hash = (hash * 0x01000193) & 0xffffffff;
  }
  return 'fnv32:${hash.toRadixString(16).padLeft(8, '0')}';
}

String? cloudflareClearanceFingerprint(Iterable<Cookie> cookies) {
  for (final cookie in cookies) {
    if (cookie.name == 'cf_clearance') {
      return diagnosticValueFingerprint(cookie.value);
    }
  }
  return null;
}

BrowserCookieSelection selectBrowserCookiesForUrl(
  List<Cookie> cookies,
  Uri url, {
  DateTime? now,
}) {
  final currentTime = now ?? DateTime.now();
  final candidates = <({Cookie cookie, int index})>[];
  final counts = <String, int>{};

  for (final (index, cookie) in cookies.indexed) {
    if (!_browserCookieApplies(cookie, url, currentTime)) {
      continue;
    }
    candidates.add((cookie: cookie, index: index));
    counts.update(cookie.name, (count) => count + 1, ifAbsent: () => 1);
  }

  final selected = <String, ({Cookie cookie, int index})>{};
  for (final candidate in candidates) {
    final existing = selected[candidate.cookie.name];
    if (existing == null ||
        _compareBrowserCookies(candidate, existing, url) > 0) {
      selected[candidate.cookie.name] = candidate;
    }
  }

  final values = selected.values.toList()
    ..sort((left, right) => left.index.compareTo(right.index));
  final duplicateNames =
      counts.entries
          .where((entry) => entry.value > 1)
          .map((entry) => entry.key)
          .toList()
        ..sort();

  return BrowserCookieSelection(
    cookies: values.map((value) => value.cookie).toList(),
    inputCount: cookies.length,
    duplicateNames: duplicateNames,
  );
}

bool _browserCookieApplies(Cookie cookie, Uri url, DateTime now) {
  final expiresDate = cookie.expiresDate;
  if (expiresDate != null && expiresDate <= now.millisecondsSinceEpoch) {
    return false;
  }
  if (cookie.isSecure == true && url.scheme != 'https') {
    return false;
  }

  final domain = (cookie.domain ?? '').toLowerCase().replaceFirst(
    RegExp(r'^\.'),
    '',
  );
  final host = url.host.toLowerCase();
  if (domain.isNotEmpty && host != domain && !host.endsWith('.$domain')) {
    return false;
  }

  final cookiePath = cookie.path?.isNotEmpty == true ? cookie.path! : '/';
  final requestPath = url.path.isEmpty ? '/' : url.path;
  return requestPath == cookiePath ||
      requestPath.startsWith(
        cookiePath.endsWith('/') ? cookiePath : '$cookiePath/',
      );
}

int _compareBrowserCookies(
  ({Cookie cookie, int index}) left,
  ({Cookie cookie, int index}) right,
  Uri url,
) {
  final leftPathLength = left.cookie.path?.length ?? 1;
  final rightPathLength = right.cookie.path?.length ?? 1;
  final pathComparison = leftPathLength.compareTo(rightPathLength);
  if (pathComparison != 0) {
    return pathComparison;
  }

  if (url.scheme == 'https') {
    final secureComparison = (left.cookie.isSecure == true ? 1 : 0).compareTo(
      right.cookie.isSecure == true ? 1 : 0,
    );
    if (secureComparison != 0) {
      return secureComparison;
    }
  }

  final leftDomainLength = left.cookie.domain?.length ?? 0;
  final rightDomainLength = right.cookie.domain?.length ?? 0;
  final domainComparison = leftDomainLength.compareTo(rightDomainLength);
  if (domainComparison != 0) {
    return domainComparison;
  }

  final expiryComparison = (left.cookie.expiresDate ?? -1).compareTo(
    right.cookie.expiresDate ?? -1,
  );
  return expiryComparison != 0
      ? expiryComparison
      : left.index.compareTo(right.index);
}

enum StartupBrowserOutcome {
  skippedNoBaseUrl,
  manualBrowserState,
  readyPageLoaded,
  readyWithoutChallenge,
  readyWithExistingClearance,
  readyWithNewClearance,
  manualResolutionRequired,
  indeterminateTimeout,
  browserLoadFailed,
}

class StartupBrowserException implements Exception {
  const StartupBrowserException({
    required this.outcome,
    required this.message,
    this.cause,
  });

  final StartupBrowserOutcome outcome;
  final String message;
  final Object? cause;

  @override
  String toString() {
    final cause = this.cause;
    return 'Extension startup browser ${outcome.name}: $message'
        '${cause == null ? '' : ' ($cause)'}';
  }
}

class StartupBrowserState {
  const StartupBrowserState({
    required this.outcome,
    required this.cookies,
    required this.localStorage,
  });

  final StartupBrowserOutcome outcome;
  final List<Cookie> cookies;
  final Map<String, String> localStorage;
}

@Riverpod(keepAlive: true)
class CloudflareBrowserStates extends _$CloudflareBrowserStates {
  @override
  Map<String, CloudflareBrowserState> build() => {};

  void stage(String sourceId, CloudflareBrowserState browserState) {
    state = {...state, sourceId: browserState};
  }

  CloudflareBrowserState? take(String sourceId) {
    final browserState = state[sourceId];
    if (browserState == null) {
      return null;
    }

    state = Map.of(state)..remove(sourceId);
    return browserState;
  }
}
