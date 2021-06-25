import 'package:flutter/material.dart';
import 'package:todolist/src/ui/detail_page.dart';
import 'package:todolist/src/ui/index.dart';
import 'package:todolist/src/ui/todo_done.dart';
import 'package:todolist/src/ui/todo_page.dart';

class RoutePage {
  RoutePage._();

  static final init = "/";
  static final splash = "/splashPage";
  static final main = "/mainPage";

  static final todo = "/todoPage";
  static final todoDone = "/todoDonePage";
  // static final todoDetail = "/detailPage";
  static final todoAdd = "/addPage";
}

class Routes {
  Routes._();

  static var route = {
    RoutePage.init: (BuildContext context) => SplashPage(),
    RoutePage.main: (BuildContext context) => MainPage(),
    RoutePage.todo: (BuildContext context) => TodoPage(),
    RoutePage.todoDone: (BuildContext context) => TodoDonePage(),
    // RoutePage.todoDetail: (BuildContext context) => DetailPage(),
    RoutePage.todoAdd: (BuildContext context) => AddTodoPage(),
  };
}
