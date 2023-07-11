import 'package:flutter/material.dart';
import 'package:week2/api/mock_feed_item.dart';
import 'package:week2/model/feed_item.model.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final List<FeedItem> feedItems;

  @override
  initState() {
    feedItems = MockFeedItem.getFeedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView.builder(
        itemCount: feedItems.length,
        itemBuilder: (context, index) {
          final feedItem = feedItems[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(feedItem.profileImageUrl),
                ),
                title: Text(feedItem.username),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Image.network(
                  feedItem.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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