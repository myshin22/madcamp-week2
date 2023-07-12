class UserProfile {
  final String id;
  final String name;
  final String profilePhoto;
  final String coverPhoto;
  final String explanation;
  final String facebookId;
  final String instagramId;
  final String twitterId;
  final DateTime? deletedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile(
      {required this.id,
      required this.name,
      required this.profilePhoto,
      required this.coverPhoto,
      required this.explanation,
      required this.facebookId,
      required this.instagramId,
      required this.twitterId,
      required this.deletedAt,
      required this.createdAt,
      required this.updatedAt});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
        id: json['id'],
        name: json['name'],
        profilePhoto: json['profilePhoto'],
        coverPhoto: json['coverPhoto'],
        explanation: json['explanation'],
        facebookId: json['facebookId'],
        instagramId: json['instagramId'],
        twitterId: json['twitterId'],
        deletedAt: (json['deletedAt'] != null)
            ? DateTime.parse(json['deletedAt'])
            : null,
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']));
  }

  static List<UserProfile> listFromJson(json) {
    return List<UserProfile>.from(json.map((one) => UserProfile.fromJson(one)));
  }
}
