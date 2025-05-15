import 'package:fresh_dio/fresh_dio.dart';
import 'package:openid_client/openid_client.dart';

class OIDAuthToken extends OAuth2Token {
  OIDAuthToken({
    required super.accessToken,
    super.tokenType,
    super.refreshToken,
    super.expiresIn,
    required this.idToken,
    DateTime? expiresAt,
  }) : _expiresAt =
           expiresAt ??
           (expiresIn != null
               ? DateTime.now().add(Duration(seconds: expiresIn))
               : null);

  final String idToken;
  final DateTime? _expiresAt;

  Duration? get toExpiry => _expiresAt?.difference(DateTime.now());
  bool? get isExpired {
    final exp = toExpiry;

    if (exp == null) {
      return null;
    }

    return exp.inSeconds <= 0;
  }

  factory OIDAuthToken.fromTokenResponse(TokenResponse resp) {
    if (resp.accessToken == null) {
      throw Exception("Invalid token");
    }

    return OIDAuthToken(
      accessToken: resp.accessToken!,
      tokenType: resp.tokenType,
      refreshToken: resp.refreshToken,
      expiresIn: resp.expiresIn?.inSeconds,
      idToken: resp.idToken.toCompactSerialization(),
      expiresAt: resp.expiresAt,
    );
  }
}
