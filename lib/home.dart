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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              semanticLabel: "settings",
            ),
            onPressed: () {
              print("Settings");
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // [BASIC ACTIONS BAR]
            Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        semanticLabel: "add habit",
                      ),
                      onPressed: () {
                        print("Add Habit Button");
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // [HABITS OVERVIEW]
            GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 5/1.8,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              children: const [
                HabitCard(name: "Liegestütz", description: "1x pro Tag", streak: 8),
              ],
            ),
          ],
        ),
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
                        style: const TextStyle(fontSize: 16.0)
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        description,
                        semanticsLabel: "description",
                        style: const TextStyle(fontStyle: FontStyle.italic)
                      ),
                    ],
                  ),
                )
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                child: Text(
                  streak.toString(),
                  semanticsLabel: "streak",
                  style: const TextStyle(fontSize: 30.0)
                )
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.more_horiz,
                    semanticLabel: "more",
                  ),
                  onPressed: () {
                    print("More Button");
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.check,
                    semanticLabel: "check",
                  ),
                  onPressed:() {
                    print("Check Button");
                  },
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}