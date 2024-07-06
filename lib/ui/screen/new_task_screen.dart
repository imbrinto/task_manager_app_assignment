import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/ui/screen/add_new_task_screen.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/task_item.dart';
import 'package:task_manager_app_assignment/ui/widgets/task_manager_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTaskSummerySection(),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const TaskItem();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        onPressed: _onTapNavAddNewTaskScreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapNavAddNewTaskScreen(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }
  Widget _buildTaskSummerySection() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummeryCard(
            count: '36',
            title: 'New Task',
          ),
          TaskSummeryCard(
            count: '36',
            title: 'Completed',
          ),
          TaskSummeryCard(
            count: '36',
            title: 'In Progress',
          ),
          TaskSummeryCard(
            count: '36',
            title: 'Cancelled',
          ),
        ],
      ),
    );
  }
}


