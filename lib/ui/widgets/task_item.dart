import 'package:flutter/material.dart';
import 'package:task_manager_app_assignment/data/models/network_response.dart';
import 'package:task_manager_app_assignment/data/models/task_model.dart';
import 'package:task_manager_app_assignment/data/network_caller/network_caller.dart';
import 'package:task_manager_app_assignment/data/utilities/urls.dart';
import 'package:task_manager_app_assignment/ui/widgets/centred_progress_indicator.dart';
import 'package:task_manager_app_assignment/ui/widgets/show_snack_bar_message.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
    required this.onUpdateTask,
  });

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteInProgress = false;
  bool _editInProgress = false;
  String dropdownValue = '';
  List<String> statusList = [
    'New',
    'In Progress',
    'Completed',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: ListTile(
        title: Text(
          widget.taskModel.title ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.description ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              'Date: ${widget.taskModel.createdDate ?? ''}',
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(widget.taskModel.status ?? 'New'),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                ButtonBar(
                  children: [
                    IconButton(
                      onPressed: () {
                        _deleteTask();
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    Visibility(
                      visible: _editInProgress == false,
                      replacement: const CentredProgressIndicator(),
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.edit),
                        onSelected: (String selectedValue) {
                          setState(() {
                            dropdownValue = selectedValue;
                            _updateTaskStatus();
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return statusList.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: ListTile(
                                title: Text(choice),
                                trailing: dropdownValue == choice
                                    ? const Icon(Icons.done)
                                    : null,
                              ),
                            );
                          }).toList();
                        },
                      ),
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

  Future<void> _deleteTask() async {
    _deleteInProgress = true;
    if (mounted) setState(() {});

    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.sId!));
    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get task count by status failed! Try again.',
            true);
      }
    }
    _deleteInProgress = false;
    if (mounted) setState(() {});
  }

  Future<void> _updateTaskStatus() async {
    _editInProgress = true;
    if (mounted) setState(() {});

    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.updateTaskStatus(widget.taskModel.sId!, dropdownValue));
    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get task count by status failed! Try again.',
            true);
      }
    }
    _editInProgress = false;
    if (mounted) setState(() {});
  }
}
