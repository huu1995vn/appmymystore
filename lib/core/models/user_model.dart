class UserModel {
  late String username = "";
  late String password = "";
  late String phone = "";
  UserModel();
  UserModel.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'phone': phone,
      };
}
