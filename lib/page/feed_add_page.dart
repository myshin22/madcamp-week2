import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:week2/api/feed_server.dart';
import 'package:week2/api/google_auth.dart';
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
  int activeIndex = 0;

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

  Widget indicator() => Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.bottomCenter,
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: selectedImages.length,
        effect: JumpingDotEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Theme.of(context)
                .primaryColor
                .withOpacity(0.8), // Colors.white,
            dotColor: Colors.white.withOpacity(0.6)),
      ));

  @override
  Widget build(BuildContext context) {
    final imageWidget = selectedImages.isNotEmpty
        ? Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 1,
                initialPage: 0,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enableInfiniteScroll: selectedImages.length > 1,
                onPageChanged: (index, reason) => setState(() {
                  activeIndex = index;
                }),
              ),
              itemCount: selectedImages.length,
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(24), // Image border
                    child: Container(
                      width: double.infinity,
                      child:
                          Image.file(selectedImages[index], fit: BoxFit.cover),
                    ));
              },
            ),
            if (selectedImages.length > 1 && selectedImages.length <= 15)
              Align(alignment: Alignment.bottomCenter, child: indicator())
          ])
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24), // <-- Radius
              ),
            ),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  Icon(Icons.image_search, size: 48),
                  SizedBox(height: 8),
                  Text("음식/가게 사진 첨부")
                ]),
            onPressed: () {
              openGallery(context);
            },
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '피드 작성',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                  icon: const Icon(Icons.upload_outlined),
                  onPressed: uploadFeed)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 48),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AspectRatio(aspectRatio: 1, child: imageWidget)),
              SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                icon: const Icon(Icons.location_on),
                label: Text(location ?? '장소 선택'),
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
              SizedBox(height: 16),
              TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: '맛집으로 추천하는 이유를 적어주세요',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 200,
                  minLines: 3,
                  maxLines: 5,
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
    if (selectedImages.isEmpty) {
      Fluttertoast.showToast(msg: "음식이나 가게 사진을 첨부해주세요");
      return;
    }
    if (location != null) {
      Fluttertoast.showToast(msg: "장소를 선택해주세요");
      return;
    }
    if (textController.text.length < 10) {
      Fluttertoast.showToast(msg: "이유를 10자 이상 작성해주세요");
      return;
    }
    var googleId = googleAuth.currentUser?.id;
    if (googleId != null) {
      Fluttertoast.showToast(msg: "로그인해주세요");
      return;
    }
    final photo = await uploadImage(selectedImages[0]);
    final post = await createPost(googleId!, photo, textController.text, []);
    Fluttertoast.showToast(msg: post.photo);
    Navigator.pop(context);
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
