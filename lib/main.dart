import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
    List<Asset> selectedImages = [];

    try {
      selectedImages = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
      );
    } catch (e) {
      //예외?
    }

    if (selectedImages.isNotEmpty) {
      List<XFile> xFiles = await Future.wait(
        selectedImages.map((asset) => assetToFile(asset)),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetPictureScreen(xFiles),
        ),
      );
    }
  }
}

Future<XFile> assetToFile(Asset asset) async {
  final byteData = await asset.getByteData();
  final tempDirectory = await getTemporaryDirectory();
  final tempPath = '${tempDirectory.path}/${asset.name}';
  final tempFile = File(tempPath);
  await tempFile.writeAsBytes(byteData.buffer.asUint8List());

  return XFile(tempPath);
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
              Image.memory(
                File(selectedImages[index].path).readAsBytesSync(),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: '이 식당은 어떤 점이 좋았나요?',
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
