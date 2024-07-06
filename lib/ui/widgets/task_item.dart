import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: ListTile(
        title: const Text(
          'Title will be here',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              'Date: 12/12/24',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: const Text('New'),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                ButtonBar(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
