class UserModel {
  String id;
  String email;
  String name;
  String address;
  String token;
  double dustbinHeight;

  UserModel({
    this.id,
    this.email,
  });

  UserModel.fromJson(Map<String, dynamic> m) {
    id = m["id"];
    email = m["email"];
    name = m['name'];
    address = m['address'];
    token = m["token"];
    dustbinHeight = m["height"].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "address": address,
      "token":token,
      "height": dustbinHeight,
    };
  }
}
