import 'package:flutter/material.dart';

import 'feed_item.dart';
import 'search_screen.dart';

class FeedScreen extends StatelessWidget {
  final List<FeedItem> feedItems;

  FeedScreen({required this.feedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('내 친구 맛집'), backgroundColor: Colors.transparent),
      body: ListView.builder(
        itemCount: feedItems.length,
        itemBuilder: (context, index) {
          final feedItem = feedItems[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(feedItem.profileImageUrl),
                ),
                title: Text(feedItem.username),
                subtitle: Text(feedItem.location),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: feedItem.imageUrls.length, // 페이지 개수는 이미지의 개수와 동일
                  itemBuilder: (context, index) {
                    return Image.asset(
                      feedItem.imageUrls[index], // 각 페이지에서는 해당 인덱스의 이미지를 보여줌
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(feedItem.caption), // caption을 사진 밑에 표시
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(
                feedItems: feedItems,
              ),
            ),
          );
        },
        label: Text('지도'),
        icon: Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
