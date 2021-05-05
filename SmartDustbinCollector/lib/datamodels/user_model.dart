class UserModel {
  String email;
  String token;
  String id;

  UserModel({
    this.email,
    this.token,
    this.id,
  });

  UserModel.fromJson(Map<String, dynamic> m) {
    email = m["email"];
    token = m["token"];
    id = m['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "token":token,
      "id": id,
    };
  }
}
