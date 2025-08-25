class Influencer {
  final int id;
  final String name;
  final String image;
  final String gender;

  Influencer({
    required this.id,
    required this.name,
    required this.image,
    required this.gender,
  });

  factory Influencer.fromJson(Map<String, dynamic> json) {
    return Influencer(
      id:
          (json['id'] ?? 0) is String
              ? int.tryParse(json['id']) ?? 0
              : (json['id'] ?? 0),
      name: (json['name'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      gender: (json['gender'] ?? '').toString(),
    );
  }
}
