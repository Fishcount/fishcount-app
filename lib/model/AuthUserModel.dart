class AuthUserModel {
  late int id;
  late String username;
  late String password;
  late String token;
  late int personId;

  AuthUserModel(
    this.username,
    this.password,
  );

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    token = json['token'];
    personId = json['pessoaId'];
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
