import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:tasklist_server/extensions.dart';

///in memeory cache for testing
@visibleForTesting
Map<String, TaskList> taskListDB = {};

///tasklist object
class TaskList {
  ///constructor
  TaskList({required this.id, required this.name});

  ///serialization
  factory TaskList.fromMap(Map<String, dynamic> map) {
    return TaskList(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  ///deserialization
  factory TaskList.fromJson(String source) =>
      TaskList.fromMap(json.decode(source) as Map<String, dynamic>);

  /// task id
  final String id;

  ///task name
  final String name;

  ///toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  ///toJson
  String toJson() => json.encode(toMap());

  ///copyWith method
  TaskList copyWith({
    String? id,
    String? name,
  }) {
    return TaskList(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}

///repository
class TaskListRepository {
  ///fetch taskList by ID or return null if id not found
  Future<TaskList?> getTaskById(String id) async => taskListDB[id];

  ///fetch all lists
  Map<String, dynamic> fetchAllTasks() {
    final formttedlists = <String, dynamic>{};

    if (taskListDB.isNotEmpty) {
      taskListDB.forEach((key, value) {
        formttedlists[key] = value.toJson();
      });
    }

    return formttedlists;
  }

  ///create a new List
  String createList({required String name}) {
    final id = name.getHashValue;
    final taskList = TaskList(id: id, name: name);
    taskListDB[id] = taskList;
    return id;
  }

  ///delete list with id
  void deleteList(String id) {
    taskListDB.remove(id);
  }

  ///update taskList
  Future<void> updateList({required String name, required String id}) async {
    final currentList = taskListDB[id];

    if (currentList != null) {
      return Future.error(Exception('List not found'));
    }

    final list = TaskList(id: id, name: name);
    taskListDB[id] = list;
  }
}
