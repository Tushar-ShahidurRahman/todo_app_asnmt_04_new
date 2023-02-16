import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List todoList = [];
  String item = '';
  final _formKey = GlobalKey<FormState>();

  void addTodoList(value) {
    item = value;
    // setState(() {});
  }

  createNewTodo() {
    todoList.add({"item": item});
    setState(() {});
  }

  deleteItem(index) {
    todoList.removeAt(index);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo page'),
      ),
      body: Form(
        // Taking the from for validation purpose. No empty value is allowed.
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        flex: 7,
                        child: TextFormField(
                          maxLines: 10,
                          onChanged: (value) {
                            addTodoList(value);
                          },
                          // Can not submit empty field.
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return "This field can't be empty";
                            } return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              labelText: 'Todo notes'),
                        )),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        flex: 3,
                        child: ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()) {
                              createNewTodo();}
                            },
                            child: const Text('Add todos')))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 9,
                // child: Text('List view'),
                child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    final listItemTitle = todoList[index]['item'];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        leading: const Icon(Icons.note_add, size: 15,),
                        tileColor: Colors.black12,
                        title: Text(listItemTitle),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.amber,
                          onPressed: () {
                            deleteItem(index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
