import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'saved_items.dart';

final savedItemsProvider = ChangeNotifierProvider<SavedItems>((ref) {
  return SavedItems();
});
