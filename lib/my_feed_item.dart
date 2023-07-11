class MyFeedItem {
  final List<String> imageUrls;
  final String caption;
  final String location; // 추가된 필드

  MyFeedItem({
    required this.imageUrls,
    required this.caption,
    required this.location, // 생성자에 추가됨
  });
}

List<MyFeedItem> myfeedItems = [
  MyFeedItem(
    imageUrls: ['assets/내맛집1.jpg', 'assets/내맛집2.jpg'],
    caption: '정말정말맛있다.',
    location: '장소1', // 장소 정보 추가
  ),
  MyFeedItem(
    imageUrls: ['assets/내맛집3.jpg', 'assets/내맛집1.jpg'],
    caption: '정말정말정말맛있다.',
    location: '장소2', // 장소 정보 추가
  ),
  MyFeedItem(
    imageUrls: ['assets/내맛집2.jpg', 'assets/내맛집4.jpg'],
    caption: '정말정말정말정말정말맛있다.',
    location: '장소3', // 장소 정보 추가
  ),
  // Add more feed items as needed
];
