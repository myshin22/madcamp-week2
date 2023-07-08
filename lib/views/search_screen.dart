import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: '어느 지역 맛집을 알고 싶으세요?',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // 입력된 검색어 처리
              },
              onSubmitted: (value) {
                // 엔터 키를 눌러 검색어 제출
              },
            ),
            const SizedBox(height: 16.0),
            const Text('map') //여기에 지도 넣기
          ],
        ),
      ),
    );
  }
}
