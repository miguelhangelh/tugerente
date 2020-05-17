import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Http {
  final String _url = 'http://192.168.31.172/api/';

  var token;
  _getToken() async {
    final prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
  }

  Future<dynamic> post(data, url) async {
    var fullUrl = _url + url;
    await _getToken();

    var response = await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    return response;
  }

  Future<dynamic> login(data, url) async {
    var fullUrl = _url + url;
    await _getToken();

    var response = await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
    return response;
  }

  Future<dynamic> logout(url) async {
    var fullUrl = _url + url;
    await _getToken();

    var response = await http.post(
      fullUrl,
      headers: _setHeaders(),
    );
    return response;
  }

  Future gets(url) async {
    var fullUrl = _url + url;
    await _getToken();
    var response = await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
    return response;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}
