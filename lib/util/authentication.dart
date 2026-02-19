import 'package:fresh_dio/fresh_dio.dart';
import 'package:openid_client/openid_client.dart';

class OIDAuthToken extends OAuth2Token {
  OIDAuthToken({
    required super.accessToken,
    super.tokenType,
    super.refreshToken,
    required this.idToken,
    int? expiresIn,
    DateTime? expiresAt,
  }) : super(
         issuedAt: DateTime.now(),
         expiresIn:
             expiresIn ?? expiresAt?.difference(DateTime.now()).inSeconds,
       );

  final String idToken;

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
