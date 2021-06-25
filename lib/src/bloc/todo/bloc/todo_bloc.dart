import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:todolist/src/data/service/todo_service.dart';
import 'package:todolist/src/models/resource_model.dart';
import 'package:todolist/src/models/todo_item.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService todoService;
  final Logger logger;

  TodoBloc({
    this.todoService,
    this.logger,
  }) : super(TodoInitial());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is AddTodoEvent) {
      final todoItem = event.todoItem;
      final Resource result = await todoService.addTodo(todoItem: todoItem);
      if (result.status == Status.SUCCESS) {
        yield TodoAddCompleteState(resource: result);
      } else {
        yield TodoAddFaileState(resource: result);
      }
    }

    if (event is GetTodoAllEvent) {
      final Resource result = await todoService.getAllTodo();
      if (result.status == Status.SUCCESS) {
        //logger.d(result.data);
        yield GetTodoAllCompleteState(resource: result);
      } else {
        yield GetTodoAllEmptyState();
      }
    }

    if (event is UpdateTodoEvent) {
      final todoItem = event.todoItem;
      final Resource result = await todoService.updateTodo(todoItem: todoItem);
      if (result.status == Status.SUCCESS) {
        yield UpdateTodoCompleteState();
      } else {
        yield UpdateTodoFaileState();
      }
    }

    if (event is TodoDoneEvent) {
      final todoItem = event.todoItem;
      final Resource result = await todoService.updateTodo(todoItem: todoItem);
      if (result.status == Status.SUCCESS) {
        yield UpdateTodoCompleteState();
      } else {
        yield UpdateTodoFaileState();
      }
    }

    if (event is GetTodoDoneAllEvent) {
      final Resource result = await todoService.getTodoDoneAll();
      if (result.status == Status.SUCCESS) {
        //logger.d(result.data);
        yield GetTodoDoneAllCompleteState(resource: result);
      } else {
        yield GetTodoDoneAllEmptyState();
      }
    }

    if (event is TodoDeleteEvent) {
      final todoItem = event.todoItem;
      final Resource result = await todoService.deleteTodo(todoId: todoItem.id);
      if (result.status == Status.SUCCESS) {
        yield UpdateTodoCompleteState();
        add(GetTodoAllEvent());
      }
    }
  }
}
