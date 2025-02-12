class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createTask = '$_baseUrl/createTask';
  static const String newTasks = '$_baseUrl/listTaskByStatus/New';
  static const String completedTasks = '$_baseUrl/listTaskByStatus/Completed';
  static const String inProgressTasks = '$_baseUrl/listTaskByStatus/InProgress';
  static const String cancelledTasks = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String taskStatusCount = '$_baseUrl/taskStatusCount';
  static const String profileUpdate = '$_baseUrl/profileUpdate';
  static const String recoverPassword = '$_baseUrl/RecoverResetPass';

  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';

  static String recoverEmail(String emailAddress) =>
      '$_baseUrl/RecoverVerifyEmail/$emailAddress';
  static String recoveryOTP(String emailAddress,String otp) =>
      '$_baseUrl/RecoverVerifyOTP/$emailAddress/$otp';

  static String updateTaskStatus(String id, String updatedStatus) =>
      '$_baseUrl/updateTaskStatus/$id/${updatedStatus.trim()}';
}
