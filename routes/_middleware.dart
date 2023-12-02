import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_server/items/items_repository.dart';
import 'package:tasklist_server/lists/task_list_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger())
  .use(provider<String>((context) => 'Alpha learns Dart Frog'))
  .use(provider<TaskListRepository>((context) => TaskListRepository()))
  .use(provider<TaskItemRepository>((context) => TaskItemRepository()));
}
