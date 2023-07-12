class RequestProfile {
  final String id;
  final String fanId;
  final String celebrityId;
  final bool pending;
  final bool accept;

  RequestProfile(
      {required this.id,
      required this.fanId,
      required this.celebrityId,
      required this.pending,
      required this.accept});

  factory RequestProfile.fromJson(Map<String, dynamic> json) {
    return RequestProfile(
        id: json['id'],
        fanId: json['fanId'],
        celebrityId: json['celebrityId'],
        pending: json['pending'],
        accept: json['accept']);
  }

  static List<RequestProfile> listFromJson(json) {
    return List<RequestProfile>.from(
        json.map((one) => RequestProfile.fromJson(one)));
  }
}
