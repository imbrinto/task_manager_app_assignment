import 'package:task_manager_app_assignment/data/models/task_by_status_count_model.dart';

class TaskCountByStatusWrapperModel {
  String? status;
  List<TaskCountByStatusModel>? taskCountByStatusList;

  TaskCountByStatusWrapperModel({this.status, this.taskCountByStatusList});

  TaskCountByStatusWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountByStatusList = <TaskCountByStatusModel>[];
      json['data'].forEach((v) {
        taskCountByStatusList!.add(TaskCountByStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskCountByStatusList != null) {
      data['data'] = taskCountByStatusList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

