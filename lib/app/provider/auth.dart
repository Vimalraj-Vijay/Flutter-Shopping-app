import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/utils/custom_exception.dart';

import '../../utils/api_constants.dart';

class Auth with ChangeNotifier {
  String _userToken = "";
  String _userId = "";
  DateTime? _expiryDate;
  Timer? _authTimer;

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

  Future<bool> tryAutoLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    if (!sharedPref.containsKey("key_userdata")) {
      return false;
    }
    final extractedUserData =
        json.decode(sharedPref.getString("key_userdata").toString())
            as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData["expiryDate"]);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _userToken = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    autoLogOutTimer();
    return true;
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
      autoLogOutTimer();
      notifyListeners();
      final sharedPref = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _userToken,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String()
      });
      sharedPref.setString("key_userdata", userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    _userToken = "";
    _userId = "";
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    notifyListeners();
  }

  void autoLogOutTimer() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timeToExpire = _expiryDate?.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpire!), () {
      logout();
    });
  }
}
