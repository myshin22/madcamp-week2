import 'package:flutter/material.dart';
import 'package:week2/model/feed_item.model.dart';

class MyFeedScreen extends StatelessWidget {
  final List<FeedItem> feedItems;
  final int initialIndex;

  MyFeedScreen({required this.feedItems, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('내 맛집'), backgroundColor: Colors.transparent),
      body: ListView.builder(
        itemCount: feedItems.length,
        itemBuilder: (context, index) {
          final feedItem = feedItems[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  itemCount: feedItem.imageUrl.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      feedItem.imageUrl[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(feedItem.caption),
              ),
            ],
          );
        },
      ),
    );
  }
}
