class User {
  final String id;
  final String iconUrl;
  final String name;
  final String description;
  final int followeescount;
  final int followerscount;

  User(
      {required this.id,
      required this.iconUrl,
      required this.name,
      required this.description,
      required this.followeescount,
      required this.followerscount});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      iconUrl: json['profile_image_url'],
      name: json['name'] ?? '未設定',
      description: json['description'] ?? '未設定',
      followeescount: json['followees_count'],
      followerscount: json['followers_count'],
    );
  }
}
