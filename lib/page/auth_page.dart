import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:week2/api/bookmark_server.dart';
import 'package:week2/api/google_auth.dart';
import 'package:week2/model/bookmark_model.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? status = "before";
  QRLogin? qrLogin;

  @override
  Widget build(BuildContext context) {
    final beforeButton =
        ElevatedButton(onPressed: getAuth, child: Text("네이버 지도와 연동하기"));
    final pendingButton = ElevatedButton(
        onPressed: openCodeSelector, child: Text("${qrLogin?.code}를 눌러주세요"));
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '맛집 목록 연동',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          leading: const BackButton(
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  // TODO 개인정보 주의 안내
                }),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (status == "before") beforeButton,
              if (status == "pending") pendingButton
            ],
          ),
        ));
  }

  void getAuth() async {
    final googleId = googleAuth.currentUser?.id;
    if (googleId == null) {
      Fluttertoast.showToast(msg: "로그인해주세요");
      return;
    }
    print("QWERTYQWERTY");
    qrLogin = await getNaverAuth(googleId);
    print("QWERTYQWERTY2");
    print(qrLogin?.link);
    print(qrLogin?.code);
    setState(() {
      status = "pending";
    });
  }

  void openCodeSelector() async {
    Fluttertoast.showToast(msg: (qrLogin != null) ? qrLogin!.link : "None");
    if (qrLogin != null) {
      final Uri url = Uri.parse(qrLogin!.link);
      setState(() {
        status = "pending";
      });
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
    setState(() {
      status = "before";
    });
  }
}
