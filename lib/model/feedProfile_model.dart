import 'package:week2/model/userProfile_model.dart';

class FeedProfile {
  final String id;
  final String photo;
  final String content;
  final UserProfile author;
  final List<UserProfile> taggedUsers;

  FeedProfile({
    required this.id,
    required this.photo,
    required this.content,
    required this.author,
    required this.taggedUsers,
  });

  factory FeedProfile.fromJson(Map<String, dynamic> json) {
    return FeedProfile(
        id: json['id'],
        photo: json['photo'],
        content: json['content'],
        author: UserProfile.fromJson(json['author']),
        taggedUsers: UserProfile.listFromJson(json['taggedUsers']));
  }

  static List<FeedProfile> listFromJson(json) {
    return List<FeedProfile>.from(json.map((one) => FeedProfile.fromJson(one)));
  }
}