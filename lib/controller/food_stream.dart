import 'dart:async';
import 'package:food/controller/food.dart';
import 'package:food/model/service.dart';

class FoodStream {
  List<Food> list;
  StreamController<List<Food>> _controller = new StreamController();
  StreamController<List<Component>> _controller2 = new StreamController();
  StreamController<List<dynamic>> _controller3 = new StreamController();
  Stream<List<Food>> get foodStream => _controller.stream;
  Sink<List<Food>> get foodSink => _controller.sink;
  Stream<List<Component>> get componentStream => _controller2.stream;
  Sink<List<Component>> get componentSink => _controller2.sink;
  Stream<List<dynamic>> get nameStream => _controller3.stream;
  Sink<List<dynamic>> get nameSink => _controller3.sink;
  void getData(String source) {
    Api.fetchFood(source).then((data) async {
      foodSink.add(data);
    });
  }

  void getComp(String source, String name) {
    Api.fetchComponent(source, name).then((data) async {
      componentSink.add(data);
    });
  }

  void getName(String source) {
    Api.fetchName(source).then((name) async {
      nameSink.add(name);
    });
  }

  void dispose() {
    _controller.close();
    _controller2.close();
    _controller3.close();
  }
}
