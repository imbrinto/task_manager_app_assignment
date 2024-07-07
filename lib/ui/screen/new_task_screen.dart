import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/models/task_list_wrapper_model.dart';
import 'package:task_manager_app_assignment/data/models/task_model.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/screen/add_new_task_screen.dart';
import 'package:task_manager_app_assignment/ui/utilities/app_colors.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';
import 'package:task_manager_app_assignment/ui/widgets/task_item.dart';
import 'package:task_manager_app_assignment/ui/widgets/task_manager_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;
  List<TaskModel> newTaskList = [];

  @override
  void initState() {
    super.initState();
    _getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildTaskSummerySection(),
          const SizedBox(height: 14),
          Expanded(
            child: Visibility(
              visible: _getNewTaskInProgress == false,
              replacement: const CentredProgressIndicator(),
              child: ListView.builder(
                itemCount: newTaskList.length,
                itemBuilder: (context, index) {
                  return TaskItem(taskModel: newTaskList[index],);
                },
              ),
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

  Future<void> _getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      newTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if(mounted){
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get new task failed! Try again.', true);
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) setState(() {});
  }

  void _onTapNavAddNewTaskScreen() {
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
