import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'feed_item.dart';
import 'feed_screen.dart';

class SearchScreen extends StatelessWidget {
  final List<FeedItem> feedItems;

  SearchScreen({required this.feedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '검색',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  //여기 누르면 그냥 입럭한 값과 관련된 위치나 가게 이름으로 이동할 수 있도록 하자
                }),
          ],
        ),
      ),
      body: DraggableBottomSheet(
        minExtent: 150,
        useSafeArea: false,
        curve: Curves.easeIn,
        previewWidget: _previewWidget(context),
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

  Widget _previewWidget(BuildContext context) {
    final feedItem = feedItems.first; // 첫 번째 FeedItem만 보이도록 설정
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 40,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(feedItem.profileImageUrl),
              ),
              title: Text(feedItem.username),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandedWidget(List<FeedItem> feedItems) {
    return FeedScreen(feedItems: feedItems);
  }
}
