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
  late String desc;
  late String name;
  late int toDone;

  @override
  void initState() {
    super.initState();

    itemTodo = widget.todo?.todoItem ?? '';
    toDone = widget.todo?.toDone ?? 0;
    name = widget.todo?.name ?? '';
    desc = widget.todo?.desc ?? '';
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
            // Center(
            //   child: InputLabelText(
            //     padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            //     text: "What Todo Today?",
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.005,
            // ),
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
          InputLabelText(
            padding: EdgeInsets.all(5),
            text: "Task Name",
            fontSize: 16,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          buildTaskName(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          InputLabelText(
            padding: EdgeInsets.all(5),
            text: "Description",
            fontSize: 16,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          buildDesc(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          InputLabelText(
            padding: EdgeInsets.all(5),
            text: "Assign To",
            fontSize: 16,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          buildTaskOwner(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          InputLabelText(
            padding: EdgeInsets.all(5),
            text: "Due Date",
            fontSize: 16,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          buildDatePicker(),
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

  Widget buildTaskName() {
    return FormWidget(
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
    );
  }

  Widget buildDesc() {
    return FormWidget(
      maxline: 4,
      contentPadding: EdgeInsets.all(15),
      onTap: () {
        print(desc);
      },
      fontSize: 16,
      hintText: "Explain something here...",
      initValue: desc,
      validator: (value) =>
          value != null && value.isEmpty ? "Cannot be empty" : null,
      onChanged: (value) => {
        setState(() {
          this.desc = value;
        })
      },
    );
  }

  Widget buildTaskOwner() {
    return FormWidget(
      maxline: 1,
      onTap: () {
        print(name);
      },
      fontSize: 16,
      hintText: "Yousuf",
      initValue: name,
      validator: (value) =>
          value != null && value.isEmpty ? "Cannot be empty" : null,
      onChanged: (value) => {
        setState(() {
          this.name = value;
        })
      },
    );
  }

  Widget buildDatePicker() {
    return ElevatedButtonWidget(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.045,
      radius: 15,
      text: "${selectedDate.toLocal()}".split(' ')[0],
      buttonColor: Colors.grey.shade200,
      onPressed: () {
        _selectDate(context);
      },
    );
  }

  Future addTodo() async {
    final todo = Todo(
      todoItem: itemTodo,
      toDone: 0,
      desc: desc,
      name: name,
      createdDate: DateTime.now(),
      dueDate: selectedDate,
    );
    await TodoDatabse.instance.create(todo);
  }
}
