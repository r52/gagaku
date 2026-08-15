import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_readium/flutter_readium.dart';
import 'package:gagaku/log.dart';

enum LocalDocumentFormat { pdf, epub }

@immutable
class LocalDocumentDescriptor {
  const LocalDocumentDescriptor({
    required this.path,
    required this.title,
    required this.format,
  });

  final String path;
  final String title;
  final LocalDocumentFormat format;
}

LocalDocumentFormat? localDocumentFormatFromPath(String path) {
  final normalized = path.toLowerCase();
  if (normalized.endsWith('.pdf')) return LocalDocumentFormat.pdf;
  if (normalized.endsWith('.epub')) return LocalDocumentFormat.epub;
  return null;
}

abstract interface class LocalDocumentReadium {
  Stream<ReadiumReaderStatus> get onReaderStatusChanged;
  Stream<Locator> get onTextLocatorChanged;
  Stream<ReadiumError> get onErrorEvent;

  Future<Publication> openPublication(String uri);
  Future<void> closePublication();
  Future<void> goBackward();
  Future<void> goForward();
  Future<bool> goToLocator(Locator locator);
  Future<bool> goToProgression(double progression);
  Future<void> setEPUBPreferences(EPUBPreferences preferences);
}

typedef LocalEpubPreferencesChanged =
    FutureOr<void> Function(double fontSize, bool scroll);

class FlutterLocalDocumentReadium implements LocalDocumentReadium {
  FlutterLocalDocumentReadium([FlutterReadium? readium])
    : _readium = readium ?? FlutterReadium();

  final FlutterReadium _readium;

  @override
  Stream<ReadiumReaderStatus> get onReaderStatusChanged =>
      _readium.onReaderStatusChanged;

  @override
  Stream<Locator> get onTextLocatorChanged => _readium.onTextLocatorChanged;

  @override
  Stream<ReadiumError> get onErrorEvent => _readium.onErrorEvent;

  @override
  Future<Publication> openPublication(String uri) =>
      _readium.openPublication(uri);

  @override
  Future<void> closePublication() => _readium.closePublication();

  @override
  Future<void> goBackward() => _readium.goBackward();

  @override
  Future<void> goForward() => _readium.goForward();

  @override
  Future<bool> goToLocator(Locator locator) => _readium.goToLocator(locator);

  @override
  Future<bool> goToProgression(double progression) =>
      _readium.goToProgression(progression);

  @override
  Future<void> setEPUBPreferences(EPUBPreferences preferences) =>
      _readium.setEPUBPreferences(preferences);
}

enum LocalDocumentSessionPhase { loading, ready, failure, closed }

@immutable
class LocalDocumentSessionState {
  const LocalDocumentSessionState({
    required this.phase,
    this.publication,
    this.locator,
    this.error,
    this.readerReady = false,
  });

  const LocalDocumentSessionState.loading()
    : this(phase: LocalDocumentSessionPhase.loading);

  final LocalDocumentSessionPhase phase;
  final Publication? publication;
  final Locator? locator;
  final Object? error;
  final bool readerReady;

  LocalDocumentSessionState copyWith({
    LocalDocumentSessionPhase? phase,
    Publication? publication,
    Locator? locator,
    Object? error,
    bool? readerReady,
  }) => LocalDocumentSessionState(
    phase: phase ?? this.phase,
    publication: publication ?? this.publication,
    locator: locator ?? this.locator,
    error: error ?? this.error,
    readerReady: readerReady ?? this.readerReady,
  );
}

class LocalDocumentSessionCoordinator {
  Future<void> _tail = Future<void>.value();
  int _nextToken = 0;
  _DocumentOwner? _owner;

  int issueToken() => ++_nextToken;

  Future<T> _serialize<T>(Future<T> Function() operation) {
    final result = _tail.then((_) => operation());
    _tail = result.then<void>((_) {}, onError: (_, _) {});
    return result;
  }

  Future<Publication?> acquire(
    LocalDocumentSessionController controller,
    int token,
  ) => _serialize(() async {
    final previous = _owner;
    if (previous != null &&
        (previous.controller != controller || previous.token != token)) {
      await previous.controller._prepareForReplacement(previous.token);
      await previous.controller._readium.closePublication();
      previous.controller._markReplaced(previous.token);
      _owner = null;
    }

    if (!controller._isCurrent(token)) return null;

    final publication = await controller._readium.openPublication(
      Uri.file(controller.descriptor.path).toString(),
    );
    if (!controller._isCurrent(token)) {
      await controller._readium.closePublication();
      return null;
    }

    _owner = _DocumentOwner(controller, token);
    controller._bindStreams(token);
    return publication;
  });

  Future<void> release(LocalDocumentSessionController controller, int token) =>
      _serialize(() async {
        final owner = _owner;
        if (owner?.controller != controller || owner?.token != token) return;

        await controller._cancelSubscriptions();
        await controller._readium.closePublication();
        _owner = null;
      });

