import 'package:flutter/material.dart';
import 'package:madcamp_week_2/my_feed_item.dart';
import 'package:madcamp_week_2/my_feed_screen.dart';
import 'package:madcamp_week_2/my_profile_item.dart';

class ProfileScreen extends StatelessWidget {
  final List<MyFeedItem> myfeedItems;
  final MyProfileItem myProfileItem;

  ProfileScreen({required this.myfeedItems, required this.myProfileItem});

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [];
    if (myfeedItems.isNotEmpty) {
      imageUrls = myfeedItems[0].imageUrls;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ProfileHeader(),
          Expanded(child: PhotoGrid(myfeedItems: myfeedItems)),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final MyProfileItem myProfileItem;

  ProfileHeader({required this.myProfileItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(myProfileItem.profileImageUrl),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(myProfileItem.profileImageUrl),
                  ),
                  title: Text(myProfileItem.username)),
            ],
          ),
        ],
      ),
    );
  }
}

class PhotoGrid extends StatelessWidget {
  final List<MyFeedItem> myfeedItems;

  PhotoGrid({required this.myfeedItems});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: myfeedItems.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MyFeedScreen(myfeedItems: myfeedItems, initialIndex: index),
              ),
            );
          },
          child: Image.asset(
            myfeedItems[index].imageUrls[0],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('연결관리'),
          ),
          ListTile(
            title: Text('네이버 지도 연결'),
            onTap: () {
              // 항목 1이 선택되었을 때의 코드
            },
          ),
          ListTile(
            title: Text('친구추가'),
          ),
          ListTile(
            title: Text('연락처로 추가하기'),
            onTap: () {
              // 친구 1이 선택되었을 때의 코드
            },
          ),
          ListTile(
            title: Text('초대장 보내기'),
            onTap: () {
              // 친구 2가 선택되었을 때의 코드
            },
          ),
        ],
      ),
    );
  }
}
