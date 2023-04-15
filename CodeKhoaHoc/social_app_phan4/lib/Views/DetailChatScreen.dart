import 'package:flutter/material.dart';

class DetailChatScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DetailChatScreenState();
  }
}

class DetailChatScreenState extends State<DetailChatScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // event exit chat screen with people, back button on app bar

                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user.png'),
                    maxRadius: 25,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'member.displayName!',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text('10 phut ago',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.video_call,
                      color: Colors.blue,
                      size: 30,
                    ),
                    onTap: (){
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CuocGoiDiScreen(username: widget.userName,)),
                      );*/
                    },
                  ),
                ],
              ),
            ),
          )
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height  - 200,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index){
            final leftOrRight = index % 2 == 0;
            return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  mainAxisAlignment: leftOrRight ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    leftOrRight ? Text(''): CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user.png'),
                      radius: 15,
                    ),
                    const SizedBox(width: 5,),
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[200],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'vvvvvvvvvvvvvvvvvvvvvvvvvvvvv bbbbbbbbbbbbbbbbbbbbbbbbb',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                )
            );
          },
        ),
      ),
    );
  }
}