class UserModel {
  final int id;
  final String name;
  final String email;
  final String address;
  final String visa;
  final String image;
  final String? token; // ✅ أضفنا التوكن هنا

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.visa,
    required this.image,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      visa: json['visa'] ?? '',
      image: json['image'] ?? '',
      token: json['access_token'] ?? json['token'], // ✅ هنا نقرأ التوكن
    );
  }
}