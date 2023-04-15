import 'package:flutter/material.dart';
import 'package:social_app/Views/widgets/postItem.dart';

class FeedScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: PostItem(),
    );
  }
}