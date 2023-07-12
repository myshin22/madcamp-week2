import 'package:week2/api/util_server.dart';
import 'package:week2/model/feedProfile_model.dart';

Future<List<FeedProfile>> getPost(String googleId, bool written, bool tagged,
    bool liked, bool celebrityWritten) async {
  Iterable bodyJson = await fetchPost("feed", {
    'googleId': googleId,
    "written": written,
    "tagged": tagged,
    "liked": liked,
    "celebrityWritten": celebrityWritten
  });
  return FeedProfile.listFromJson(bodyJson);
}

Future<FeedProfile> createPost(String googleId, String photo, String content,
    List<String> taggedUserIds) async {
  final bodyJson = await fetchPost("feed/create", {
    'googleId': googleId,
    "photo": photo,
    "content": content,
    "taggedUserIds": taggedUserIds,
  });
  return FeedProfile.fromJson(bodyJson);
}

Future<FeedProfile> updatePost(String googleId, String feedId, String photo,
    String content, List<String> taggedUserIds) async {
  final bodyJson = await fetchPost("feed/update", {
    'googleId': googleId,
    "feedId": feedId,
    "photo": photo,
    "content": content,
    "taggedUserIds": taggedUserIds,
  });
  return FeedProfile.fromJson(bodyJson);
}

Future<void> deletePost(String googleId, String feedId) async {
  await fetchPost("feed/delete", {
    'googleId': googleId,
    "feedId": feedId,
  });
}

Future<void> likePost(String googleId, String feedId, bool isLiked) async {
  await fetchPost("feed/like",
      {'googleId': googleId, "feedId": feedId, "isLiked": isLiked});
}
