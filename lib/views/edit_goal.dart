import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditGoalPage extends StatefulWidget {
  final dynamic goalKey;
  final Map goal;

  const EditGoalPage({super.key, required this.goalKey, required this.goal});

  @override
  EditGoalPageState createState() => EditGoalPageState();
}

class EditGoalPageState extends State<EditGoalPage> {
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  late TextEditingController _progressController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.goal['title']);
    _categoryController = TextEditingController(text: widget.goal['category']);
    _progressController = TextEditingController(text: widget.goal['progress'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Goal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Goal Title',
                prefixIcon: const Icon(Icons.title),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(
                hintText: 'Category',
                prefixIcon: const Icon(Icons.category),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _progressController,
              decoration: InputDecoration(
                hintText: 'Progress (%)',
                prefixIcon: const Icon(Icons.percent),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedGoal = {
                  'title': _titleController.text,
                  'category': _categoryController.text,
                  'progress': int.tryParse(_progressController.text) ?? 0,
                };

                Hive.box('goalsBox').put(widget.goalKey, updatedGoal);
                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(

                foregroundColor: Colors.white, backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 16.0,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.save),
                  SizedBox(width: 8.0),
                  Text(
                    'Save Goal',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}