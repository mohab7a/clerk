class UserModel {
  String uId;
  String email;
  String name;
  String password;
  String userImage;
  String userName;

  UserModel(
      {this.uId,
      this.email,
      this.name,
      this.password,
      this.userImage,
      this.userName});

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json["uid"];
    email = json["email"];
    name = json["name"];
    password = json["password"];
    userImage = json["userImage"];
    userName = json["userName"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uId,
      'name': name,
      'email': email,
      "userImage": userImage,
      "userName": userName,
      "password": password,
    };
  }
}
