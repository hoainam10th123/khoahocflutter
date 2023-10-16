import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/member.dart';
import '../Utils/const.dart';
import '../Utils/global.dart';
import '../services/oneSignalService.dart';
import 'CuocGoiDenScreen.dart';
import 'controllers/presenceHub.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget{
  const BottomNavBar({super.key});

  @override
  State<StatefulWidget> createState() {
    return BottomNavBarState();
  }
}

class BottomNavBarState extends State<BottomNavBar>{
  final presenceHubController = Get.put(PresenceHubController());
  int pageIndex = 0;
  var uuid = const Uuid();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    //OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    //OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    //OneSignal.consentRequired(false);

    OneSignal.initialize("17f10dd1-d62a-43d9-bf73-6405535a8757");
    //OneSignal.User.pushSubscription.optIn();
    OneSignal.Notifications.requestPermission(true);
    // AndroidOnly stat only
    OneSignal.Notifications.removeNotification(1);
    //OneSignal.Notifications.removeGroupedNotifications("group5");
    OneSignal.Notifications.clearAll();
    OneSignal.User.pushSubscription.addObserver((state) {
      print(OneSignal.User.pushSubscription.optedIn);
      print(OneSignal.User.pushSubscription.id);
      print(OneSignal.User.pushSubscription.token);
      //print(state.current.jsonRepresentation());
      OneSignalService().postPlayerId(OneSignal.User.pushSubscription.id)
          .then((value) => print('Them ids thanh cong'));
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission $state");
    });

    OneSignal.Notifications.addClickListener((event) {
      print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      print(
          'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}');

      /// Display Notification, preventDefault to not display
      //event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();
    });

    final tUserId = _prefs.then((SharedPreferences prefs) {
      final externalUserId = prefs.getString('externalUserId');
      // neu da co user id
      if(externalUserId != null){
        Global.externalUserId = externalUserId;
      }
      return externalUserId;
    });

    final userId = await tUserId;
    if(userId != null){
      await OneSignal.login(userId);
    }else{
      //neu chua co user id
      final externalId = uuid.v4();
      await saveExternalUserId(externalId);
      // ham nay se call api OneSignal.User.pushSubscription.addObserver((state)
      await OneSignal.login(externalId);
    }
  }

  //save local storages
  Future<void> saveExternalUserId (String id) async {
    final SharedPreferences prefs = await _prefs;
    final counter = prefs.setString('externalUserId', id).then((bool success) {
      return success;
    });
  }

  @override
  void initState() {
    presenceHubController.createHubConnection(Global.user);
    // call from presenceHub
    /*Global.myStream!.navigateScreenStream.listen((event) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CuocGoiDenScreen(member: event as Member,)),
      );
    });*/
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index){
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat, size: 35,), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.group, size: 35,), label: 'Group'),
          BottomNavigationBarItem(icon: Icon(Icons.rss_feed, size: 35,), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.account_box, size: 35,), label: 'Profile'),
        ],),
    );
  }
}