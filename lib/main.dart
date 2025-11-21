import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  // Load from SharedPreferences
  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString("tasks");

    if (savedData != null) {
      setState(() {
        tasks = List<Map<String, dynamic>>.from(jsonDecode(savedData));
      });
    }
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("tasks", jsonEncode(tasks));
  }


  void addTask() {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
          title: Text("Add Task"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Enter task title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
        onPressed: () {
        String newTitle = controller.text.trim();


        if (newTitle.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("The task title cannot be empty.")),
        );
        return;
        }


        bool exists = tasks.any((task) =>
        task["title"].toString().toLowerCase() == newTitle.toLowerCase());

        if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("task title already exists")),
        );
        return;
        }

        setState(() {
        tasks.add({
        "title": newTitle,
        "done": false,
        });
        saveTasks();
        });

        Navigator.pop(context);
        },

              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }


  void editTask(int index) {
    TextEditingController controller =
    TextEditingController(text: tasks[index]["title"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
          title: Text("Edit Task"),
          content: TextField(
            controller: controller,decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks[index]["title"] = controller.text;
                  saveTasks();
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void clearCompleted() {
    setState(() {
      tasks.removeWhere((task) => task["done"] == true);

      if(tasks.length<1){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("The task list is empty")),
        );
      }

      saveTasks();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "To Do List",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22, color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep, color: Colors.white,),
            onPressed: clearCompleted,
          ),
        ],
      ),
      body:tasks.isEmpty
          ? Center(
        child: Text(
          "Your tasks will appear here",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
                saveTasks();
              });
            },
              child: Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    value: tasks[index]["done"],
                    onChanged: (value) {
                      setState(() {
                        tasks[index]["done"] = value;
                        saveTasks();
                      });
                    },
                  ),
                  title: Text(
                    tasks[index]["title"],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: tasks[index]["done"]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.indigo,
                    onPressed: () => editTask(index),
                  ),
                ),
              ),

          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: Icon(Icons.add, size: 40, color: Colors.white,),
      ),
    );
  }
}
