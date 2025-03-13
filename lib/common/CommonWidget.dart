

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonWidget{

  Widget sideBar(BuildContext context, bool isSidebarOpen){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSidebarOpen ? 200 : 0,
      color: Colors.green.shade700,
      child: Column(
        children: [
          if (isSidebarOpen) ...[
            ListTile(
              title: const Text('Scheduled Tasks',style: TextStyle(color: Colors.white),),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Completed Tasks',style: TextStyle(color: Colors.white),),
              onTap: () {},
            ),
            ListTile(
              title: const Text('With-held Tasks',style: TextStyle(color: Colors.white),),
              onTap: () {},
            ),
          ],
        ],
      ),
    );
  }
}