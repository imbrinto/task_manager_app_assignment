import 'package:flutter/material.dart';

class TaskSummeryCard extends StatelessWidget {
  final String count;
  final String title;
  const TaskSummeryCard({
    super.key, required this.count, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(count,style: Theme.of(context).textTheme.titleLarge),
            Text(title,style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}