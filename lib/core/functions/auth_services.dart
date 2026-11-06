import 'package:oauth2_client/github_oauth2_client.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/services/shared_preferences_services.dart';

import 'package:http/http.dart' as http;

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  // Google OAuth Config
  final OAuth2Helper _googleAuth = OAuth2Helper(
    GoogleOAuth2Client(
      redirectUri: '$baseUri/auth/google/callback',
      customUriScheme: 'http',
    ),
    grantType: OAuth2Helper.authorizationCode,
    clientId: gci,
    clientSecret: gwi,
    scopes: ["email", "profile", "openid"],
  );

  // GitHub OAuth Config
  final OAuth2Helper _githubAuth = OAuth2Helper(
    GitHubOAuth2Client(
      redirectUri: "$baseUri/auth/github/callback",
      customUriScheme: "http",
    ),
    grantType: OAuth2Helper.authorizationCode,
    clientId: ghci,
    clientSecret: ghscr,
    scopes: ["user"],
  );

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      final token = await _googleAuth.fetchToken();
      await SharedPreferencesServices.setUserToken(token.accessToken!);
      final response = await http.post(
        Uri.parse('$baseUri/auth/google/token/google'),
        body: {'access_token': token.accessToken},
      );

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {}
  }

  // GitHub Sign-In
  Future<void> signInWithGitHub() async {
    try {
      final token = await _githubAuth.fetchToken();
      await SharedPreferencesServices.setUserToken(token.accessToken!);
      final response = await http.post(
        Uri.parse('$baseUri/auth/google/token/githup'),
        body: {'access_token': token.accessToken},
      );

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {}
  }

  // Sign Out (Clears Tokens)
  Future<void> googleSignOut() async {
    await _googleAuth.disconnect();
  }

  Future<void> githupSignOut() async {
    await _githubAuth.disconnect();
  }
}
