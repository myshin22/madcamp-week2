import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:week2/api/google_auth.api.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GoogleSignInAccount? user;

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
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 32),
          CircleAvatar(
              radius: 40, backgroundImage: NetworkImage(user?.photoUrl ?? "")),
          SizedBox(height: 8),
          Text(
            '${user?.displayName ?? ""}',
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(height: 8),
          Text(
            '${user?.email ?? ""}',
            style: TextStyle(fontSize: 12),
          )
        ]);
  }
}
