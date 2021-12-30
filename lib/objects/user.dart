class User {
  int id;
  String username;
  String token;

  User(this.id, this.username, this.token);

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(int.parse(json["id"]), json["phone"], json["token"]);
  }
}
