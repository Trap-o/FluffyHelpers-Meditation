// class User {
//   String email;
//   String password;
//   String name;
//
//   User({required this.email, required this.password, required this.name});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       email: json['email'],
//       password: json['password'],
//       name: json['name'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'email': email,
//       'password': password,
//       'name': name,
//     };
//   }
// }