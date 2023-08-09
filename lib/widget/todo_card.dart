import 'package:flutter/material.dart';

class TodoCard extends StatefulWidget {
  final String itemTodo;
  final void Function()? onTap;
  final void Function()? delete;
  final void Function()? update;

  @override
  _TodoCardState createState() => _TodoCardState();

  const TodoCard({
    Key? key,
    required this.itemTodo,
    this.onTap,
    this.delete,
    this.update,
  }) : super(key: key);
}

class _TodoCardState extends State<TodoCard> {
  int toDone = 0;
  TextDecoration textDeco = TextDecoration.none;

  doneButton() {
    setState(() {
      if (toDone == 0) {
        toDone = 1;
        textDeco = TextDecoration.lineThrough;
      } else {
        toDone = 0;
        textDeco = TextDecoration.none;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black45.withOpacity(0.2),
                offset: const Offset(
                  2.0,
                  1.0,
                ),
                blurRadius: 5.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.itemTodo,
                style: TextStyle(decoration: textDeco),
              ),
              Container(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        doneButton();
                        print(toDone);
                      },
                      icon: Icon(Icons.done_outline_rounded),
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: widget.delete,
                      icon: Icon(Icons.delete_outline_rounded),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}