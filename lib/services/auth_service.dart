import 'package:flutter_recipe_app/services/http_service.dart';
import '../models/user.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();

// create an instance of the http service
  final _httpService = HTTPService();

  // create a user variable
  User? user;

  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  Future<bool> login(String username, String password) async {
    // print("username: $username, password: $password");
    try {
      var response = await _httpService
          .post("auth/login", {"username": username, "password": password});
      if (response?.statusCode == 200 && response?.data != null) {
        user = User.fromJson(response!.data);
        // print(user!.email);

        // update the service
        HTTPService().setup(bearerToken: user!.token);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
