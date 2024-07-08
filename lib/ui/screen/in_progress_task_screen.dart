import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/models/task_list_wrapper_model.dart';
import 'package:task_manager_app_assignment/data/models/task_model.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';
import 'package:task_manager_app_assignment/ui/widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getInProgressTasksInProgress = false;
  List<TaskModel> inProgressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getInProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async => _getInProgressTask,
        child: Visibility(
          visible: _getInProgressTasksInProgress == false,
          replacement: const CentredProgressIndicator(),
          child: ListView.builder(
            itemCount: inProgressTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: inProgressTaskList[index],
                onUpdateTask: () {
                  _getInProgressTask();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getInProgressTask() async {
    _getInProgressTasksInProgress = true;
    if (mounted) setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.inProgressTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      inProgressTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get in progress tasks failed! Try again.', true);
      }
    }
    _getInProgressTasksInProgress = false;
    if (mounted) setState(() {});
  }
}
