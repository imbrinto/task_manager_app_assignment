import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/models/task_list_wrapper_model.dart';
import 'package:task_manager_app_assignment/data/models/task_model.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';
import 'package:task_manager_app_assignment/ui/widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _getCancelledTask,
        child: Visibility(
          visible: _getCancelledTaskInProgress == false,
          replacement: const CentredProgressIndicator(),
          child: ListView.builder(
            itemCount: cancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskItem(
                taskModel: cancelledTaskList[index],
                onUpdateTask: () {
                  _getCancelledTask();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCancelledTask() async {
    _getCancelledTaskInProgress = true;
    if (mounted) setState(() {});

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.cancelledTasks);
    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      cancelledTaskList = taskListWrapperModel.taskList ?? [];
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ?? 'Get cancelled tasks failed! Try again.',
            true);
      }
    }
    _getCancelledTaskInProgress = false;
    if (mounted) setState(() {});
  }
}
