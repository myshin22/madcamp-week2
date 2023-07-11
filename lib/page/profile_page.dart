import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week2/page/profile_settings_page.dart';

class NewProfilePage extends StatefulWidget {
  const NewProfilePage({Key? key}) : super(key: key);

  @override
  _NewProfilePageState createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  final double coverHeight = 240;
  final double profileHeight = 144;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  GoogleSignInAccount? user;

  void _openImagePicker() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _imageFile = selectedImage;
      });
    }
  }

  Widget _statisticsOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://images.pexels.com/photos/3186654/pexels-photo-3186654.jpeg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget _profile() {
    return GestureDetector(
      onTap: _openImagePicker,
      child: CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey,
        backgroundImage: _imageFile != null
            ? FileImage(File(_imageFile!.path)) as ImageProvider<Object>?
            : (user?.photoUrl != null
                ? NetworkImage(user!.photoUrl as String)
                    as ImageProvider<Object>?
                : null),
      ),
    );
  }

  Widget buildSocialIcon(IconData iconData) {
    return Icon(iconData);
  }

  Widget NumbersWidget() {
    // TODO: Implement this widget
    return Container();
  }

  Widget _menu() {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text(user?.displayName ?? user?.email ?? "",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
        SizedBox(
          height: 8,
        ),
        Text(
          '파스타를 좋아하는 미식가',
          style: TextStyle(fontSize: 18, height: 1.4),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSocialIcon(FontAwesomeIcons.instagram),
            const SizedBox(
              width: 12,
            ),
            buildSocialIcon(FontAwesomeIcons.twitter),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Divider(),
        SizedBox(
          height: 8,
        ),
        NumbersWidget(),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget _tabView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 100,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print('Item clicked');
            // TODO: Implement your action here
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('삭제하시겠습니까?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('취소'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('삭제'),
                      onPressed: () {
                        // 여기 아이템 삭제 로직 넣기
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            color: Colors.grey,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          '내 프로필',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                  MaterialPageRoute(
                      builder: (context) => ProfileSettingsPage()));
            },
            child: Icon(
              Icons.settings, // Updated from ImageData(IconsPath.uploadIcon)
              size: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCoverImage(),
            _profile(),
            _menu(),
            _tabView(),
          ],
        ),
      ),
    );
  }
}
