part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final TodoItem todoItem;

  AddTodoEvent({this.todoItem});
}

class GetTodoAllEvent extends TodoEvent {}

class GetTodoDoneAllEvent extends TodoEvent {}

class UpdateTodoEvent extends TodoEvent {
  final TodoItem todoItem;

  UpdateTodoEvent({this.todoItem});
}

class TodoDoneEvent extends TodoEvent {
  final TodoItem todoItem;

  TodoDoneEvent({this.todoItem});
}

class TodoDeleteEvent extends TodoEvent {
  final TodoItem todoItem;

  TodoDeleteEvent({this.todoItem});
}
