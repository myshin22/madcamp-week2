import 'package:week2/api/util_server.dart';
import 'package:week2/model/request_model.dart';
import 'package:week2/model/userProfile_model.dart';

Future<List<UserProfile>> getCelebrity(String googleId) async {
  final bodyJson = await fetchPost("celebrity/get", {
    'googleId': googleId,
  });
  return UserProfile.listFromJson(bodyJson);
}

Future<List<UserProfile>> getFan(String googleId) async {
  final bodyJson = await fetchPost("fan/get", {
    'googleId': googleId,
  });
  return UserProfile.listFromJson(bodyJson);
}

Future<void> removeCelebrity(String googleId, String celebrityId) async {
  await fetchPost(
      "celebrity/remove", {'googleId': googleId, "userId": celebrityId});
}

Future<void> removeFan(String googleId, String fanId) async {
  await fetchPost("fan/remove", {'googleId': googleId, "userId": fanId});
}

Future<RequestProfile> sendCelebrityRequest(
    String googleId, String fanId) async {
  final body =
      await fetchPost("request/send", {'googleId': googleId, "userId": fanId});
  return RequestProfile.fromJson(body);
}

Future<List<RequestProfile>> receiveCelebrityRequest(String googleId) async {
  final body = await fetchPost("request/receive", {
    'googleId': googleId,
  });
  return RequestProfile.listFromJson(body);
}

Future<RequestProfile> replyCelebrityRequest(
    String googleId, String fanId, bool accept) async {
  final body = await fetchPost("request/reply",
      {'googleId': googleId, "userId": fanId, "accept": accept});
  return RequestProfile.fromJson(body);
}
