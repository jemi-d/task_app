import 'package:flutter/material.dart';
import 'package:tf1/ui/task_commencement.dart';
import '../local/database.dart';
import 'add_task_page.dart';
import 'auth_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isSidebarOpen = true;
  final AppDatabase _database = AppDatabase.instance;
  List<TaskDB> taskList = [];
  // List<TaskDB> taskList = [
  //   Task(urn: 'URN', taskName: 'Task 1', assignedBy: 'User A', assignedTo: 'UserB', commencementDate: '01-01-2025', dueDate: '01-01-2025', clientName: 'Client X', status: 'Pending', taskType: 0),
  //   Task(urn: 'URN1', taskName: 'Task 1', assignedBy: 'User A', assignedTo: 'UserB', commencementDate: '01-01-2025', dueDate: '01-01-2025', clientName: 'Client X', status: 'Pending', taskType: 1),
  // ];

  bool isHome = true;

  @override
  void initState() {
    _loadTasks();
    super.initState();
  }

  Future<void> _loadTasks() async {
    List<TaskDB> tasks = await _database.getAllTasks();
    setState(() {
      taskList = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Dashboard Header with Sidebar Toggle
          Container(
            color: Colors.green.shade900,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: Icon( Icons.menu, color: Colors.white,),
                  onPressed: () {
                    setState(() {
                      isSidebarOpen = !isSidebarOpen;
                    });
                  },
                ),
                const Text('Dashboard', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: Icon(Icons.person,color: Colors.white,),
                  onSelected: (value) {
                    if (value == 'Home') {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
                    } else if (value == 'Settings') {
                      // Navigate to Settings Page (to be implemented)
                    } else if (value == 'SignOut') {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthPage()));
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return ['Home', 'Settings', 'SignOut'].map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // Sidebar
                Expanded(flex: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isSidebarOpen ? 200 : 0,
                    color: Colors.green.shade100,
                    child: Column(
                      children: [
                        if (isSidebarOpen) ...[
                          ListTile(
                            hoverColor: Colors.green.shade200,selectedColor: Colors.green.shade900,selectedTileColor: Colors.white,contentPadding: EdgeInsets.all(10),
                            title: Row(
                              children: [Expanded(flex: 2,child: Icon(Icons.schedule,color: Colors.green.shade900,)),SizedBox(width: 8,),
                                Expanded(flex: 8,child: Text('Scheduled Tasks',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.bold,fontSize: 15),)),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                // taskList = taskList.where((t) => t.taskType == 0).toList();
                              });
                            },
                          ),
                          ListTile(
                            title: Row(children: [
                              Expanded(flex: 2,child: Icon(Icons.check_box_outlined,color: Colors.green.shade900,)),SizedBox(width: 8,),
                              Expanded(flex: 8,child: Text('Completed Tasks',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.bold,fontSize: 15),))],),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                Expanded(flex: 2,child: Icon(Icons.delete_sweep_outlined,color: Colors.green.shade900,)),SizedBox(width: 8,),
                                Expanded(flex: 8,child: Text('With-held Tasks',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.bold,fontSize: 15),)),
                              ],
                            ),
                            onTap: () {},
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                // Main Dashboard
                Expanded(flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Spacer(),
                          SizedBox(height: 40,width: 180,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.green.shade900)),),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTaskPage()));
                              }, // Navigate to Add Task Page
                              child: const Text('Add Task',style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],),

                        const SizedBox(height: 10),
                        // Table-like UI
                        Expanded(flex: 9,
                          child:  ListView.builder(
                            itemCount: taskList.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.green.shade100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(flex: 1,child: Text('Task Id', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green.shade900))),
                                      Expanded(flex: 2,child: Text('Task Name', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green.shade900),textAlign: TextAlign.center,)),
                                      Expanded(flex: 2,child: Text('Assigned By', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green.shade900),textAlign: TextAlign.center,)),
                                      Expanded(flex: 2,child: Text('Assigned To', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green.shade900),textAlign: TextAlign.center,)),
                                      Expanded(flex: 2,child: Text('Commencement Date', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green.shade900,),textAlign: TextAlign.center,)),
                                      Expanded(flex: 2,child: Text('Due Date', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green.shade900),textAlign: TextAlign.center,)),
                                      Expanded(flex: 2,child: Text('Assigned To', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green.shade900),textAlign: TextAlign.center,)),
                                      Expanded(flex: 2,child: Text('Client Name', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green.shade900),textAlign: TextAlign.center,)),
                                      Expanded(flex: 2,child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green.shade900),textAlign: TextAlign.center,)),
                                    ],
                                  ),
                                );
                              }
                              TaskDB task = taskList[index - 1];
                              return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(flex: 1,child: Text(task.urn,)),
                                    Expanded(flex: 2,child: Text(task.name,textAlign: TextAlign.center,),),
                                    Expanded(flex: 2,child: Text(task.assignedBy,textAlign: TextAlign.center,)),
                                    Expanded(flex: 2,child: Text(task.assignedTo,textAlign: TextAlign.center,)),
                                    Expanded(flex: 2,child: Text(task.commencementDate,textAlign: TextAlign.center,)),
                                    Expanded(flex: 2,child: Text(task.dueDate,textAlign: TextAlign.center,)),
                                    Expanded(flex: 2,child: Text(task.clientName,textAlign: TextAlign.center,)),
                                    Expanded(flex: 2,child: Text(task.status,textAlign: TextAlign.center,)),
                                    Expanded(flex: 2,
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(flex:1,
                                            child: IconButton(
                                              icon: const Icon(Icons.play_arrow, color: Colors.black45),
                                              onPressed: () {
                                                Navigator.push(context,  MaterialPageRoute(builder: (context) => const TaskCommencementPage()));
                                              },
                                            ),
                                          ),
                                          Expanded(flex: 1,
                                            child: IconButton(
                                              icon: const Icon(Icons.edit, color: Colors.black45),
                                              onPressed: () {
                                                // Navigate to Edit Task Page
                                              },
                                            ),
                                          ),
                                          Expanded(flex: 1,
                                            child: IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.black45),
                                              onPressed: () {
                                                setState(() {
                                                  taskList.removeAt(index - 1);
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
