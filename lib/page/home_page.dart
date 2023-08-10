import 'package:flutter/material.dart';
import 'package:todoapps/db/todo_db.dart';
import 'package:intl/intl.dart';
import 'package:todoapps/model/todo.dart';
import 'package:todoapps/page/add_form_page.dart';
import 'package:todoapps/widget/todo_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<Todo> todos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshTodo();
  }

  Future refreshTodo() async {
    setState(() => isLoading = true);

    this.todos = await TodoDatabse.instance.readAllTodo();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Todo Application"),
      ),
      body: isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()),
            )
          : todos.isEmpty
              ? noData()
              : buildBody(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFormPage()),
          );
          refreshTodo();
        },
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget noData() {
    return Container(
      child: Center(
        child: Text("No Data"),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildList(),
            // TodoCard(),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            // TodoCard(),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            // TodoCard(),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            // TodoCard(),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            // TodoCard(),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];

        var formatter = DateFormat('EEEE, d MMM yyyy');
        String date = formatter.format(todo.dueDate);

        return TodoCard(
          itemTodo: todo.todoItem,
          onTap: () async {
            print(todo.todoItem + ", ${todo.toDone}, ${todo.todoId}");
            print(todo.toJson());
            _showAlertDialog(todo);
          },
          delete: () async {
            print(todo.todoItem + ", ${todo.toDone}, ${todo.todoId}");
            await TodoDatabse.instance.delete(todo.todoId!);
            refreshTodo();
          },
          name: todo.name,
          desc: todo.desc,
          dueDate: date,
        );
      },
    );
  }

  Future<void> _showAlertDialog(Todo todo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          // <-- SEE HERE
          title: const Text('Delete Todo?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to delete this task?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                await TodoDatabse.instance.delete(todo.todoId!);
                refreshTodo();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
