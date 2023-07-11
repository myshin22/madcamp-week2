import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FeedAddPage extends StatefulWidget {
  const FeedAddPage({super.key});

  @override
  State<FeedAddPage> createState() => _FeedAddPageState();
}

class _FeedAddPageState extends State<FeedAddPage> {
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
      setState(() {
        selectedImages = resultList;
      });
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
                  MaterialPageRoute(builder: (context) => FeedAddPlacePage()),
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

class FeedAddPlacePage extends StatelessWidget {
  final List<String> placeList = [
    '장소1 - 주소1',
    '장소2 - 주소2',
    '장소3 - 주소3',
    '장소4 - 주소4',
    '장소5 - 주소5'
  ]; //여기 실제로는 주소 데이터로 받아오자

  FeedAddPlacePage({super.key});

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
