import 'package:flutter/material.dart';
import 'package:todoapps/db/todo_db.dart';
import 'package:todoapps/model/todo.dart';
import 'package:todoapps/widget/elevated_button_widget.dart';
import 'package:todoapps/widget/form_widget.dart';
import 'package:todoapps/widget/input_label_widget.dart';

class AddFormPage extends StatefulWidget {
  final Todo? todo;
  const AddFormPage({
    Key? key,
    this.todo,
  }) : super(key: key);

  @override
  State<AddFormPage> createState() => _AddFormPageState();
}

class _AddFormPageState extends State<AddFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String itemTodo;
  late int toDone;

  @override
  void initState() {
    super.initState();

    itemTodo = widget.todo?.todoItem ?? '';
    toDone = widget.todo?.toDone ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.grey.shade100,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTodoForm(),
          ],
        ),
      ),
    );
  }

  Widget buildTodoForm() {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 50, 25, 25),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 5.0,
              spreadRadius: 3,
              offset: Offset(1, 1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: InputLabelText(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                text: "What Todo Today?",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Form(
              key: _formKey,
              child: formField(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget formField() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          FormWidget(
            onTap: () {
              print(itemTodo);
            },
            fontSize: 16,
            hintText: "Shopping, study, workout etc..",
            initValue: itemTodo,
            validator: (value) =>
                value != null && value.isEmpty ? "Cannot be empty" : null,
            onChanged: (value) => {
              setState(() {
                this.itemTodo = value;
              })
            },
          )
        ],
      ),
    );
  }

  Widget buildButton() {
    return Center(
      child: ElevatedButtonWidget(
        radius: 50,
        buttonColor: Colors.purple.shade700,
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();

          if (isValid) {
            await addTodo();
            Navigator.of(context).pop();
          }
          print("Test woi");
        },
        textColor: Colors.white,
        text: "Save",
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.045,
      ),
    );
  }

  Future addTodo() async {
    final todo = Todo(
      todoItem: itemTodo,
      toDone: 0,
    );
    await TodoDatabse.instance.create(todo);
  }
}
