import 'package:flutter/material.dart';
import 'package:task_manager/models/userModel.dart' as user_model;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  user_model.User? _user;
  user_model.User? get user => _user;

  // Sign up with email, password, and name
  Future<bool> signUp(String name, String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', name);
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      _user = user_model.User(uid: 'unique_id', name: name, email: email, password: password);
      notifyListeners();
      return true;
    } catch (error) {
      // Handle sign up errors
      print("Sign up error: $error");
      return false;
    }
  }

  // Sign in with email and password
  Future<bool> signIn(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final storedEmail = prefs.getString('email');
      final storedPassword = prefs.getString('password');
      final storedName = prefs.getString('name');
      print('${storedPassword} ${storedEmail}');
      if (storedEmail == email && storedPassword == password) {
        _user = user_model.User(uid: 'unique_id', name: storedName.toString(), email: email, password: password);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      // Handle sign in errors
      print("Sign in error: $error");
      return false;
    }
  }

  // Delete
  Future<void> Delete() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
      await prefs.remove('password');
      _user = null;
      notifyListeners();
    } catch (error) {
      // Handle sign out errors
      print("Delete error: $error");
    }
  }
}
