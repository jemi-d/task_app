import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tf1/datamodel/Task.dart';


class AuthService{

  static final storage = FlutterSecureStorage();

  // Save credentials
  static Future<void> saveUser(String email, String password, String name) async {
    await storage.write(key: 'email', value: email);
    await storage.write(key: 'password', value: password);
    await storage.write(key: 'username', value: name);
    await storage.write(key: 'isLoggedIn', value: 'true'); // Mark user as logged in
  }

  // Check if user is registered
  static Future<bool> isUserRegistered(String email, String password) async {
    String? storedEmail = await storage.read(key: 'email');
    String? storedPassword = await storage.read(key: 'password');

    return storedEmail == email && storedPassword == password;
  }

  // Check if user is already logged in
  static Future<bool> isLoggedIn() async {
    String? status = await storage.read(key: 'isLoggedIn');
    return status == 'true';
  }

  // Get User Details
  static Future<UserDetail?> getUserData() async {
    String? storedEmail = await storage.read(key: 'email');
    String? storedName = await storage.read(key: 'username');
    return UserDetail(name: storedName!, email: storedEmail!);
  }

  // Logout user
  static Future<void> logout() async {
    await storage.write(key: 'isLoggedIn', value: 'false');
    await storage.delete(key: 'email');
    await storage.delete(key: 'username');
    await storage.delete(key: 'password');
  }
}