import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week2/api/mock_feed_item.dart';
import 'package:week2/model/feed_item.model.dart';
import 'package:week2/page/saved_items.dart';
import 'package:week2/page/search_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final List<FeedItem> feedItems;

  @override
  initState() async {
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
                subtitle: InkWell(
                  onTap: () {
                    //위치를 클릭하면 지도 위에 해당 위치가 표시되게 바꿔야 함
                  },
                  child: Text(feedItem.location),
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Text('저장'),
                        value: 'save',
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == 'save') {
                      final savedItems = context.read<SavedItems>();
                      savedItems.addItem(feedItem.location);
                    }
                  },
                ),
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
