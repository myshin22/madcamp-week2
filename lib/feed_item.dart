class FeedItem {
  final String username;
  final String profileImageUrl;
  final String imageUrl;
  final String caption;

  FeedItem({
    required this.username,
    required this.profileImageUrl,
    required this.imageUrl,
    required this.caption,
  });
}

List<FeedItem> feedItems = [
  FeedItem(
    username: 'user1',
    profileImageUrl: 'assets/신민영_증명사진2023.jpg',
    imageUrl: 'assets/맛집1.jpg',
    caption: '정말정말맛있다.',
  ),
  // Add more feed items as needed
];
