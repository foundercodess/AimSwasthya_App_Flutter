import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserViewModel {
  Future<bool> saveUser(int userId,) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('token', userId);
    return true;
  }
  Future<dynamic> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    dynamic token = sp.getInt('token');
    return token;
  }
  Future<bool> remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }

  Future<bool> saveBeToken(String beToken) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('bToken', beToken);
    return true;
  }
  Future<String?> getBeToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('bToken')??'';
    return token;
  }
  Future<bool> removeBe() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('bToken');
    return true;
  }

  Future<bool> saveRole(int role,) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt('role',role);
    return true;
  }

  Future<int?> getRole() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    int? token = sp.getInt('role');
    return token;
  }

  Future<bool> removeRole() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('role');
    return true;
  }
}