  Future<bool> applyEpubPreferences(
    LocalDocumentSessionController controller,
    int token,
    EPUBPreferences preferences,
  ) => _serialize(() async {
    final owner = _owner;
    if (owner?.controller != controller ||
        owner?.token != token ||
        !controller._isCurrent(token)) {
      return false;
    }
    await controller._readium.setEPUBPreferences(preferences);
    return true;
  });
}

class _DocumentOwner {
  const _DocumentOwner(this.controller, this.token);

  final LocalDocumentSessionController controller;
  final int token;
}

class LocalDocumentSessionController extends ChangeNotifier {
  LocalDocumentSessionController({
    required this.descriptor,
    LocalDocumentReadium? readium,
    LocalDocumentSessionCoordinator? coordinator,
    double initialEpubFontSize = 1.0,
    bool initialEpubScroll = false,
    Color? epubBackgroundColor,
    Color? epubTextColor,
    LocalEpubPreferencesChanged? onEpubPreferencesChanged,
  }) : _readium = readium ?? FlutterLocalDocumentReadium(),
       _coordinator = coordinator ?? defaultCoordinator,
       _epubFontSize = initialEpubFontSize.clamp(
         epubFontSizeMin,
         epubFontSizeMax,
       ),
       _epubScroll = initialEpubScroll,
       _epubBackgroundColor = epubBackgroundColor,
       _epubTextColor = epubTextColor,
       _onEpubPreferencesChanged = onEpubPreferencesChanged;

  static final LocalDocumentSessionCoordinator defaultCoordinator =
      LocalDocumentSessionCoordinator();

  static const double epubFontSizeMin = 0.5;
  static const double epubFontSizeMax = 2.0;
  static const double epubFontSizeStep = 0.1;

  final LocalDocumentDescriptor descriptor;
  final LocalDocumentReadium _readium;
  final LocalDocumentSessionCoordinator _coordinator;
  final Color? _epubBackgroundColor;
  final Color? _epubTextColor;
  final LocalEpubPreferencesChanged? _onEpubPreferencesChanged;
  final List<StreamSubscription<Object?>> _subscriptions = [];

  LocalDocumentSessionState _state = const LocalDocumentSessionState.loading();
  int? _activeToken;
  Future<void>? _openFuture;
  Future<void>? _closeFuture;
  bool _disposed = false;
  int _readerStatusGeneration = 0;
  double _epubFontSize;
  bool _epubScroll;

  LocalDocumentSessionState get state => _state;
  double get epubFontSize => _epubFontSize;
  bool get epubScroll => _epubScroll;

  Future<void> open() => _openFuture ??= _open();

  Future<void> _open() async {
    final token = _coordinator.issueToken();
    _activeToken = token;
    _setState(const LocalDocumentSessionState.loading());

    try {
      final publication = await _coordinator.acquire(this, token);
      if (publication == null || !_isCurrent(token)) return;
      _setState(
        LocalDocumentSessionState(
          phase: LocalDocumentSessionPhase.ready,
          publication: publication,
        ),
      );
    } catch (error, stackTrace) {
      logger.e(
        'Unable to open local document',
        error: error,
        stackTrace: stackTrace,
      );
      if (_isCurrent(token)) {
        _setState(
          LocalDocumentSessionState(
            phase: LocalDocumentSessionPhase.failure,
            error: error,
          ),
        );
      }
    }
  }

  Future<void> close() {
    final existing = _closeFuture;
    if (existing != null) return existing;

    final token = _activeToken;
    _activeToken = null;
    return _closeFuture = token == null ? Future<void>.value() : _close(token);
  }

  Future<void> _close(int token) async {
    await _coordinator.release(this, token);
    if (!_disposed) {
      _setState(
        _state.copyWith(
          phase: LocalDocumentSessionPhase.closed,
          readerReady: false,
        ),
      );
    }
  }

  bool _isCurrent(int token) => !_disposed && _activeToken == token;

  void _bindStreams(int token) {
    _subscriptions
      ..add(
        _readium.onReaderStatusChanged.listen((status) {
          unawaited(_handleReaderStatus(token, status));
        }),
      )
      ..add(
        _readium.onTextLocatorChanged.listen((locator) {
          if (!_isCurrent(token)) return;
          _setState(_state.copyWith(locator: locator));
        }),
      )
      ..add(
        _readium.onErrorEvent.listen((error) {
          if (!_isCurrent(token)) return;
          logger.e('Local document reader event error', error: error);
        }),
      );
  }

