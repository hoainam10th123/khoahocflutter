import '../Models/user.dart';
import '../stream/myStream.dart';
import 'dart:math';

class Global{
  static MyStream? myStream;
  static User? user;//current user of app after login
  static String? channelName;
  static String? externalUserId;

  static void clearData(){
    user = null;
  }
}