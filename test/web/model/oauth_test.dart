import 'package:flutter_test/flutter_test.dart';
import 'package:gagaku/web/model/oauth.dart';
import 'package:gagaku/web/model/types.dart';

OAuthButtonRowElement _row({
  required String authorizeEndpoint,
  OAuthResponseType responseType = const OAuthResponseType.token(),
  String? clientId,
  String? redirectUri,
  List<String>? scopes,
}) => OAuthButtonRowElement(
  id: 'login',
  isHidden: false,
  title: 'Log In',
  onSuccess: 'selector-1',
  authorizeEndpoint: authorizeEndpoint,
  responseType: responseType,
  clientId: clientId,
  redirectUri: redirectUri,
  scopes: scopes,
);

void main() {
  // The props AniList 1.0.0-alpha.19 publishes (observed in Phase 0).
  const aniListEndpoint =
      'https://anilist.co/api/v2/oauth/authorize?client_id=6621&response_type=token';
  final aniListRow = _row(authorizeEndpoint: aniListEndpoint, clientId: '6621');
  final source = WebSourceInfo(
    id: 'AniList',
    name: 'AniList',
    repo: 'tracker-fixture',
    icon: '',
  );

  group('PaperbackOAuth token flow', () {
    test('uses an endpoint that already carries its parameters unchanged', () {
      expect(
        PaperbackOAuth.tokenFlowAuthorizationUri(aniListRow).toString(),
        aniListEndpoint,
      );
    });

    test('adds only declared parameters the endpoint lacks', () {
      final uri = PaperbackOAuth.tokenFlowAuthorizationUri(
        _row(
          authorizeEndpoint: 'https://tracker.example/authorize',
          clientId: 'client-1',
          redirectUri: 'paperback://tracker-callback',
          scopes: ['read', 'write'],
        ),
      );

      expect(uri.queryParameters, {
        'response_type': 'token',
        'client_id': 'client-1',
        'redirect_uri': 'paperback://tracker-callback',
        'scope': 'read write',
      });
    });

    test('never sends the default redirect', () {
      final uri = PaperbackOAuth.tokenFlowAuthorizationUri(
        _row(
          authorizeEndpoint: 'https://tracker.example/authorize',
          clientId: 'client-1',
        ),
      );

      expect(uri.queryParameters.containsKey('redirect_uri'), isFalse);
      expect(
        PaperbackOAuth.redirectUri(source, aniListRow).host,
        'anilist-login',
      );
    });

    test('reads the access token from the redirect fragment', () {
      final callback = Uri.parse(
        'paperback://anilist-login#access_token=fictional.jwt.token'
        '&token_type=Bearer&expires_in=31536000',
      );

      expect(
        PaperbackOAuth.accessTokenFromCallback(callback),
        'fictional.jwt.token',
      );
      expect(PaperbackOAuth.tokenFlowSuccessArguments('fictional.jwt.token'), [
        'fictional.jwt.token',
        'fictional.jwt.token',
      ]);
    });

    test('accepts a query token, with the fragment taking precedence', () {
      expect(
        PaperbackOAuth.accessTokenFromCallback(
          Uri.parse('paperback://tracker-callback?access_token=query-token'),
        ),
        'query-token',
      );
      expect(
        PaperbackOAuth.accessTokenFromCallback(
          Uri.parse(
            'paperback://tracker-callback?access_token=query-token'
            '#access_token=fragment-token',
          ),
        ),
        'fragment-token',
      );
    });

    test('reports provider errors and missing tokens', () {
      expect(
        () => PaperbackOAuth.accessTokenFromCallback(
          Uri.parse(
            'paperback://anilist-login#error=access_denied'
            '&error_description=The%20user%20denied%20access',
          ),
        ),
        throwsA(
          isA<OAuthProviderError>()
              .having((e) => e.error, 'error', 'access_denied')
              .having(
                (e) => e.description,
                'description',
                'The user denied access',
              ),
        ),
      );
      expect(
        () => PaperbackOAuth.accessTokenFromCallback(
          Uri.parse('paperback://anilist-login'),
        ),
        throwsA(isA<OAuthMissingAccessToken>()),
      );
    });
  });

  test('preserves code-flow endpoint parameters', () {
    final row = _row(
      authorizeEndpoint: 'https://tracker.example/authorize?audience=api',
      responseType: const OAuthResponseType.code(
        tokenEndpoint: 'https://tracker.example/token',
      ),
    );

    expect(PaperbackOAuth.endpointParameters(row), {'audience': 'api'});
  });
}
