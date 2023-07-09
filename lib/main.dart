import 'dart:io';

import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  List<Widget> _screens = [
    SearchScreen(),
    FeedScreen(),
    AddScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '냠냠',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: null,
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feed),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('연결관리'),
          ),
          ListTile(
            title: Text('네이버 지도 연결'),
            onTap: () {
              // 항목 1이 선택되었을 때의 코드
            },
          ),
          ListTile(
            title: Text('친구추가'),
          ),
          ListTile(
            title: Text('연락처로 추가하기'),
            onTap: () {
              // 친구 1이 선택되었을 때의 코드
            },
          ),
          ListTile(
            title: Text('초대장 보내기'),
            onTap: () {
              // 친구 2가 선택되었을 때의 코드
            },
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  final List<FeedItem> feedItems = [
    FeedItem(
      username: 'user1',
      profileImageUrl: 'assets/신민영_증명사진2023.jpg',
      imageUrl: 'assets/맛집1.jpg',
      caption: '정말정말맛있다.',
    ),
    // Add more feed items as needed
  ];

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
    return FeedScreen(feedItems: feedItems);
  }
}


class FeedScreen extends StatelessWidget {
  final List<FeedItem> feedItems;

  FeedScreen({required this.feedItems});

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
                  backgroundImage: AssetImage(feedItem.profileImageUrl),
                ),
                title: Text(feedItem.username),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Image.asset(
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
            MaterialPageRoute(builder: (context) => SearchScreen()),
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

class FeedItem {
  final String username;
  final String profileImageUrl;
  final String imageUrl;
  final String caption;

  FeedItem({
    required this.username,
    required this.profileImageUrl,
    required this.imageUrl,
    required this.caption,
  });
}

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class PlaceSelectScreen extends StatelessWidget {
  final List<String> placeList = [
    '장소1 - 주소1',
    '장소2 - 주소2',
    '장소3 - 주소3',
    '장소4 - 주소4',
    '장소5 - 주소5'
  ]; //여기 실제로는 주소 데이터로 받아오자

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 맛집 리스트'),
      ),
      body: ListView.builder(
        itemCount: placeList.length,
        itemBuilder: (context, index) {
          final place = placeList[index].split(' - ')[0]; //장소 정보만 가져오기
          final address = placeList[index].split(' - ')[1]; //주소 정보만
          return ListTile(
            title: Text(place),
            subtitle: Text(address),
            onTap: () {
              Navigator.pop(context, place);
            },
          );
        },
      ),
    );
  }
}

class _AddScreenState extends State<AddScreen> {
  String? location;
  String description = '';
  List<XFile>? selectedImages; //선택한 이미지 목록

  Future<void> openGallery(BuildContext context) async {
    try {
      List<XFile>? resultList = await ImagePicker().pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 90,
      );

      if (resultList != null) {
        setState(() {
          selectedImages = resultList;
        });
      }
    } catch (e) {
      // 예외 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //서버 상에 업로드 되도록 해야 함.
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: selectedImages != null && selectedImages!.isNotEmpty
                  ? PageView.builder(
                      itemCount: selectedImages!.length,
                      itemBuilder: (context, index) {
                        return Image.file(
                          File(selectedImages![index].path),
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : ElevatedButton(
                      child: Icon(Icons.image, size: 128),
                      onPressed: () {
                        openGallery(context);
                      },
                    ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.location_on),
              label: Text(location ?? '맛집 선택'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaceSelectScreen()),
                ).then((selectedLoction) {
                  setState(() {
                    location = selectedLoction;
                  });
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '이 맛집은 어떤 점이 좋았나요?',
                border: OutlineInputBorder(),
              ),
              minLines: 3,
              maxLines: 5,
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
