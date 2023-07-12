class CleanFolder {
  final int id;
  final String name;
  final String? memo;
  final int bookmarkCount;

  CleanFolder({
    required this.id,
    required this.name,
    required this.memo,
    required this.bookmarkCount,
  });

  factory CleanFolder.fromJson(Map<String, dynamic> json) {
    return CleanFolder(
      id: json['id'],
      name: json['name'],
      memo: json['memo'],
      bookmarkCount: json['bookmarkCount'],
    );
  }

  static List<CleanFolder> listFromJson(json) {
    return List<CleanFolder>.from(json.map((one) => CleanFolder.fromJson(one)));
  }
}

class CleanBookmark {
  final int id;
  final List<int> folderIds;
  final String name;
  final double px;
  final double py;
  final String sid;
  final String address;
  final String memo;
  final String category;

  CleanBookmark({
    required this.id,
    required this.folderIds,
    required this.name,
    required this.px,
    required this.py,
    required this.sid,
    required this.address,
    required this.memo,
    required this.category,
  });

  factory CleanBookmark.fromJson(Map<String, dynamic> json) {
    return CleanBookmark(
      id: json['id'],
      folderIds: json['folderIds'],
      name: json['name'],
      px: json['px'],
      py: json['py'],
      sid: json['sid'],
      address: json['address'],
      memo: json['memo'],
      category: json['category'],
    );
  }

  static List<CleanBookmark> listFromJson(json) {
    return List<CleanBookmark>.from(
        json.map((one) => CleanBookmark.fromJson(one)));
  }
}

class UserBookmark {
  final List<CleanBookmark> bookmark;
  final List<CleanFolder> folder;

  UserBookmark({
    required this.bookmark,
    required this.folder,
  });

  factory UserBookmark.fromJson(Map<String, dynamic> json) {
    return UserBookmark(
        bookmark: CleanBookmark.listFromJson(
          json['bookmark'],
        ),
        folder: CleanFolder.listFromJson(
          json['folder'],
        ));
  }
}

class QRLogin {
  final String link;
  final String code;

  QRLogin({
    required this.link,
    required this.code,
  });

  factory QRLogin.fromJson(Map<String, dynamic> json) {
    return QRLogin(
      link: json['link'],
      code: json['code'],
    );
  }
}
