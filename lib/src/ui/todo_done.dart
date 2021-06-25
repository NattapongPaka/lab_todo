import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todolist/src/bloc/todo/bloc/todo_bloc.dart';
import 'package:todolist/src/models/todo_item.dart';
import 'package:todolist/src/ui/index.dart';
import 'package:todolist/src/widget/index.dart';

class TodoDonePage extends StatefulWidget {
  const TodoDonePage({Key key}) : super(key: key);

  @override
  _TodoDonePageState createState() => _TodoDonePageState();
}

class _TodoDonePageState extends State<TodoDonePage> {
  final _todoBloc = GetIt.I<TodoBloc>();

  @override
  void initState() {
    _todoBloc.add(GetTodoDoneAllEvent());
    super.initState();
    debugPrint("TodoDone");
  }

  @override
  void dispose() {
    _todoBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _todoBloc,
        builder: (context, state) {
          if (state is GetTodoDoneAllCompleteState) {
            final List<TodoItem> todoItemList = state.resource.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return TodoListTile(
                  title: "${todoItemList[index].title}",
                  subTitle: "${todoItemList[index].detail}",
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddTodoPage(
                          readOnly: true,
                          todoItem: todoItemList[index],
                        ),
                      ),
                    );
                  },
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
