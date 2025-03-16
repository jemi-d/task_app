import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tf1/common/auth_service.dart';
import 'package:tf1/datamodel/Task.dart';
import 'package:tf1/ui/task_commencement.dart';
import 'package:tf1/viewModel/task_view_model.dart';
import '../common/common_ui.dart';
import '../local/database.dart';
import 'add_task_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isSidebarOpen = false;
  List<TaskDB> taskList = [];
  // task status 1= scheduled task, 2= completed task, 0= deleted task
  // task category 1= scheduled task, 2= completed task, 0= with_held task
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    debugPrint("comes here did change dependency");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context,listen: false);
    return Scaffold(
      body: Column(children: [
          TopBarUI(isSidebarOpen: isSidebarOpen,onValueChanged: (value){
            setState(() {
              isSidebarOpen = value;
            });
          }, isAddTask: false, heading: 'Dashboard',),
          Expanded(child: Row(children: [
            Expanded(flex: 0,
              child: AnimatedContainer(duration: const Duration(milliseconds: 300),
                width: isSidebarOpen ? 200 : 0,
                color: Colors.green.shade100,
                child: Column(children: [
                  if (isSidebarOpen) ...[
                    ListTile(
                      hoverColor: Colors.green.shade200,selectedColor: Colors.green.shade900,selectedTileColor: Colors.white,contentPadding: EdgeInsets.all(10),
                      title: Row(
                        children: [Expanded(flex: 2,child: Icon(Icons.schedule,color: Colors.green.shade900,)),SizedBox(width: 8,),
                          Expanded(flex: 8,child: Text('Scheduled Tasks',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.bold,fontSize: 15),)),
                        ],
                      ),
                      onTap: () async {
                        await  provider.handleTaskCategory(1);
                        },
                    ),
                    ListTile(title: Row(children: [
                      Expanded(flex: 2,child: Icon(Icons.check_box_outlined,color: Colors.green.shade900,)),SizedBox(width: 8,),
                      Expanded(flex: 8,child: Text('Completed Tasks',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.bold,fontSize: 15),))],),
                      onTap: () async {
                      await  provider.handleTaskCategory(2);
                      },
                    ),
                    ListTile(title: Row(children: [
                      Expanded(flex: 2,child: Icon(Icons.delete_sweep_outlined,color: Colors.green.shade900,)),SizedBox(width: 8,),
                      Expanded(flex: 8,child: Text('With-held Tasks',style: TextStyle(color: Colors.green.shade900,fontWeight: FontWeight.bold,fontSize: 15),)),],),
                      onTap: () async {
                      await  provider.handleTaskCategory(0);
                      },
                    ),
                  ],],
                ),),
            ),
            Expanded(flex: 9,
              child: Padding(padding: const EdgeInsets.all(16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Row(children: [ Spacer(),
                    SizedBox(height: 40,width: 180,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade900,shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.green.shade900)),),
                              onPressed: () async{
                                UserDetail? data = await AuthService.getUserData();
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddTaskPage(userDetail: data!,)));
                              }, // Navigate to Add Task Page
                              child: const Text('Add Task',style: TextStyle(color: Colors.white)),
                            ),
                          ),
                  ],),
                    const SizedBox(height: 10),
                    Expanded(flex: 9,
                      child: Consumer<TaskProvider>(
                        builder: (context, dataTask, child) {
                          if (dataTask.isLoading) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return Column(children: [
                              Container(padding: const EdgeInsets.all(10),
                                color: Colors.green.shade100,
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(flex: 1, child: Text('Task Id', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900))),
                                    Expanded(flex: 2, child: Text('Task Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900), textAlign: TextAlign.center)),
                                    Expanded(flex: 2, child: Text('Assigned By', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900), textAlign: TextAlign.center)),
                                    Expanded(flex: 2, child: Text('Assigned To', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900), textAlign: TextAlign.center)),
                                    Expanded(flex: 2, child: Text('Commencement Date', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900), textAlign: TextAlign.center)),
                                    Expanded(flex: 2, child: Text('Due Date', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900), textAlign: TextAlign.center)),
                                    Expanded(flex: 2, child: Text('Client Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900), textAlign: TextAlign.center)),
                                    Expanded(flex: 2, child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900), textAlign: TextAlign.center)),
                                  ],),
                              ),
                              if (dataTask.tasks.isEmpty)
                                Expanded(child: Center(
                                    child: Text('No tasks available',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),),
                                )
                              else
                                Expanded(
                                  child: ListView.builder(itemCount: dataTask.tasks.length, itemBuilder: (context, index) {
                                      TaskDB task = dataTask.tasks[index];
                                      return Container(padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.black)),),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(flex: 1, child: Text(task.urn)),
                                            Expanded(flex: 2, child: Text(task.name, textAlign: TextAlign.center)),
                                            Expanded(flex: 2, child: Text(task.assignedBy, textAlign: TextAlign.center)),
                                            Expanded(flex: 2, child: Text(task.assignedTo, textAlign: TextAlign.center)),
                                            Expanded(flex: 2, child: Text(task.commencementDate.substring(0, 10), textAlign: TextAlign.center)),
                                            Expanded(flex: 2, child: Text(task.dueDate.substring(0, 10), textAlign: TextAlign.center)),
                                            Expanded(flex: 2, child: GestureDetector(onTap: () {_showDialog(task); },
                                              child: Text(task.clientName, textAlign: TextAlign.center),
                                            )),
                                            Expanded(flex: 2, child: task.status == '0' ? Text('-') : Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [if (task.status == '1')
                                                    Expanded(flex: 1, child: IconButton(icon: const Icon(Icons.play_arrow, color: Colors.black45),
                                                        onPressed: () {
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => TaskCommencementPage(taskDB: task)));
                                                        },),
                                                    ),
                                                  if (task.status == '1')
                                                    Expanded(flex: 1, child: IconButton(icon: const Icon(Icons.edit, color: Colors.black45),
                                                      onPressed: () async{
                                                        UserDetail? data = await AuthService.getUserData();
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskPage(taskDB: task,userDetail: data!,)));
                                                        },),
                                                    ),
                                                  Expanded(flex: 1, child: IconButton(icon: const Icon(Icons.delete, color: Colors.black45),
                                                      onPressed: () async {
                                                        await dataTask.updateStatus(task.id, '0'); // Soft delete
                                                      },),
                                                  ),],
                                              ),),],
                                        ),);
                                    },),),
                            ],);
                        },),
                    )],
                ),),),
          ],),),
      ],),
    );
  }

  void _showDialog(TaskDB task) {
    showDialog(context: context,
      builder: (context) {
        return AlertDialog(titlePadding: EdgeInsets.fromLTRB(20, 5, 0, 0),contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 15),
          title: Row(children: [
            Text("Client Details",style: TextStyle(color: Colors.green.shade900),),Spacer(),IconButton(color: Colors.green.shade900, onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.close_sharp),)],),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(children: [Text('Client Name :'), SizedBox(width: 5,),Text(task.clientName)],),
            Row(children: [Text('Client Designation :'),SizedBox(width: 5,), Text(task.clientDesignation)],),
            Row(children: [Text('Client Email :'), SizedBox(width: 5,),Text(task.clientEmail)],),
          ],),
        );
      },
    );
  }
}
