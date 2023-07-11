import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week2/api/google_auth.dart';
import 'package:week2/page/Saved_feed_page.dart';
import 'package:week2/page/profile_settings_page.dart';

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({Key? key}) : super(key: key);

  @override
  _ProfilePage2State createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
  final double coverHeight = 240;
  final double profileHeight = 144;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  GoogleSignInAccount? user;

  void _openImagePicker() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  void initState() {
    super.initState();
    user = googleAuth.currentUser;
    googleAuth.onCurrentUserChanged.listen((newUser) {
      if (mounted) {
        setState(() {
          user = newUser;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => const ProfileSettingsPage(),
                ),
              );
            },
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildTop(),
          buildContent(),
        ],
      ),
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

  Widget buildProfileImage() {
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

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage(),
          ),
          Positioned(top: top, child: buildProfileImage())
        ]);
  }

  Widget buildContent() => SingleChildScrollView(
        child: Column(
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
            Divider(),
            SizedBox(height: 8, child: Text("help me")),
            Text(
              "HEEEEEEEELP",
              style: TextStyle(backgroundColor: Colors.blue, height: 2),
            ),
            SingleChildScrollView(
              child: InfiniteGridView(),
            ),
            SizedBox(height: 32, child: Text("help me, too")),
            // buildAbout(),
            /*SizedBox(
            height: 32,
          ),
          ExplanationWidget(title: "좋아하는 음식", msg: "알리오 올리오"),
          ExplanationWidget(title: "싫어하는 음식", msg: "청양고추"),
          ExplanationWidget(title: "먹고 싶은 음식", msg: "불닭...?")*/
          ],
        ),
      );
}

Widget buildSocialIcon(IconData icon) => CircleAvatar(
    radius: 24,
    child: Center(
        child: Material(
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            color: Colors.transparent,
            child: InkWell(
                onTap: () {},
                child: Center(
                  child: Icon(icon, size: 24),
                )))));

class NumbersWidget extends StatelessWidget {
  const NumbersWidget({super.key});

  Widget buildElevatedButton(
      {required String text,
      required int value,
      required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('$text ($value)'),
    );
  }

  Widget buildButton(
          {required String text,
          required int value,
          VoidCallback? onPressed}) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('$value',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 2),
            Text(text, style: TextStyle(fontSize: 12))
          ],
        ),
      );

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(
          text: '저장한 장소',
          value: 80,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SavedFeedPage()),
            );
          },
        ),
        buildDivider(),
        buildButton(
          text: '작성한 포스트',
          value: 309,
          onPressed: () {},
        ),
        buildDivider(),
        buildButton(
          text: '함께 하는 친구',
          value: 8,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildDivider() => Container(
        height: 32,
        child: VerticalDivider(),
      );

/* Widget buildButton({required String text, required int value}) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('$value',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(
              height: 2,
            ),
            Text(text, style: TextStyle(fontSize: 12))
          ],
        ),
      ); */
}

class ExplanationWidget extends StatelessWidget {
  final String title;
  final String msg;

  const ExplanationWidget({super.key, required this.title, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          buildDivider(),
          SizedBox(
              width: 100,
              child: Text(
                msg,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis),
              )),
        ]));
  }

  Widget buildDivider() => Container(
        height: 32,
        child: VerticalDivider(),
      );
}

class InfiniteGridView extends StatelessWidget {
  final List<String> images = [
    'assets/맛집1.jpg',
    'assets/맛집2.jpg',
    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
