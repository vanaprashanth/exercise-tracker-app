class UserModel {
  final String username;
  final String name;
  final String gender;
  final String age;
  final String weight;
  final String height;

  UserModel({
    required this.username,
    required this.name,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
  });

  List<String> toList() {
    return [name, gender, age, weight, height];
  }

  factory UserModel.fromList(String username, List<String> list) {
    return UserModel(
      username: username,
      name: list[0],
      gender: list[1],
      age: list[2],
      weight: list[3],
      height: list[4],
    );
  }
}
