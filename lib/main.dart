import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food/controller/category_stream.dart';
import 'package:food/view/Home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.redAccent[400],
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
              color: Colors.white),
          body1: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent[400],
            fontFamily: 'Georgia',
          ),
          body2: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Georgia',
          ),
          title: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Georgia',
          ),
          subtitle: TextStyle(
              fontSize: 12.0,
              fontFamily: 'Georgia',
              fontStyle: FontStyle.italic),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CategoryStream categoryStream;
  @override
  void initState() {
    categoryStream = new CategoryStream();
    categoryStream.getData();
    super.initState();
  }

  @override
  void dispose() {
    categoryStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Home(
                  listCategory: snapshot.data,
                )
              : SpinKitCircle(color: Colors.red);
        },
        stream: categoryStream.categoryStream,
      ),
    );
  }
}
