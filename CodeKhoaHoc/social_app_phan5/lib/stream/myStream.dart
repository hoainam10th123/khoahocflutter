import 'dart:async';

class MyStream {
  //StreamController counterController = StreamController<bool>.broadcast();
  StreamController counterController = StreamController<bool>();
  Stream get counterStream => counterController.stream;

  StreamController scrollDownController = StreamController<bool>.broadcast();
  Stream get scrollDownStream => scrollDownController.stream;

  void signOut() {
    counterController.sink.add(true);
  }

  void scrollDown() {
    scrollDownController.sink.add(true);
  }
}