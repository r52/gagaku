import 'package:gagaku/web/model/types.dart';

/// Why a Paperback OAuth redirect could not produce credentials.
sealed class OAuthCallbackException implements Exception {
  const OAuthCallbackException();
}

/// The provider redirected with an OAuth `error` response.
final class OAuthProviderError extends OAuthCallbackException {
  const OAuthProviderError({required this.error, this.description});

  final String error;
  final String? description;

  @override
  String toString() => description == null || description!.isEmpty
      ? error
      : '$error: $description';
}

/// The redirect carried neither an access token nor an OAuth error.
final class OAuthMissingAccessToken extends OAuthCallbackException {
  const OAuthMissingAccessToken();

  @override
  String toString() => 'access_token missing from OAuth redirect';
}

/// Request and callback handling for Paperback `OAuthButtonRow` flows.
///
/// Every input comes from the extension's row props; Gagaku adds no
/// per-extension client ids, endpoints, or redirect overrides.
abstract final class PaperbackOAuth {
  /// The extension's redirect, or Gagaku's `paperback://<source id>-login`
  /// default. `PBLinkDelegate` handlers are keyed by its host.
  static Uri redirectUri(WebSourceInfo source, OAuthButtonRowElement element) =>
      Uri.parse(element.redirectUri ?? 'paperback://${source.id}-login');

  /// Implicit-grant (`type: 'token'`) authorization URL.
  ///
  /// The extension's `authorizeEndpoint` is used as given. Parameters the row
  /// declares separately are added only when the endpoint lacks them; the
  /// default redirect is never sent, because providers such as AniList match
  /// the client's registered redirect exactly.
  static Uri tokenFlowAuthorizationUri(OAuthButtonRowElement element) {
    final endpoint = Uri.parse(element.authorizeEndpoint);
    final params = Map<String, String>.of(endpoint.queryParameters);
    var changed = false;

    void addIfAbsent(String key, String? value) {
      if (value == null || value.isEmpty || params.containsKey(key)) {
        return;
      }
      params[key] = value;
      changed = true;
    }

    addIfAbsent('response_type', 'token');
    addIfAbsent('client_id', element.clientId);
    addIfAbsent('redirect_uri', element.redirectUri);
    addIfAbsent('scope', element.scopes?.join(' '));

    // Re-encoding the query is avoided unless something was added.
    return changed ? endpoint.replace(queryParameters: params) : endpoint;
  }

  /// Parameters from an OAuth redirect. Implicit grants return them in the
  /// fragment; providers that use the query are accepted too, with fragment
  /// values taking precedence.
  static Map<String, String> callbackParameters(Uri callback) => {
    ...callback.queryParameters,
    if (callback.fragment.isNotEmpty)
      ...Uri.splitQueryString(callback.fragment),
  };

  /// The access token from an implicit-grant redirect.
  static String accessTokenFromCallback(Uri callback) {
    final params = callbackParameters(callback);
    final error = params['error'];
    if (error != null && error.isNotEmpty) {
      throw OAuthProviderError(
        error: error,
        description: params['error_description'],
      );
    }

    final accessToken = params['access_token'];
    if (accessToken == null || accessToken.isEmpty) {
      throw const OAuthMissingAccessToken();
    }
    return accessToken;
  }

  /// `onSuccess` arguments for the token flow.
  ///
  /// The callback is declared `(refreshToken, accessToken)`, but the token
  /// flow has no refresh token and extensions read the access token from the
  /// first argument (AniList's `handleLoginSuccess(accessToken)`); it is
  /// passed in both positions.
  static List<String> tokenFlowSuccessArguments(String accessToken) => [
    accessToken,
    accessToken,
  ];

  /// Query parameters already present on a code/PKCE `authorizeEndpoint`.
  ///
  /// openid_client rebuilds the authorization URL with
  /// `Uri.replace(queryParameters:)`, which would otherwise drop them; the
  /// flow's own parameters still take precedence.
  static Map<String, String> endpointParameters(
    OAuthButtonRowElement element,
  ) => Uri.parse(element.authorizeEndpoint).queryParameters;
}
