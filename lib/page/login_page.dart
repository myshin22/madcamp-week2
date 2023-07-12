import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week2/api/bookmark_server.dart';
import 'package:week2/api/google_auth.dart';
import 'package:week2/api/mock_string.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "너와 나의 맛집 지도, 냠냠",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await googleAuth.signIn();
                if (googleAuth.currentUser != null) {
                  final user = googleAuth.currentUser!;
                  await createUser(
                      user.id,
                      user.displayName ?? user.email,
                      user.photoUrl ?? MockString.getFoodPhoto(),
                      user.photoUrl ?? MockString.getCoverPhoto(),
                      "파스타를 좋아하는 ${user.displayName}",
                      "",
                      "",
                      "");
                  Fluttertoast.showToast(msg: user.id ?? "None");
                }
              },
              icon: const FaIcon(
                FontAwesomeIcons.google,
                size: 18,
              ),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
              label: Text("Google로 가입하기"),
            )
          ],
        ),
      ),
    );
  }
}
