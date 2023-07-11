import 'package:flutter/material.dart';
import 'package:madcamp_week_2/my_feed_item.dart';
import 'package:madcamp_week_2/my_profile_item.dart';

class MyFeedScreen extends StatelessWidget {
  final List<MyFeedItem> myfeedItems;
  final MyProfileItem myProfileItem;
  final int initialIndex;

  MyFeedScreen(
      {required this.myfeedItems,
      required this.myProfileItem,
      required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('내 맛집'), backgroundColor: Colors.transparent),
      body: ListView.builder(
        itemCount: myfeedItems.length,
        itemBuilder: (context, index) {
          final myfeedItem = myfeedItems[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(myProfileItem.profileImageUrl),
                ),
                title: Text(myProfileItem.username),
                subtitle: Text(myfeedItem.location),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: myfeedItem.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      myfeedItem.imageUrls[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(myfeedItem.caption),
              ),
            ],
          );
        },
      ),
    );
  }
}
