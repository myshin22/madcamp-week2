import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:week2/api/mock_feed_item.dart';
import 'package:week2/page/feed_page.dart';

import '../model/feed_item.model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final List<FeedItem> feedItems;

  @override
  initState() {
    feedItems = MockFeedItem.getFeedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: DraggableBottomSheet(
        minExtent: 150,
        useSafeArea: false,
        curve: Curves.easeIn,
        previewWidget: _previewWidget(feedItems),
        expandedWidget: _expandedWidget(feedItems),
        backgroundWidget: _backgroundWidget(),
        maxExtent: MediaQuery.of(context).size.height,
        onDragging: (pos) {},
      ),
    );
  }

  Widget _backgroundWidget() {
    return Column(
      children: [
        // 지도 위젯 추가
        Text('지도'),
      ],
    );
  }

  Widget _previewWidget(List<FeedItem> feedItems) {
    final feedItem = feedItems.first; // 첫 번째 FeedItem만 보이도록 설정
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 40,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Drag Me',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  feedItem.username,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Image.asset(
                  feedItem.imageUrl,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8.0),
                Text(feedItem.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _expandedWidget(List<FeedItem> feedItems) {
    return FeedPage();
  }
}
