import 'package:week2/api/util_server.dart';
import 'package:week2/model/bookmark_model.dart';
import 'package:week2/model/userProfile_model.dart';

Future<UserProfile> createUser(
    String googleId,
    String name,
    String profilePhoto,
    String coverPhoto,
    String explanation,
    String instagramId,
    String facebookId,
    String twitterId) async {
  final bodyJson = await fetchPost("user/set", {
    'googleId': googleId,
    "name": name,
    "profilePhoto": profilePhoto,
    "coverPhoto": coverPhoto,
    "explanation": explanation,
    "instagramId": instagramId,
    "facebookId": facebookId,
    "twitterId": twitterId,
  });
  return UserProfile.fromJson(bodyJson);
}

Future<UserProfile> updateUser(
    String googleId,
    String name,
    String profilePhoto,
    String coverPhoto,
    String explanation,
    String instagramId,
    String facebookId,
    String twitterId) async {
  final bodyJson = await fetchPost("user/update", {
    'googleId': googleId,
    "name": name,
    "profilePhoto": profilePhoto,
    "coverPhoto": coverPhoto,
    "explanation": explanation,
    "instagramId": instagramId,
    "facebookId": facebookId,
    "twitterId": twitterId,
  });
  return UserProfile.fromJson(bodyJson);
}

Future<UserBookmark> getBookmark(String googleId) async {
  final bodyJson = await fetchPost("user/bookmark", {'googleId': googleId});
  return UserBookmark.fromJson(bodyJson);
}

Future<QRLogin> getNaverAuth(String googleId) async {
  final bodyJson = await fetchPost("user/naver", {'googleId': googleId});
  return QRLogin.fromJson(bodyJson);
}
