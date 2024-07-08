import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/models/task_list_wrapper_model.dart';
import 'package:task_manager_app_assignment/data/models/task_model.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';
import 'package:task_manager_app_assignment/ui/widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<TaskModel> completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async => _getCompletedTask,
        child: Visibility(
          visible: _getCompletedTaskInProgress == false,
          replacement: const CentredProgressIndicator(),
          child: ListView.builder(
            itemCount: completedTaskList.length,
            itemBuilder: (context, index) {
               return TaskItem(taskModel: completedTaskList[index],
               onUpdateTask: (){
                 _getCompletedTask();
               },);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTask() async {
    _getCompletedTaskInProgress = true;
    if (mounted) setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      completedTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get completed tasks failed! Try again.', true);
      }
    }
    _getCompletedTaskInProgress = false;
    if (mounted) setState(() {});
  }
}
