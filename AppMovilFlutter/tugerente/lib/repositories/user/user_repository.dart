import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugerente/connection/http.dart';
import 'package:tugerente/models/user_model.dart';
import 'package:tugerente/preferencias_usuario/preferencias_usuario.dart';

class UserRepository {
  final _prefs = new PreferenciasUsuario();
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    var data = {'email': username, 'password': password};
    var res = await Http().login(data, 'login');
    var body = json.decode(res.body);

    var token = body['access_token'];
    return token;
  }

  Future<bool> register({
    @required String username,
    @required String password,
    @required String email,
  }) async {
    var data = {'name': username, 'email': email, 'password': password};
    var res = await Http().login(data, 'register');
    var body = json.decode(res.body);

    var token = body['success'];
    return token;
  }

  Future getusers() async {
    var resp = await Http().gets('getusers');
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<User> users = new List();

    if (decodedData == null) return [];

    if (decodedData['error'] != null) return [];
    var data = decodedData['data'];
    data.forEach((element) {
      var a = element['id'];
      final userTemp = User.fromJson(element);
      userTemp.usercode = a;

      users.add(userTemp);
    });
    return users;

    // var token = body['access_token'];
  }

  Future<User> getuser() async {
    var resp = await Http().gets('getuser');
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final User users = new User();

    var data = decodedData['data'];
    final userTemp = User.fromJson(data);
    users.email = userTemp.email;
    users.name = userTemp.name;
    return users;

    // var token = body['access_token'];
  }

  Future<dynamic> addGroup({
    @required int usercode,
    @required int groupcode,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    var data = {'groupcode': groupcode, 'usercode': usercode, 'token': token};
    var res = await Http().post(data, 'adduser');
    var body = json.decode(res.body);
    return body;
    // var token = body['access_token'];
  }

  Future<dynamic> deleteToken() async {
    /// delete from keystore/keychain
    var res = await Http().logout('logout');
    var body = json.decode(res.body);

    var token = body['message'];
    return token;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    _prefs.token = token;
    //sadasd
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
