class AuthUserModel {
  late String username;
  late String password;

  AuthUserModel(
    this.username,
    this.password,
  );

  AuthUserModel.fromJson(Map<String, dynamic> parsedJson) {
    username = parsedJson['username'];
    password = parsedJson['password'];
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
