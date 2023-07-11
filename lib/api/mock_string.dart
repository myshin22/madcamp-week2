import 'dart:math';

const _foodPhoto = [
  "https://images.pexels.com/photos/2097090/pexels-photo-2097090.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/2983099/pexels-photo-2983099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/2280545/pexels-photo-2280545.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
];

const _personPhoto = [
  'https://images.unsplash.com/photo-1624561172888-ac93c696e10c?w=500&q=50',
  "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/1858175/pexels-photo-1858175.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
];

const _coverPhoto = [
  "https://images.pexels.com/photos/1640774/pexels-photo-1640774.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/1775043/pexels-photo-1775043.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/65175/pexels-photo-65175.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
];

const _personName = ["황제욱", "신민영", "방준형", "아이유", "유재석", "강호동"];

class MockString {
  static String _getRandomElement(List<String> array) {
    final random = Random();
    return array[random.nextInt(array.length)];
  }

  static String getFoodPhoto() => _getRandomElement(_foodPhoto);

  static String getPersonPhoto() => _getRandomElement(_personPhoto);

  static String getCoverPhoto() => _getRandomElement(_coverPhoto);

  static String getPersonName() => _getRandomElement(_personName);
}
