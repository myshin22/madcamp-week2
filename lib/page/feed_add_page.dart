import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week2/api/feed_server.dart';
import 'package:week2/api/util_server.dart';

class FeedAddPage extends StatefulWidget {
  const FeedAddPage({super.key});

  @override
  State<FeedAddPage> createState() => _FeedAddPageState();
}

class _FeedAddPageState extends State<FeedAddPage> {
  final textController = TextEditingController();
  String? location;
  List<File> selectedImages = []; //선택한 이미지 목록

  Future<void> openGallery(BuildContext context) async {
    List<XFile>? resultList = await ImagePicker().pickMultiImage(
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 90,
    );
    setState(() {
      if (resultList.isNotEmpty) {
        selectedImages = resultList.map((r) => File(r.path)).toList();
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = selectedImages.isNotEmpty
        ? PageView.builder(
            itemCount: selectedImages.length,
            itemBuilder: (context, index) {
              return Image.file(selectedImages[index], fit: BoxFit.cover);
            })
        : ElevatedButton(
            child: const Icon(Icons.image_search, size: 48),
            onPressed: () {
              openGallery(context);
            },
          );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '피드 작성',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.upload_outlined), onPressed: uploadFeed),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              AspectRatio(aspectRatio: 1, child: imageWidget),
              ElevatedButton.icon(
                icon: const Icon(Icons.location_on),
                label: Text(location ?? '맛집 선택'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FeedAddPlacePage()),
                  ).then((selectedLocation) {
                    setState(() {
                      location = selectedLocation;
                    });
                  });
                },
              ),
              TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: '맛집으로 추천하는 이유를 적어주세요',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 200,
                  validator: (String? value) {
                    if (value == null) {
                      return "글을 입력해주세요";
                    } else if (10 > value.length) {
                      return "10글자 이상 입력해주세요";
                    } else if (200 < value.length) {
                      return "200글자 이하로 입력해주세요";
                    }
                    return null;
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void uploadFeed() async {
    if (selectedImages.isNotEmpty && textController.text.length >= 10) {
      final photo = await uploadImage(selectedImages[0]);
      final post =
      await createPost("googlegoogle", photo, textController.text, []);
      Fluttertoast.showToast(msg: post.photo);
    }
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
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              //여기 네이버로 넘어가서 즐겨찾기 추가할 수 있도록
            },
          ),
        ],
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
