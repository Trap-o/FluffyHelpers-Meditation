import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/user.dart';

class UserService {
  Future<void> saveUsers(List<User> users) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.json');
    String jsonUsers = jsonEncode(users);
    file.writeAsString(jsonUsers);
  }

  Future<void> addUser(User newUser) async {
    List<User> users = await loadUsers();
    bool userExists = users.any((user) => user.email == newUser.email);

    if (!userExists) {
      users.add(newUser);
      await saveUsers(users);
    } else {
      throw Exception("Користувач з такою поштою вже існує");
    }
  }

  Future<List<User>> loadUsers() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.json');
    if (await file.exists()) {
      String contents = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(contents);
      return jsonData.map((user) => User.fromJson(user)).toList();
    }
    return [];
  }

  Future<User?> getUserByEmailPassword(String email, String password) async {
    List<User> users = await loadUsers();
    for (var user in users) {
      if (user.email == email && user.password == password) {
        return user;
      }
    }
    return null;
  }
}