import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todolist/src/bloc/todo/bloc/todo_bloc.dart';
import 'package:todolist/src/routes.dart';
import 'package:todolist/src/ui/todo_done.dart';
import 'package:todolist/src/ui/todo_page.dart';
import 'package:todolist/src/widget/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _todoController = TextEditingController();
  final FocusNode _todoFocusNode = FocusNode();
  final PageController _myPage = PageController(initialPage: 0);

  final TodoBloc _todoBloc = GetIt.I<TodoBloc>();

  int _selectedIndex = 0;

  @override
  void dispose() {
    _todoBloc.close();
    _todoController.dispose();
    _todoFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: PageView(
        controller: _myPage,
        onPageChanged: (index) {
          print('Page Changes to index $index');
        },
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        children: [
          TodoPage(),
          TodoDonePage(),
        ],
      ),

      // body: Column(
      //   children: [
      //     Expanded(
      //       flex: 1,
      //       child: Container(
      //         decoration: BoxDecoration(
      //           border: Border.all(color: Colors.black),
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(
      //               5.0,
      //             ), //                 <--- border radius here
      //           ),
      //         ),
      //         child: EditableText(
      //           enableInteractiveSelection: true,
      //           maxLines: 5,
      //           controller: _todoController,
      //           focusNode: _todoFocusNode,
      //           backgroundCursorColor: Colors.white,
      //           cursorColor: Colors.black,
      //           style: TextStyle(color: Colors.black),
      //         ),
      //       ),
      //     ),
      //     Expanded(
      //       flex: 4,
      //       child: ListView.builder(
      //         itemBuilder: (context, index) {
      //           return Dismissible(
      //             background: Container(
      //               color: Colors.red,
      //               child: Center(
      //                 child: Text(
      //                   "Delete",
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             key: Key('$index'),
      //             confirmDismiss: (direction) async {
      //               return await showDialog(
      //                 context: context,
      //                 builder: (BuildContext context) {
      //                   return _buildAlertDialog(index, context);
      //                 },
      //               );
      //             },
      //             child: _buildListTile(index),
      //           );
      //         },
      //         itemCount: 10,
      //       ),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        // color: Theme.of(context).primaryColor.withAlpha(255),
        // ↑ use .withAlpha(0) to debug/peek underneath ↑ BottomAppBar
        // elevation: 0,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _myPage.jumpToPage(index);
            });
          },
          // ***** NAVBAR  *************************
          elevation: 0, // 0 removes ugly rectangular NavBar shadow
          // CRITICAL ↓ a solid color here destroys FAB notch. Use alpha 0!
          backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
          // ====================== END OF INTERESTING STUFF =================
          // selectedItemColor: Theme.of(context).colorScheme.onSurface,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Todo'),
            BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done')
          ],
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: <Widget>[
        //     IconButton(
        //       icon: Icon(
        //         Icons.home,
        //       ),
        //       onPressed: () {
        //         setState(() {
        //           _myPage.jumpTo(0);
        //           debugPrint("index0");
        //         });
        //       },
        //     ),
        //     SizedBox(width: 48.0),
        //     IconButton(
        //       icon: Icon(
        //         Icons.done,
        //       ),
        //       onPressed: () {
        //         setState(() {
        //           _myPage.jumpTo(1);
        //           debugPrint("index1");
        //         });
        //       },
        //     ),
        //   ],
        // ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutePage.todoAdd);
        },
      ),
    );
  }

  // _buildTodoListView() {
  //   return ListView.builder(
  //     itemBuilder: (context, index) {
  //       return Dismissible(
  //         background: Container(
  //           color: Colors.red,
  //           child: Center(
  //             child: Text(
  //               "Delete",
  //               style: TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //         ),
  //         key: Key('$index'),
  //         confirmDismiss: (direction) async {
  //           return await showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return ConfirmDialog();
  //             },
  //           );
  //         },
  //         child: _buildListTile(index),
  //       );
  //     },
  //     itemCount: 10,
  //   );
  // }

  _buildListTile(int index) {
    return ListTile(
      title: Text("Todo $index"),
      subtitle: Text("Sub $index"),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {},
      ),
    );
  }
}
