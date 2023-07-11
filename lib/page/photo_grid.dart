import 'package:flutter/material.dart';
import 'package:week2/model/feed_item.model.dart';
import 'package:week2/page/my_feed_page.dart';

class PhotoGrid extends StatelessWidget {
  late final List<FeedItem> feedItems;

  PhotoGrid({required this.feedItems});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: feedItems.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MyFeedScreen(feedItems: feedItems, initialIndex: index),
              ),
            );
          },
          child: Image.asset(
            feedItems[index].imageUrl[0],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
