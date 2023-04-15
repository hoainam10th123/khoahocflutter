import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/global.dart';

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
              onPressed: ()async{
                final SharedPreferences prefs = await _prefs;
                // Remove data
                final success = await prefs.remove('user');
                //render login page
                Global.myStream!.signOut();
                Global.clearData();
              },
              icon: const Icon(Icons.logout)
          )
        ],
      ),
    );
  }
}