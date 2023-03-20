class Users{
  String name;
  String username;
  String password;
  String email;
  String no_hp;
  String birthday;
  String gender;

  Users({
    required this.name,
    required this.username,
    required this.password,
    required this.email,
    required this.no_hp,
    required this.birthday,
    required this.gender,
});

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["username"] = this.username;
    data["password"] = this.password;
    data["email"] = this.email;
    data["no_hp"] = this.no_hp;
    data["birthday"] = this.birthday;
    data["gender"] = this.gender;
    return data;
  }

}