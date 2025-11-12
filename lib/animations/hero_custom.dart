import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: HeroList()));

class HeroList extends StatelessWidget {
  const HeroList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Example')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: List.generate(3, (i) {
          return ListTile(
            leading: Hero(
              tag: 'avatar$i',
              flightShuttleBuilder: (flightContext, animation, flightDirection, fromContext, toContext) {
                // custom shuttle: scale and rotate while flying
                return RotationTransition(
                  turns: animation,
                  child: ScaleTransition(scale: animation, child: fromContext.widget),
                );
              },
              child: CircleAvatar(child: Text('A$i')),
            ),
            title: Text('Item $i'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(tag: 'avatar$i'))),
          );
        }),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String tag;
  const DetailPage({super.key, required this.tag});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(tag: tag, child: CircleAvatar(radius: 80, child: Text(tag))), 
      ),
    );
  }
}

