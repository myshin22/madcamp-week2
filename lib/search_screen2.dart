import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';

import 'feed_item.dart';
import 'feed_screen.dart';

class SearchScreen2 extends StatelessWidget {
  final List<FeedItem> feedItems;

  SearchScreen2({required this.feedItems});

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
                // 검색 버튼을 눌렀을 때 실행되는 동작
              },
            ),
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
    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
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
              TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.looks_one_rounded)),
                  Tab(icon: Icon(Icons.looks_two_rounded)),
                  Tab(icon: Icon(Icons.looks_3_rounded)),
                ],
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(feedItem.profileImageUrl),
                ),
                title: Text(feedItem.username),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Container(),
                    Container(),
                    Container(),
                  ],
                ),
              ), // 세 번째 탭 (빈 페이지)
            ],
          ),
        ),
      ),
    );
  }

  Widget _expandedWidget(List<FeedItem> feedItems) {
    return FeedScreen(feedItems: feedItems);
  }
}
