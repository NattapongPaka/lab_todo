import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todolist/src/base/base_stateful.dart';
import 'package:todolist/src/bloc/todo/bloc/todo_bloc.dart';
import 'package:todolist/src/constants/index.dart';
import 'package:todolist/src/models/todo_item.dart';
import 'package:todolist/src/utils/index.dart';
import 'package:todolist/src/widget/index.dart';

class AddTodoPage extends StatefulWidget {
  final TodoItem todoItem;
  final bool isUpdate;
  final bool readOnly;

  const AddTodoPage({
    Key key,
    this.todoItem,
    this.isUpdate = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends BasePageState<AddTodoPage> {
  final _edtTitleController = TextEditingController();
  final _edtSubtitleController = TextEditingController();
  final _edtStartAtController = TextEditingController();
  final _edtEndAtController = TextEditingController();

  final _key = GlobalKey<FormState>();

  final _todoBloc = GetIt.I<TodoBloc>();

  bool _fieldRequired = true;
  DateTime _selectedDate;
  String _gender;
  String _currentSelectedValue;

  _selectDate({@required TextEditingController edt}) async {
    DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      edt
        ..text = Utils.dateFormat.format(_selectedDate)
        ..selection = TextSelection.fromPosition(
          TextPosition(
            offset: edt.text.length,
            affinity: TextAffinity.upstream,
          ),
        );
    }
  }

  @override
  void initState() {
    if ((widget.isUpdate || widget.readOnly) && widget.todoItem != null) {
      _edtTitleController.text = widget.todoItem.title;
      _edtSubtitleController.text = widget.todoItem.detail;
      _edtStartAtController.text = Utils.dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(widget.todoItem.startAt),
      );
      _edtEndAtController.text = Utils.dateFormat.format(
        DateTime.fromMillisecondsSinceEpoch(widget.todoItem.endAt),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _todoBloc.close();
    super.dispose();
  }

  @override
  Widget builds(BuildContext context) {
    _buildAppBarTitle() {
      if (widget.readOnly) {
        return Text("Detail");
      } else {
        return widget.isUpdate ? Text("Update") : Text("Add");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        actions: widget.readOnly
            ? null
            : [
                IconButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      DateTime dtStartAt = Utils.dateFormat.parse(
                        _edtStartAtController.text,
                      );
                      DateTime dtEndAt = Utils.dateFormat.parse(
                        _edtEndAtController.text,
                      );
                      if (widget.isUpdate) {
                        TodoItem todoItem = TodoItem(
                          id: widget.todoItem.id,
                          title: _edtTitleController.text,
                          detail: _edtSubtitleController.text,
                          startAt: dtStartAt?.millisecondsSinceEpoch,
                          endAt: dtEndAt?.millisecondsSinceEpoch,
                          complete: 0,
                          createAt: DateTime.now().millisecondsSinceEpoch,
                        );
                        _todoBloc.add(UpdateTodoEvent(todoItem: todoItem));
                      } else {
                        TodoItem todoItem = TodoItem(
                          title: _edtTitleController.text,
                          detail: _edtSubtitleController.text,
                          startAt: dtStartAt?.millisecondsSinceEpoch,
                          endAt: dtEndAt?.millisecondsSinceEpoch,
                          complete: 0,
                          createAt: DateTime.now().millisecondsSinceEpoch,
                        );
                        _todoBloc.add(AddTodoEvent(todoItem: todoItem));
                      }
                    }
                  },
                  icon: Icon(
                    Icons.save_rounded,
                  ),
                )
              ],
      ),
      body: BlocListener(
        bloc: _todoBloc,
        listener: (context, state) {
          if (state is TodoAddCompleteState ||
              state is UpdateTodoCompleteState) {
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: Spacing.s, right: Spacing.s),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  DefaultTextField2Line(
                    title: "หัวข้อ",
                    controller: _edtTitleController,
                    requires: _fieldRequired,
                    readOnly: widget.readOnly,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                  ),
                  DefaultTextField2Line(
                    title: "รายละเอียด",
                    requires: _fieldRequired,
                    controller: _edtSubtitleController,
                    readOnly: widget.readOnly,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                    maxLine: 5,
                  ),
                  DefaultTextField2Line(
                    focusNode: AlwaysDisabledFocusNode(),
                    title: "StartAt",
                    controller: _edtStartAtController,
                    requires: _fieldRequired,
                    readOnly: widget.readOnly,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                    onTap: widget.readOnly
                        ? null
                        : () {
                            _selectDate(
                              edt: _edtStartAtController,
                            );
                          },
                  ),
                  DefaultTextField2Line(
                    focusNode: AlwaysDisabledFocusNode(),
                    title: "EndAt",
                    controller: _edtEndAtController,
                    readOnly: widget.readOnly,
                    requires: _fieldRequired,
                    validator:
                        _fieldRequired ? Validator.isEmptyValidator : null,
                    onTap: widget.readOnly
                        ? null
                        : () {
                            _selectDate(
                              edt: _edtEndAtController,
                            );
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.isUpdate
          ? Padding(
              padding: EdgeInsets.only(left: Spacing.s, right: Spacing.s),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: Spacing.xs),
                      child: TextButton(
                        child: Text("Done"),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          final todoItem = widget.todoItem.copyWith(
                            complete: 1,
                          );
                          _todoBloc.add(
                            TodoDoneEvent(todoItem: todoItem),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: Spacing.xs),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                        child: Text("Delete"),
                        onPressed: () {
                          _todoBloc.add(
                            TodoDeleteEvent(todoItem: widget.todoItem),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
