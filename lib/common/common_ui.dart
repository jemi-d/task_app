import 'package:flutter/material.dart';
import 'package:tf1/common/auth_service.dart';
import 'package:tf1/datamodel/Task.dart';
import '../ui/auth_page.dart';
import '../ui/dashboard_page.dart';

// ignore: must_be_immutable
class TopBarUI extends StatefulWidget {
  bool isSidebarOpen;
  final Function(bool) onValueChanged;
  final bool isAddTask;
  final String heading;
  TopBarUI({super.key, required this.isSidebarOpen, required this.onValueChanged, required this.isAddTask, required this.heading});

  @override
  State<TopBarUI> createState() => _TopBarUIState();
}

class _TopBarUIState extends State<TopBarUI> {
  bool isChildSidebar = false;
  String name='';
  String email='';

  @override
  void initState() {
    isChildSidebar = widget.isSidebarOpen;

    super.initState();
  }

  void updateValue(){
    setState(() {
      isChildSidebar = widget.isSidebarOpen ? false : true;
    });
    widget.onValueChanged(isChildSidebar);
  }

  Future<void> checkUserEmail() async {
    UserDetail? a = await AuthService.getUserData();
    if (a != null) {
      name = a.name;
      email = a.email;
    } else {
      debugPrint('No email found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.green.shade900,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          widget.isAddTask ? SizedBox(width: 10,) : IconButton(
            icon: Icon( Icons.menu, color: Colors.white,),
            onPressed: () {
              updateValue();
            },
          ),
          Text(widget.heading, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          PopupMenuButton<String>(
            icon: Icon(Icons.person,color: Colors.white,),
            onSelected: (value) async {
              if (value == 'Home') {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
              } else if (value == 'Settings') {
                await checkUserEmail();
                _showDialog();
              } else if (value == 'SignOut') {

                await AuthService.logout();
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
    );
  }

  void _showDialog() {
    showDialog(context: context,
      builder: (context) {
        return AlertDialog(titlePadding: EdgeInsets.fromLTRB(20, 5, 0, 0),contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 15),
          title: Row(children: [
            Text("User profile",style: TextStyle(color: Colors.green.shade900),),Spacer(),IconButton(color: Colors.green.shade900, onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.close_sharp),)],),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(children: [Text('Current username :'), SizedBox(width: 5,),Text(name)],),
            Row(children: [Text('Current Email :'), SizedBox(width: 5,),Text(email)],),
          ],),
        );
      },
    );
  }
}
