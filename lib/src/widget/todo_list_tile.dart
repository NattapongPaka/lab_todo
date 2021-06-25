import 'package:flutter/material.dart';

class TodoListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool showDelete;
  final Function onTap;
  final Function onDelete;

  const TodoListTile({
    Key key,
    this.title,
    this.subTitle,
    this.onTap,
    this.showDelete = false,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildListTile({String title, String sub}) {
      return ListTile(
        title: Text("$title"),
        subtitle: Text("$sub"),
        onTap: () {
          onTap?.call();
        },
        trailing: showDelete
            ? IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  onDelete?.call();
                },
              )
            : null,
      );
    }

    return _buildListTile(title: title, sub: subTitle);
  }
}
