import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'add_goal.dart';
import 'edit_goal.dart';

class GoalListPage extends StatelessWidget {
  final Box goalsBox = Hive.box('goalsBox');

  GoalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoalMate'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: goalsBox.listenable(),
        builder: (context, Box box, _) {
          final goals = box.values.toList();
          final groupedGoals = <String, List<Map>>{};

          for (var goal in goals) {
            final category = goal['category'];
            if (!groupedGoals.containsKey(category)) {
              groupedGoals[category] = [];
            }
            groupedGoals[category]!.add(goal);
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            itemCount: groupedGoals.keys.length,
            itemBuilder: (context, index) {
              final category = groupedGoals.keys.elementAt(index);
              final categoryGoals = groupedGoals[category]!;

              return Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: ExpansionTile(
                    collapsedBackgroundColor: Colors.grey[200],
                    backgroundColor: Colors.white,
                    title: Text(
                      category,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    children: categoryGoals.map((goal) {
                      final progress = goal['progress'];
                      Color progressColor;

                      if (progress < 50) {
                        progressColor = Colors.red;
                      } else if (progress > 85) {
                        progressColor = Colors.green;
                      } else {
                        progressColor = Colors.yellow;
                      }

                      return ListTile(
                        title: Text(
                          goal['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  width: progress * 2.5,
                                  decoration: BoxDecoration(
                                    color: progressColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      '$progress%',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            final key = box.keys.firstWhere((k) => box.get(k) == goal);
                            box.delete(key);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditGoalPage(
                                goalKey: box.keys.firstWhere((k) => box.get(k) == goal),
                                goal: goal,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGoalPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
