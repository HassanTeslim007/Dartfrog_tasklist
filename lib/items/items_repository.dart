import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:tasklist_server/extensions.dart';

///in memeory cache for testing
@visibleForTesting
Map<String, TaskItem> taskItemDB = {};

///tasklist object
class TaskItem {
  /// default constructor
  TaskItem({
    required this.listId,
    required this.description,
    required this.status,
    required this.id,
    required this.name,
  });

  ///deserialization
  factory TaskItem.fromMap(Map<String, dynamic> map) {
    return TaskItem(
      id: map['id'] as String,
      listId: map['listId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
    );
  }

  ///fromJson
  factory TaskItem.fromJson(String source) =>
      TaskItem.fromMap(json.decode(source) as Map<String, dynamic>);

  /// item id
  final String id;

  ///items's list id
  final String listId;

  ///task name
  final String name;

  ///item's description
  final String description;

  ///item's status
  final String status;

  ///toMap
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'listId': listId,
      'name': name,
      'description': description,
      'status': status,
    };
  }

  ///toJson
  String toJson() => json.encode(toMap());
}

///repository
class TaskItemRepository {
  ///fetch task by ID or return null if id not found
  Future<TaskItem?> getTaskById(String id) async => taskItemDB[id];

  ///fetch all Tasks
  Map<String, dynamic> fetchAllTasks() {
    final formttedlists = <String, dynamic>{};

    if (taskItemDB.isNotEmpty) {
      taskItemDB.forEach((key, value) {
        formttedlists[key] = value.toJson();
      });
    }

    return formttedlists;
  }

  ///create a new Task
  String createTask({
    required String name,
    required String status,
    required String listId,
    String? description,
  }) {
    final id = name.getHashValue;
    final task = TaskItem(
      id: id,
      name: name,
      description: description ?? '',
      status: status,
      listId: listId,
    );
    taskItemDB[id] = task;
    return id;
  }

  ///delete [TaskItem] with id
  void deleteTask(String id) {
    taskItemDB.remove(id);
  }

  ///update taskTask
  Future<void> updateList({
    required String id,
    required String name,
    required String status,
    required String listId,
    String? description,
  }) async {
    final currentList = taskItemDB[id];
    if (currentList != null) {
      return Future.error(Exception('List not found'));
    }

    final task = TaskItem(
      id: id,
      name: name,
      description: description ?? '',
      status: status,
      listId: listId,
    );
    taskItemDB[id] = task;
  }
}
