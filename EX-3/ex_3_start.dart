import 'package:flutter/material.dart';

List<String> images = [
  "assets/w4-s2/bird.jpg",
  "assets/w4-s2/bird2.jpg",
  "assets/w4-s2/insect.jpg",
  "assets/w4-s2/girl.jpg",
  "assets/w4-s2/man.jpg",
];

// Hides the red "DEBUG" ribbon shown in the top-right corner in debug mode.
void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageGallery(),
    ));

// Q1: the state is an int, the index of the image currently displayed.
// Q2: both the AppBar buttons and the Image depend on it, so the whole Scaffold is wrapped.
class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  State<ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  int _currentIndex = 0;

  // Modulo makes the carousel circular: next of last is first, previous of first is last.
  void _previous() => setState(() => _currentIndex = (_currentIndex - 1) % images.length);
  void _next() => setState(() => _currentIndex = (_currentIndex + 1) % images.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Image viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            tooltip: 'Go to the previous image',
            onPressed: _previous,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the next image',
              onPressed: _next,
            ),
          ),
        ],
      ),
      body: Image.asset(images[_currentIndex]),
    );
  }
}
