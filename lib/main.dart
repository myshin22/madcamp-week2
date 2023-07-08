import 'dart:io';

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

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText:'어느 지역 맛집을 알고 싶으세요?',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // 입력된 검색어 처리
              },
              onSubmitted: (value) {
                // 엔터 키를 눌러 검색어 제출
              },
            ),
            SizedBox(height: 16.0),
            Text('map') //여기에 지도 넣기
          ],
        ),
      ),
    );
  }
}

class FeedItem{
  final String username;
  final String profileImageUrl;
  final String imageUrl;
  final String caption;

  FeedItem(
      {required this.username,
      required this.profileImageUrl,
      required this.imageUrl,
      required this.caption});
}


class FeedScreen extends StatelessWidget {
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

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List<String> placeList = [
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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  String name = '';
                  String address = '';
                  return AlertDialog(
                    title: Text('장소 추가'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: InputDecoration(hintText: '장소 이름'),
                        ),
                        TextField(
                          onChanged: (value) {
                            address = value;
                          },
                          decoration: InputDecoration(hintText: '주소'),
                        )
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('저장'),
                        onPressed: () {
                          setState(() {
                            placeList.add('$name - $address');
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: placeList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(placeList[index]),
              onTap: () {
                // 여기에 특정 장소를 눌렀을 때의 로직을 추가하세요
                print('${placeList[index]}가 선택되었습니다.');
              },
            );
          }),
    );
  }

  Future<void> openGallery(BuildContext context) async {
    try {
      List<XFile>? resultList = await ImagePicker().pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 90,
      );

      if (resultList != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GetPictureScreen(resultList),
          ),
        );
      }
    } catch (e) {
      // 예외 처리
    }
  }
}

class GetPictureScreen extends StatefulWidget {
  final List<XFile> images;

  GetPictureScreen(this.images);

  @override
  _GetPictureScreenState createState() => _GetPictureScreenState();
}

class _GetPictureScreenState extends State<GetPictureScreen> {
  String caption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기'),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_sharp),
            onPressed: () {
              //upload 버튼을 누르면 서버 상에 보낼 수 있도록 코드를 짜야 돼
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Image.file(
                  File(widget.images[index].path),
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Add caption',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  caption = value;
                });
              },
            ),
          ),
        ],
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
