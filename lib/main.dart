import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

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
  final String imageUrl;
  final String caption;

  FeedItem({required this.username,required this.imageUrl, required this.caption});
}


class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>{
  List<FeedItem> feedItems = []; //서버에서 가져온 데이터 저장할 리스트

  //데이터를 가져오는 비동기 함수
  Future<void>fetchData()async{
    //데이터를 서버에서 가져오는 비동기 작업 수행
    //가져온 데이터를 FeedItem으로 변환하여 feedItems 리스트에 저장
    //setState() 호출하여 UI 갱신
  }
  @override
  void initState(){
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
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText:'어느 지역 맛집을 알고 싶으세요?',
                  prefixIcon:Icon(Icons.search),
                ),
                onChanged: (value){
                  //검색어 입력하며 어떻게 됨?
                },
                onSubmitted: (value){
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
        label: Text('지도'),
        icon: Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

class AddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 맛집 리스트'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              openGallery(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Add Screen'),
      ),
    );
  }

  void openGallery(BuildContext context) async {
    final picker = ImagePicker();
    final List<XFile> selectedImages = [];

    for (int i = 0; i < 5; i++) {
      XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImages.add(image);
      } else {
        break;
      }
    }

    if (selectedImages.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetPictureScreen(selectedImages),
        ),
      );
    }
  }
}

class GetPictureScreen extends StatelessWidget {
  final List<XFile> selectedImages;

  GetPictureScreen(this.selectedImages);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글 쓰기'),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_sharp),
            onPressed: () {
              //upload 버튼이 눌리면?
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: selectedImages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.file(
                File(selectedImages[index].path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                hintText: '문구를 입력하세요',
                ),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
