import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:todolist/src/bloc/todo/bloc/todo_bloc.dart';
import 'package:todolist/src/models/todo_item.dart';
import 'package:todolist/src/routes.dart';
import 'package:todolist/src/ui/index.dart';
import 'package:todolist/src/utils/index.dart';
import 'package:todolist/src/widget/index.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>
    with RouteAware, RouteObserverMixin {
  final _todoBloc = GetIt.I<TodoBloc>();

  @override
  void initState() {
    _todoBloc.add(GetTodoAllEvent());
    super.initState();
    debugPrint("TodoInit");
  }

  @override
  void dispose() {
    _todoBloc.close();
    super.dispose();
  }

  @override
  void didPopNext() {
    _todoBloc.add(GetTodoAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _todoBloc,
        builder: (context, state) {
          if (state is GetTodoAllCompleteState) {
            List<TodoItem> todoItemList = state.resource.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                final startAt = Utils.dateFormat.format(
                  DateTime.fromMillisecondsSinceEpoch(
                    todoItemList[index].startAt,
                  ),
                );
                final endAt = Utils.dateFormat.format(
                  DateTime.fromMillisecondsSinceEpoch(
                    todoItemList[index].endAt,
                  ),
                );
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  key: Key('$index'),
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmDialog(
                          todoItem: todoItemList[index],
                        );
                      },
                    );
                    if (result) {
                      _todoBloc.add(
                        TodoDeleteEvent(todoItem: todoItemList[index]),
                      );
                    }
                  },
                  child: TodoListTile(
                    title: todoItemList[index].title,
                    subTitle: "$startAt - $endAt",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddTodoPage(
                            todoItem: todoItemList[index],
                            isUpdate: true,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              itemCount: todoItemList.length,
            );
          } else {
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}
