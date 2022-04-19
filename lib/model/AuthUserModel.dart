class AuthUserModel {
  late int id;
  late String username;
  late String password;
  late String token;

  AuthUserModel(
    this.username,
    this.password,
  );

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
