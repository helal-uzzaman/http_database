class Profile {
  final String name;
  final int age;
  final String address;

  const Profile({
    required this.name,
    required this.age,
    required this.address,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      age: json['age'],
      address: json['address'],
    );
  }
}
