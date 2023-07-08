import 'package:flutter/material.dart';

class FeedItem {
  final String username;
  final String imageUrl;
  final String caption;

  FeedItem(
      {required this.username, required this.imageUrl, required this.caption});
}

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<FeedItem> feedItems = []; //서버에서 가져온 데이터 저장할 리스트

  //데이터를 가져오는 비동기 함수
  Future<void> fetchData() async {
    //데이터를 서버에서 가져오는 비동기 작업 수행
    //가져온 데이터를 FeedItem으로 변환하여 feedItems 리스트에 저장
    //setState() 호출하여 UI 갱신
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // iniState에서 데이터를 가져오는 비동기 함수 호출
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: '어느 지역 맛집을 알고 싶으세요?',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                //검색어 입력하며 어떻게 됨?
              },
              onSubmitted: (value) {
                //검색어 제출하면 어떻게 됨?
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: feedItems.length,
              itemBuilder: (context, index) {
                final feedItem = feedItems[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(feedItem.imageUrl),
                  ),
                  title: Text(feedItem.username),
                  subtitle: Text(feedItem.caption),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // 액티비티(또는 다른 화면)을 표시하는 로직을 추가하세요
        },
        label: const Text('지도'),
        icon: const Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
