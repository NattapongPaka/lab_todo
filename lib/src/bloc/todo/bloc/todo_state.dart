part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoAddCompleteState extends TodoState {
  final Resource resource;

  TodoAddCompleteState({this.resource});
}

class TodoAddFaileState extends TodoState {
  final Resource resource;
  TodoAddFaileState({this.resource});
}

class GetTodoAllCompleteState extends TodoState {
  final Resource resource;
  GetTodoAllCompleteState({this.resource});
}

class GetTodoAllEmptyState extends TodoState {}

// class GetTodoDoneAllCompleteState extends TodoState {
//   final Resource resource;

//   GetTodoDoneAllCompleteState({this.resource});
// }

class UpdateTodoCompleteState extends TodoState {}

class UpdateTodoFaileState extends TodoState {}

class GetTodoDoneAllCompleteState extends TodoState {
  final Resource resource;

  GetTodoDoneAllCompleteState({this.resource});
}

class GetTodoDoneAllEmptyState extends TodoState {}
