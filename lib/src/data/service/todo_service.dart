import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todolist/src/data/db/db.dart';
import 'package:todolist/src/models/resource_model.dart';
import 'package:todolist/src/models/todo_item.dart';

class TodoService {
  final Db db;
  final Logger logger;

  TodoService({
    this.db,
    this.logger,
  });

  Future<Resource<int>> addTodo({TodoItem todoItem}) async {
    int result = await db.insertTodo(todo: todoItem);
    if (result != -1) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "Add todo success",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Add todo faile",
      );
    }
  }

  Future<Resource<int>> updateTodo({TodoItem todoItem}) async {
    int result = await db.updateTodo(todo: todoItem);
    if (result != -1) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "Update todo success",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Update todo faile",
      );
    }
  }

  getAllTodo() async {
    List<TodoItem> result = await db.getTodoAll();
    if (result.isNotEmpty) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "All todo",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Empty...",
      );
    }
  }

  getTodoDoneAll() async {
    List<TodoItem> result = await db.getTodoDoneAll();
    if (result.isNotEmpty) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "All todo",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Empty...",
      );
    }
  }

  deleteTodo({@required int todoId}) async {
    final int result = await db.deleteTodo(todoId);
    if (result != -1) {
      return Resource(
        data: result,
        status: Status.SUCCESS,
        msg: "Delete todo success",
      );
    } else {
      return Resource(
        data: null,
        status: Status.ERROR,
        msg: "Delete todo faile",
      );
    }
  }
}
