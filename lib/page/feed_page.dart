import 'package:flutter/material.dart';
import 'package:week2/api/feed_server.dart';
import 'package:week2/api/google_auth.dart';
import 'package:week2/model/feedProfile_model.dart';
import 'package:week2/model/userProfile_model.dart';
import 'package:week2/page/login_page.dart';
import 'package:week2/page/search_page.dart';

class FeedPage extends StatefulWidget {
  final String googleId;

  FeedPage({required this.googleId});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<FeedProfile> feedProfiles = [];
  List<UserProfile> userprofiles = [];

  @override
  void initState() {
    super.initState();
    _loadFeedProfiles();
  }

  Future<void> _loadFeedProfiles() async {
    print("in _loadfeedprofiles");
    try {
      if (googleAuth.currentUser == null) {
        print('currentUser is null');
        return;
      }
      final currentUserGoogleId = googleAuth.currentUser!.id;

      print('current user ${googleAuth.currentUser}');

      print('before getpost');
      feedProfiles = await getPost(
        "googlegoogle", // currentUserGoogleId,
        true,
        true,
        true,
        true,
      );

      print('after getpost');
      setState(() {
        feedProfiles = feedProfiles;
        userprofiles = userprofiles;
      });
      print(feedProfiles);
    } catch (e) {
      print("error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (googleAuth.currentUser == null) {
      return LoginPage();
    }
    print("Building FeedPage");
    return Scaffold(
      appBar: null,
      body: ListView.builder(
        itemCount: feedProfiles.length,
        itemBuilder: (context, index) {
          final feedProfile = feedProfiles[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(feedProfile.photo),
                ),
                title: Text(feedProfile.id),
                /* subtitle: InkWell(
                  onTap: () {
                    //위치를 클릭하면 지도 위에 해당 위치가 표시되게 바꿔야 함
                  },
                  child: Text(feedItem.location),
                ), */
                trailing: PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Text('저장'),
                        value: 'save',
                      ),
                    ];
                  },
                  /*
                  onSelected: (value) {
                    if (value == 'save') {
                      final savedItems = context.read<SavedItems>();
                      savedItems.addItem(feedProfile.location);
                    }
                  },*/
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Image.network(
                  feedProfile.photo,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(feedProfile.content),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(),
            ),
          );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => SearchScreen(feedItems: [])),
          // );
        },
        label: Text('지도'),
        icon: Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
