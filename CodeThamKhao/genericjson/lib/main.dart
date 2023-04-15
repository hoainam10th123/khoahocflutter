import 'package:flutter/material.dart';
import 'package:genericjson/pagination/Paginate.dart';
import 'package:genericjson/pagination/comment.dart';
import 'package:genericjson/pagination/post.dart';
import 'dart:convert';

//https://stackoverflow.com/questions/55306746/how-to-use-generics-and-list-of-generics-with-json-serialization-in-dart

//final jsonStringCustom = '''{"page":1,"total_results":10,"total_pages":200,"results":[{"name":"Something","size":80},{"name":"Something 2","size":200}]}''';


final jsonStringPaginationComment =
'''{
    "totalPages": 3,
    "pageNumber": 1,
    "pageSize": 5,
    "count": 11,
    "data": [
        {
            "id": 1,
            "noiDung": "123",
            "created": "2022-09-27T19:40:44.3851726",
            "userId": "802115b3-cb6e-449b-b277-780ee3458935",
            "displayName": "Nguyễn Hoài Nam",
            "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
            "postId": 23
        },
        {
            "id": 2,
            "noiDung": "namnguyen test",
            "created": "2022-09-27T19:45:31.3661456",
            "userId": "802115b3-cb6e-449b-b277-780ee3458935",
            "displayName": "Nguyễn Hoài Nam",
            "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
            "postId": 23
        },
        {
            "id": 3,
            "noiDung": "abc dfefffff",
            "created": "2022-09-27T19:45:44.6620744",
            "userId": "802115b3-cb6e-449b-b277-780ee3458935",
            "displayName": "Nguyễn Hoài Nam",
            "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
            "postId": 23
        }
    ]
}''';

