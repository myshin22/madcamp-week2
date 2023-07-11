import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('연결관리'),
          ),
          ListTile(
            title: Text('네이버 지도 연결'),
            onTap: () {
              // 항목 1이 선택되었을 때의 코드
            },
          ),
          ListTile(
            title: Text('친구추가'),
          ),
          ListTile(
            title: Text('연락처로 추가하기'),
            onTap: () {
              // 친구 1이 선택되었을 때의 코드
            },
          ),
          ListTile(
            title: Text('초대장 보내기'),
            onTap: () {
              // 친구 2가 선택되었을 때의 코드
            },
          ),
        ],
      ),
    );
  }
}
