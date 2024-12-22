import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddGoalPage extends StatefulWidget {
  const AddGoalPage({super.key});

  @override
  AddGoalPageState createState() => AddGoalPageState();
}

class AddGoalPageState extends State<AddGoalPage> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _progressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Goal'),
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
                final title = _titleController.text;
                final category = _categoryController.text;
                final progress = int.tryParse(_progressController.text) ?? 0;

                if (title.isNotEmpty && category.isNotEmpty) {
                  final goal = {
                    'title': title,
                    'category': category,
                    'progress': progress,
                  };
                  Hive.box('goalsBox').add(goal);
                  Navigator.pop(context);
                }
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