import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app/utils/custom_exception.dart';

import '../../utils/api_constants.dart';

class Auth with ChangeNotifier {
  String _userToken = "";
  String _userId = "";
  DateTime? _expiryDate;

  String get token {
    if (_userToken.isNotEmpty && _expiryDate?.isAfter(DateTime.now()) == true) {
      return _userToken;
    }
    return "";
  }

  String get userId {
    return _userId;
  }

  bool get isAuth {
    return token.isNotEmpty;
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, ApiConstants.authSignupKey);
  }

  Future<void> login(String email, String password) async {
    return authenticate(email, password, ApiConstants.authLoginKey);
  }

  Future<void> authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        "${ApiConstants.authUrl}$urlSegment${ApiConstants.firebaseKey}");
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw CustomException(responseData['error']['message']);
      }
      _userToken = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
