import 'package:week2/api/mock_string.dart';
import 'package:week2/model/feed_item.model.dart';

class MockFeedItem {
  static FeedItem getFeedItem() {
    return FeedItem(
      username: MockString.getPersonName(),
      profileImageUrl: MockString.getPersonPhoto(),
      imageUrl: MockString.getFoodPhoto(),
      caption: '아주 그냥 입에서 녹네... 또 가야지',
    );
  }

  static List<FeedItem> getFeedItems() {
    return new List.generate(10, (index) => getFeedItem());
  }
}