final jsonStringPaginationPost =
'''{
    "totalPages": 4,
    "pageNumber": 1,
    "pageSize": 5,
    "count": 20,
    "data": [
        {
            "id": 23,
            "noiDung": "01 Chung ta khong thuoc ve nhau.Chung ta khong la cua nhau. Nu cuoi da mat, giot nuoc mat",
            "created": "2022-09-05T19:23:51.0188815",
            "comments": [
                {
                    "id": 1,
                    "noiDung": "123",
                    "created": "2022-09-27T19:40:44.3851726",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 23
                },
                {
                    "id": 2,
                    "noiDung": "namnguyen test",
                    "created": "2022-09-27T19:45:31.3661456",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 23
                },
                {
                    "id": 3,
                    "noiDung": "abc dfefffff",
                    "created": "2022-09-27T19:45:44.6620744",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 23
                },
                {
                    "id": 10,
                    "noiDung": "hello ubuntu day",
                    "created": "2022-09-28T17:43:56.8020263",
                    "userId": "a2f124c4-de3d-4de3-b8da-c222538b46ef",
                    "displayName": "Ubuntu Nguyễn",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 23
                },
                {
                    "id": 15,
                    "noiDung": "ccccc",
                    "created": "2022-09-28T17:49:45.4485056",
                    "userId": "2c80f640-c58b-4447-aa69-cc5ced1cf365",
                    "displayName": "Nguyen Dat Phat",
                    "userImageUrl": null,
                    "postId": 23
                },
                {
                    "id": 21,
                    "noiDung": "vvvvv",
                    "created": "2022-09-28T18:14:59.1797341",
                    "userId": "6c1d283f-7ff2-49fa-a123-f75f15499838",
                    "displayName": "Phat Huong",
                    "userImageUrl": null,
                    "postId": 23
                },
                {
                    "id": 22,
                    "noiDung": "ddfddffdfdfd",
                    "created": "2022-09-28T18:16:27.290856",
                    "userId": "a2f124c4-de3d-4de3-b8da-c222538b46ef",
                    "displayName": "Ubuntu Nguyễn",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 23
                },
                {
                    "id": 64,
                    "noiDung": "😅😅😅😅",
                    "created": "2022-09-29T14:04:49.1174015",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 23
                },
                {
                    "id": 65,
                    "noiDung": "🤣🤣🤣🤣",
                    "created": "2022-09-29T14:04:52.4557012",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 23
                },
                {
                    "id": 66,
                    "noiDung": "😍",
                    "created": "2022-09-29T14:04:54.4893285",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 23
                },
                {
                    "id": 67,
                    "noiDung": "❤️❤️❤️",
                    "created": "2022-09-29T14:04:56.8232512",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 23
                }
            ],
            "userName": "hoainam10th",
            "displayName": "Nguyễn Hoài Nam",
            "imageUrl": "http://10.0.2.2:5291/images/post2.jpg"
        },
        {
            "id": 24,
            "noiDung": "02 Chung ta khong thuoc ve nhau.Chung ta khong la cua nhau. Nu cuoi da mat, giot nuoc mat",
            "created": "2022-09-05T19:23:51.21188",
            "comments": [
                {
                    "id": 5,
                    "noiDung": "hello nam nguyen",
                    "created": "2022-09-28T17:36:22.0752117",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                },
                {
                    "id": 6,
                    "noiDung": "212122",
                    "created": "2022-09-28T17:37:32.2532048",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                },
                {
                    "id": 7,
                    "noiDung": "hi nam",
                    "created": "2022-09-28T17:43:18.1879067",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                },
                {
                    "id": 11,
                    "noiDung": "fdffdf",
                    "created": "2022-09-28T17:44:34.8233429",
                    "userId": "a2f124c4-de3d-4de3-b8da-c222538b46ef",
                    "displayName": "Ubuntu Nguyễn",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                },
                {
                    "id": 13,
                    "noiDung": "datne nam",
                    "created": "2022-09-28T17:45:30.5871332",
                    "userId": "2c80f640-c58b-4447-aa69-cc5ced1cf365",
                    "displayName": "Nguyen Dat Phat",
                    "userImageUrl": null,
                    "postId": 24
                },
                {
                    "id": 14,
                    "noiDung": "111111",
                    "created": "2022-09-28T17:45:51.4614082",
                    "userId": "2c80f640-c58b-4447-aa69-cc5ced1cf365",
                    "displayName": "Nguyen Dat Phat",
                    "userImageUrl": null,
                    "postId": 24
                },
                {
                    "id": 16,
                    "noiDung": "dat binh luan",
                    "created": "2022-09-28T18:11:55.9121518",
                    "userId": "2c80f640-c58b-4447-aa69-cc5ced1cf365",
                    "displayName": "Nguyen Dat Phat",
                    "userImageUrl": null,
                    "postId": 24
                },
                {
                    "id": 18,
                    "noiDung": "ubuntu binh luan",
                    "created": "2022-09-28T18:12:35.753521",
                    "userId": "a2f124c4-de3d-4de3-b8da-c222538b46ef",
                    "displayName": "Ubuntu Nguyễn",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                },
                {
                    "id": 32,
                    "noiDung": "ccccccccccccccccccccc",
                    "created": "2022-09-28T18:30:53.1886104",
                    "userId": "2c80f640-c58b-4447-aa69-cc5ced1cf365",
                    "displayName": "Nguyen Dat Phat",
                    "userImageUrl": null,
                    "postId": 24
                },
                {
                    "id": 33,
                    "noiDung": "xxxxxxxxxxxxx",
                    "created": "2022-09-28T18:32:36.3524725",
                    "userId": "2c80f640-c58b-4447-aa69-cc5ced1cf365",
                    "displayName": "Nguyen Dat Phat",
                    "userImageUrl": null,
                    "postId": 24
                },
                {
                    "id": 59,
                    "noiDung": "😆😆😆😆😆😆",
                    "created": "2022-09-29T13:39:27.9585329",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                },
                {
                    "id": 60,
                    "noiDung": "😘😘😘😘😘😘😍😍😍😍😍😍",
                    "created": "2022-09-29T13:39:44.320597",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                },
                {
                    "id": 61,
                    "noiDung": "😅😅😅😅😅😅😅😅😅",
                    "created": "2022-09-29T13:39:53.5764177",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                },
                {
                    "id": 62,
                    "noiDung": "😊😊😊😊😊😊",
                    "created": "2022-09-29T13:40:02.2806925",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                },
                {
                    "id": 63,
                    "noiDung": "🤣🤣🤣🤣🤣🤣🤣",
                    "created": "2022-09-29T13:40:08.7386824",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 24
                }
            ],
            "userName": "hoaray",
            "displayName": "Nguyen Thi Hoa Ray",
            "imageUrl": "http://10.0.2.2:5291/images/post2.jpg"
        },
        {
            "id": 25,
            "noiDung": "03 Chung ta khong thuoc ve nhau.Chung ta khong la cua nhau. Nu cuoi da mat, giot nuoc mat",
            "created": "2022-09-05T19:23:51.2154023",
            "comments": [
                {
                    "id": 4,
                    "noiDung": "hello cha cha cha",
                    "created": "2022-09-28T17:17:14.4037841",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 25
                },
                {
                    "id": 8,
                    "noiDung": "nam nguyen",
                    "created": "2022-09-28T17:43:25.0348138",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 25
                },
                {
                    "id": 12,
                    "noiDung": "chahchcaaaa",
                    "created": "2022-09-28T17:44:49.0424677",
                    "userId": "a2f124c4-de3d-4de3-b8da-c222538b46ef",
                    "displayName": "Ubuntu Nguyễn",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 25
                },
                {
                    "id": 23,
                    "noiDung": "12221212122112",
                    "created": "2022-09-28T18:20:46.4603166",
                    "userId": "6c1d283f-7ff2-49fa-a123-f75f15499838",
                    "displayName": "Phat Huong",
                    "userImageUrl": null,
                    "postId": 25
                },
                {
                    "id": 24,
                    "noiDung": "212112212",
                    "created": "2022-09-28T18:21:25.749018",
                    "userId": "6c1d283f-7ff2-49fa-a123-f75f15499838",
                    "displayName": "Phat Huong",
                    "userImageUrl": null,
                    "postId": 25
                },
                {
                    "id": 25,
                    "noiDung": "vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv",
                    "created": "2022-09-28T18:21:34.9719188",
                    "userId": "6c1d283f-7ff2-49fa-a123-f75f15499838",
                    "displayName": "Phat Huong",
                    "userImageUrl": null,
                    "postId": 25
                }
            ],
            "userName": "hoaray",
            "displayName": "Nguyen Thi Hoa Ray",
            "imageUrl": "http://10.0.2.2:5291/images/post2.jpg"
        },
        {
            "id": 26,
            "noiDung": "04 Chung ta khong thuoc ve nhau.Chung ta khong la cua nhau. Nu cuoi da mat, giot nuoc mat",
            "created": "2022-09-05T19:23:51.2173883",
            "comments": [
                {
                    "id": 9,
                    "noiDung": "giot nuoc mat tran ly",
                    "created": "2022-09-28T17:43:33.6980785",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 26
                },
                {
                    "id": 17,
                    "noiDung": "dat binh luan say hello",
                    "created": "2022-09-28T18:12:08.0819067",
                    "userId": "2c80f640-c58b-4447-aa69-cc5ced1cf365",
                    "displayName": "Nguyen Dat Phat",
                    "userImageUrl": null,
                    "postId": 26
                },
                {
                    "id": 20,
                    "noiDung": "ubuntu binh luan",
                    "created": "2022-09-28T18:14:25.2607539",
                    "userId": "a2f124c4-de3d-4de3-b8da-c222538b46ef",
                    "displayName": "Ubuntu Nguyễn",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 26
                },
                {
                    "id": 26,
                    "noiDung": "vvvvvvvvvvvvvvv",
                    "created": "2022-09-28T18:23:05.6352857",
                    "userId": "2c80f640-c58b-4447-aa69-cc5ced1cf365",
                    "displayName": "Nguyen Dat Phat",
                    "userImageUrl": null,
                    "postId": 26
                },
                {
                    "id": 27,
                    "noiDung": "21212112",
                    "created": "2022-09-28T18:24:47.9872275",
                    "userId": "a2f124c4-de3d-4de3-b8da-c222538b46ef",
                    "displayName": "Ubuntu Nguyễn",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 26
                }
            ],
            "userName": "hoaray",
            "displayName": "Nguyen Thi Hoa Ray",
            "imageUrl": "http://10.0.2.2:5291/images/post2.jpg"
        },
        {
            "id": 27,
            "noiDung": "05 Chung ta khong thuoc ve nhau.Chung ta khong la cua nhau. Nu cuoi da mat, giot nuoc mat",
            "created": "2022-09-05T19:23:51.2192231",
            "comments": [
                {
                    "id": 35,
                    "noiDung": "123",
                    "created": "2022-09-28T18:35:56.4309476",
                    "userId": "a2f124c4-de3d-4de3-b8da-c222538b46ef",
                    "displayName": "Ubuntu Nguyễn",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 27
                },
                {
                    "id": 36,
                    "noiDung": "datnguyen post 5",
                    "created": "2022-09-28T18:41:59.5868049",
                    "userId": "2c80f640-c58b-4447-aa69-cc5ced1cf365",
                    "displayName": "Nguyen Dat Phat",
                    "userImageUrl": null,
                    "postId": 27
                },
                {
                    "id": 37,
                    "noiDung": "212122121212",
                    "created": "2022-09-28T18:44:29.7810031",
                    "userId": "a2f124c4-de3d-4de3-b8da-c222538b46ef",
                    "displayName": "Ubuntu Nguyễn",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 27
                },
                {
                    "id": 38,
                    "noiDung": "hello. hi",
                    "created": "2022-09-29T07:26:17.2829427",
                    "userId": "802115b3-cb6e-449b-b277-780ee3458935",
                    "displayName": "Nguyễn Hoài Nam",
                    "userImageUrl": "http://10.0.2.2:5291/images/post2.jpg",
                    "postId": 27
                }
            ],
            "userName": "hoaray",
            "displayName": "Nguyen Thi Hoa Ray",
            "imageUrl": "http://10.0.2.2:5291/images/post2.jpg"
        }
    ]
}''';

void main() {
  //final data = Paginate<Comment>.fromJson(jsonDecode(jsonStringPaginationComment), Comment.fromJsonModel);
  final data = Paginate<Post>.fromJson(jsonDecode(jsonStringPaginationPost), Post.fromJsonModel);
  print(data.totalPages);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
