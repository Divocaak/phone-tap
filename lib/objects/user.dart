class User {
  String username;
  String token;

  User(this.username, this.token);

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(json["phone"], json["token"]);
  }
}
