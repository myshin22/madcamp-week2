import 'package:flutter/material.dart';

class SavedItems extends ChangeNotifier {
  List<String> savedItemList = [];

  void addItem(String item) {
    savedItemList.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    savedItemList.remove(item);
    notifyListeners();
  }
}
