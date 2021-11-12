import 'dart:async';

import 'package:food/controller/category.dart';

import 'package:food/model/service.dart';

class CategoryStream {
  List<Category> list;
  StreamController<List<Category>> _controller =
      new StreamController.broadcast();

  Stream<List<Category>> get categoryStream => _controller.stream;
  Sink<List<Category>> get categorySink => _controller.sink;

  void getData() {
    Api.fetchCategory().then((data) async {
      categorySink.add(data);
    });
  }

  void dispose() {
    _controller.close();
  }
}
