import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week2/page/saved_items.dart';

class SavedFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedItems = context.watch<SavedItems>();

    return ListView.builder(
      itemCount: savedItems.savedItemList.length,
      itemBuilder: (context, index) {
        final item = savedItems.savedItemList[index];
        return ListTile(
          title: Text(item),
          // 아이템에 대한 추가 정보 또는 기능을 구현할 수 있습니다.
        );
      },
    );
  }
}
