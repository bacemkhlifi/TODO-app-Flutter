import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  addTask({Task? task}) async {
    await DBHelper.insert(task!);
    // Don't call getTasks here; it will be called separately.
  }


  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    print(taskList.length);
  }

  deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