  Future<void> _handleReaderStatus(
    int token,
    ReadiumReaderStatus status,
  ) async {
    if (!_isCurrent(token)) return;
    final statusGeneration = ++_readerStatusGeneration;
    if (!status.isReady) {
      if (status.isLoading ||
          status == ReadiumReaderStatus.closed ||
          status == ReadiumReaderStatus.error) {
        _setState(_state.copyWith(readerReady: false));
      }
      return;
    }

    _setState(_state.copyWith(readerReady: false));
    try {
      final applied = await _applyEpubPreferences();
      if (!applied ||
          !_isCurrent(token) ||
          statusGeneration != _readerStatusGeneration) {
        return;
      }
      _setState(_state.copyWith(readerReady: true));
    } catch (error, stackTrace) {
      logger.e(
        'Unable to restore local EPUB preferences',
        error: error,
        stackTrace: stackTrace,
      );
      if (_isCurrent(token) && statusGeneration == _readerStatusGeneration) {
        // Keep the publication navigable even if the native preference bridge
        // rejects an otherwise readable EPUB.
        _setState(_state.copyWith(readerReady: true));
      }
    }
  }

  Future<void> _cancelSubscriptions() async {
    await Future.wait(
      _subscriptions.map((subscription) => subscription.cancel()),
    );
    _subscriptions.clear();
  }

  Future<void> _prepareForReplacement(int token) async {
    if (_activeToken == token) _activeToken = null;
    await _cancelSubscriptions();
  }

  void _markReplaced(int token) {
    if (_disposed) return;
    if (_activeToken == token) _activeToken = null;
    _setState(
      _state.copyWith(
        phase: LocalDocumentSessionPhase.closed,
        readerReady: false,
      ),
    );
  }

  Future<void> goBackward() => _readium.goBackward();
  Future<void> goForward() => _readium.goForward();

  Future<bool> goToProgression(double progression) =>
      _readium.goToProgression(progression.clamp(0.0, 1.0));

  Future<bool> goToPdfPage(int page) async {
    final publication = _state.publication;
    final total = publication?.metadata.numberOfPages;
    if (publication == null || total == null || total < 1) return false;

    final target = page.clamp(1, total);
    final progression = total == 1 ? 0.0 : (target - 1) / (total - 1);
    return _readium.goToProgression(progression);
  }

  Future<bool> goToTocLink(Link link) async {
    final locator = _state.publication?.locatorFromLink(link);
    return locator != null && await _readium.goToLocator(locator);
  }

  Future<bool> goToAdjacentToc(int delta) async {
    final publication = _state.publication;
    final locator = _state.locator;
    if (publication == null || locator == null) return false;

    final toc = publication.tocFlattened;
    if (toc.isEmpty) return false;
    final currentPath = locator.href.split(RegExp('[#?]')).first;
    var index = toc.indexWhere(
      (link) => link.href.split(RegExp('[#?]')).first == currentPath,
    );
    if (index < 0) index = delta > 0 ? -1 : toc.length;
    final target = index + delta;
    if (target < 0 || target >= toc.length) return false;
    return goToTocLink(toc[target]);
  }

  Future<void> decreaseEpubFontSize() =>
      setEpubFontSize(_epubFontSize - epubFontSizeStep);

  Future<void> increaseEpubFontSize() =>
      setEpubFontSize(_epubFontSize + epubFontSizeStep);

  Future<void> resetEpubFontSize() => setEpubFontSize(1.0);

  Future<void> setEpubFontSize(double value) async {
    final previous = _epubFontSize;
    _epubFontSize = value.clamp(epubFontSizeMin, epubFontSizeMax);
    try {
      if (!await _applyEpubPreferences()) {
        _epubFontSize = previous;
        return;
      }
      await _onEpubPreferencesChanged?.call(_epubFontSize, _epubScroll);
      _notify();
    } catch (_) {
      _epubFontSize = previous;
      rethrow;
    }
  }

  Future<void> toggleEpubScroll() async {
    final previous = _epubScroll;
    _epubScroll = !_epubScroll;
    try {
      if (!await _applyEpubPreferences()) {
        _epubScroll = previous;
        return;
      }
      await _onEpubPreferencesChanged?.call(_epubFontSize, _epubScroll);
      _notify();
    } catch (_) {
      _epubScroll = previous;
      rethrow;
    }
  }

  Future<bool> _applyEpubPreferences() {
    if (descriptor.format != LocalDocumentFormat.epub) {
      return Future<bool>.value(true);
    }
    final token = _activeToken;
    if (token == null) return Future<bool>.value(false);
    return _coordinator.applyEpubPreferences(
      this,
      token,
      EPUBPreferences(
        backgroundColor: _epubBackgroundColor,
        fontSize: _epubFontSize,
        scroll: _epubScroll,
        textColor: _epubTextColor,
      ),
    );
  }

  void _setState(LocalDocumentSessionState state) {
    _state = state;
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    unawaited(close());
    super.dispose();
  }
}
