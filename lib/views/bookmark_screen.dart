import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 맛집 리스트'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              openGallery(context);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Add Screen'),
      ),
    );
  }

  void openGallery(BuildContext context) async {
    final picker = ImagePicker();
    final List<XFile> selectedImages = [];

    for (int i = 0; i < 5; i++) {
      XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        selectedImages.add(image);
      } else {
        break;
      }
    }

    if (selectedImages.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GetPictureScreen(selectedImages),
        ),
      );
    }
  }
}

class GetPictureScreen extends StatelessWidget {
  final List<XFile> selectedImages;

  GetPictureScreen(this.selectedImages, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('글 쓰기'),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_sharp),
            onPressed: () {
              //upload 버튼이 눌리면?
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: selectedImages.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.file(
                File(selectedImages[index].path),
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: '문구를 입력하세요',
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
