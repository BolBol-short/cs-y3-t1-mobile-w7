import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.lightGreen[400],
        body: const SafeArea(
          child: Column(
            children: [
              ScoreCard(title: "My score in Flutter", initialScore: 5),
              ScoreCard(title: "My score in Dart", initialScore: 3),
              ScoreCard(title: "My score in React", initialScore: 10),
            ],
          ),
        ),
      ),
    ));

// Stateful: the score changes with the +/- buttons.
class ScoreCard extends StatefulWidget {
  const ScoreCard({super.key, required this.title, this.initialScore = 0});

  final String title;
  final int initialScore;

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  static const int maxScore = 10;

  late int _score = widget.initialScore.clamp(1, maxScore);

  void _decrease() => setState(() => _score = (_score - 1).clamp(1, maxScore));
  void _increase() => setState(() => _score = (_score + 1).clamp(1, maxScore));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(widget.title, style: const TextStyle(fontSize: 26, color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: _decrease, icon: const Icon(Icons.remove)),
              const SizedBox(width: 50),
              IconButton(onPressed: _increase, icon: const Icon(Icons.add)),
            ],
          ),
          ScoreBar(ratio: _score / maxScore),
        ],
      ),
    );
  }
}

// Stateless: only draws the bar for the ratio it receives.
class ScoreBar extends StatelessWidget {
  const ScoreBar({super.key, required this.ratio});

  final double ratio;

  // Darker green as the score grows.
  Color get color => Color.lerp(Colors.green[200], Colors.green[900], ratio)!;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(10);
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(color: Colors.grey),
          ),
        ),
        FractionallySizedBox(
          widthFactor: ratio,
          child: Container(
            height: 50,
            decoration: BoxDecoration(color: color, borderRadius: radius),
          ),
        ),
      ],
    );
  }
}
