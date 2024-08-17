import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            semanticLabel: "menu",
          ),
          onPressed: () {
            print("Menu Button");
          },
        ),
        title: const Text("Habit"),
      ),
      body: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 5/1.8,
        mainAxisSpacing: 10,
        children: const [
          HabitCard(name: "Liegestütz", description: "1x pro Tag", streak: 8),
        ],
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.name,
    required this.description,
    required this.streak,
  });

  final String name;
  final String description;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        semanticsLabel: "name",
                        style: TextStyle(fontSize: 16.0)
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        description,
                        semanticsLabel: "description",
                        style: TextStyle(fontStyle: FontStyle.italic)
                      ),
                    ],
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                color: Colors.black87,
                child: Text(
                  streak.toString(),
                  semanticsLabel: "streak",
                  style: TextStyle(color: Colors.white, fontSize: 30.0)
                )
              )
            ],
          )
        ],
      )
    );
  }
}