class FeedItem {
  final String username;
  final String profileImageUrl;
  final List<String> imageUrls;
  final String caption;
  final String location; // 추가된 필드

  FeedItem({
    required this.username,
    required this.profileImageUrl,
    required this.imageUrls,
    required this.caption,
    required this.location, // 생성자에 추가됨
  });
}

List<FeedItem> feedItems = [
  FeedItem(
    username: 'user1',
    profileImageUrl: 'assets/신민영_증명사진2023.jpg',
    imageUrls: ['assets/맛집1.jpg', 'assets/맛집1.jpg'],
    caption: '정말정말맛있다.',
    location: '장소1', // 장소 정보 추가
  ),
  FeedItem(
    username: 'user1',
    profileImageUrl: 'assets/신민영_증명사진2023.jpg',
    imageUrls: ['assets/맛집1.jpg', 'assets/맛집2.jpg'],
    caption: '정말정말맛있다.',
    location: '장소1', // 장소 정보 추가
  ),
  FeedItem(
    username: 'user1',
    profileImageUrl: 'assets/신민영_증명사진2023.jpg',
    imageUrls: ['assets/맛집1.jpg', 'assets/맛집3.jpg'],
    caption: '정말정말맛있다.',
    location: '장소1', // 장소 정보 추가
  ),
  // Add more feed items as needed
];