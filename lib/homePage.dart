import 'package:flutter/material.dart';
import 'package:todo_app/tasks.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  final List<Task> tasks = List();
  //
  @override
  void initState() {
    super.initState();
    //add some predefined tasks
    setState(() {
      tasks.add(Task("mek sum", "huuuuuuuuuuuuue", "11:69", Colors.blue));
      tasks.add(Task("Guuner Sata vanga", "huhuhuuhu", "03:69", Colors.red));
      tasks.add(
          Task("Vodai er  Sata vanga", "huhuhuuhu", "12:62", Colors.yellow));
      tasks.add(Task("Guuner Sata vanga", "huhuhuuhu", "06:89", Colors.purple));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: Colors.black,
                  gradient: LinearGradient(
                    colors: [Color(0xff2da9ef), Color(0xff8d70fe)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: _headerContent(),
              ),
            ),
            Positioned(
              top: 160.0,
              left: 18.0,
              right: 18.0,
              bottom: 15.0,
              child: Container(
                color: Colors.white,
                width: 360.0,
                height: MediaQuery.of(context).size.height / 1.5,
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(tasks[index].toString()),
                      background: _hiddenContainer(tasks[index].taskColor),
                      child: _listContainer(
                          tasks[index].taskName,
                          tasks[index].subTask,
                          tasks[index].time,
                          tasks[index].taskColor),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.startToEnd) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Task Deleted",
                              style: TextStyle(color: Colors.black),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.white,
                          ));
                          if (tasks.contains(tasks.removeAt(index))) {
                            setState(() {
                              tasks.remove(tasks.removeAt(index));
                            });
                          }
                        } else if (direction == DismissDirection.endToStart) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Task archieved",
                              style: TextStyle(color: Colors.black),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.white,
                          ));
                        }
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        tooltip: 'Add new task',
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final taskVal = TextEditingController();
                final subtask = TextEditingController();
                final taskTime = TextEditingController();
                Color taskColor;

                return AlertDialog(
                  title: Text("Add new task"),
                  content: Container(
                    height: 220.0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextField(
                            controller: taskVal,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Task Title',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          child: TextField(
                            controller: subtask,
                            textAlign: TextAlign.left,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Sub task',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  taskColor = Colors.purple;
                                },
                                child: Container(
                                  width: 15.0,
                                  height: 15.0,
                                  color: Colors.purple,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  taskColor = Colors.blue;
                                },
                                child: Container(
                                  width: 15.0,
                                  height: 15.0,
                                  color: Colors.blue,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  taskColor = Colors.yellow;
                                },
                                child: Container(
                                  width: 15.0,
                                  height: 15.0,
                                  color: Colors.yellow,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  taskColor = Colors.red;
                                },
                                child: Container(
                                  width: 15.0,
                                  height: 15.0,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: TextField(
                            controller: taskTime,
                            obscureText: false,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'task time',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      color: Colors.blueAccent,
                      child: Text(
                        "Add Task",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          tasks.add(Task(taskVal.text, subtask.text,
                              taskTime.text, taskColor));
                        });
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: IconButton(
                  icon: Icon(Icons.settings),
                  // padding: EdgeInsets.only(right: 20.0),
                  color: Colors.white70,
                  tooltip: 'open settings',
                  onPressed: () {}),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.white70,
                  // padding: EdgeInsets.only(left: 20.0),
                  tooltip: 'search tasks',
                  onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }

  Widget _headerContent() {
    return Align(
      child: ListTile(
        leading: Text(
          "👋",
          style: TextStyle(fontSize: 30.0),
        ),
        title: Text(
          "DNI9",
          style: TextStyle(
              fontSize: 25.0,
              color: Color(0xfffefaff),
              letterSpacing: 3.0,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Here are the list of tasks...",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  Widget _listContainer(
      String taskName, String subTask, String time, Color taskColor) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xf2f7f7ff),
        ),
        child: Row(
          children: <Widget>[
            Container(height: 80.0, width: 5.0, color: taskColor),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Text(
                          taskName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Text(
                          subTask,
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          time,
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _hiddenContainer(Color taskColor) {
    return Container(
      // height: MediaQuery.of(context).size.height / 0.5,
      color: taskColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                setState(() {});
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(Icons.archive),
              color: Colors.white,
              onPressed: () {
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}
