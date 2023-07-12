import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week2/api/bookmark_server.dart';
import 'package:week2/api/google_auth.dart';
import 'package:week2/model/userProfile_model.dart';
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
  late Future<UserProfile>? userProfile;
  GoogleSignInAccount? user;

  @override
  void initState() {
    super.initState();
    final user = googleAuth.currentUser;
    if (user != null) {
      userProfile = getUser(user.id);
    } else {
      Fluttertoast.showToast(msg: "로그인해주세요");
    }
  }

  void _openImagePicker() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        selectedImage;
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

  Widget buildCoverImage(UserProfile snapshot) => Container(
        color: Colors.grey,
        child: Image.network(
          snapshot.coverPhoto,
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget _profile(UserProfile snapshot) {
    return GestureDetector(
      onTap: _openImagePicker,
      child: CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(snapshot.profilePhoto),
      ),
    );
  }

  Widget buildin(UserProfile snapshot) {
    return Stack(
      children: [
        buildCoverImage(snapshot),
        Positioned(
          top: coverHeight / 2 - profileHeight / 2, // Adjust position as needed
          left: 0,
          right: 0,
          child: _profile(snapshot),
        ),
      ],
    );
  }

  Widget buildSocialIcon(IconData iconData) {
    return Icon(iconData);
  }

  Widget NumbersWidget() {
    // TODO: Implement this widget
    return Container();
  }

  Widget _menu(UserProfile snapshot) {
    return Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text(snapshot.name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
        SizedBox(
          height: 8,
        ),
        Text(
          snapshot.explanation,
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
          Padding(
              padding: EdgeInsets.only(),
              child: IconButton(
                  icon: const Icon(Icons.developer_mode, size: 24),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return TextButton(
                              onPressed: () {},
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(googleAuth.currentUser.toString()),
                                    Text(userProfile.toString())
                                  ],
                                ),
                              ));
                        });
                  })),
          Padding(
              padding: EdgeInsets.only(),
              child: IconButton(
                  icon: const Icon(Icons.logout, size: 24),
                  onPressed: googleAuth.signOut)),
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                  icon: const Icon(Icons.upload_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileSettingsPage()));
                  }))
        ],
      ),
      body: FutureBuilder<UserProfile>(
        future: userProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: Column(children: [
              buildCoverImage(snapshot.data!),
              _profile(snapshot.data!),
              _menu(snapshot.data!),
              _tabView(),
            ]));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
