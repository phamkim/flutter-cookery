import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food/controller/food.dart';
import 'package:food/controller/food_stream.dart';
import 'package:food/model/service.dart';
import 'package:food/view/Home/recipe.dart';

class Search extends StatefulWidget {
  Search({Key key, this.source}) : super(key: key);
  String source;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchPage();
  }
}

class SearchPage extends State<Search> {
  FoodStream foodStream;
  @override
  void initState() {
    foodStream = new FoodStream();
    foodStream.getName(widget.source);
    super.initState();
  }

  @override
  void dispose() {
    foodStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seacrh"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Result(
                  listName: snapshot.data,
                  source: widget.source,
                )
              : SpinKitCircle(color: Colors.red);
        },
        stream: foodStream.nameStream,
      ),
    );
  }
}

class Result extends StatefulWidget {
  Result({Key key, this.listName, this.source}) : super(key: key);
  List<dynamic> listName;
  String source;
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";
  List<String> _filterList;

  @override
  void initState() {
    super.initState();
    widget.listName.sort();
  }

  _ResultState() {
    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

//Build our Home widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: new Column(
          children: <Widget>[
            _createSearchView(),
            _firstSearch ? _createListView() : _performSearch()
          ],
        ),
      ),
    );
  }

  //Create a SearchView
  Widget _createSearchView() {
    return new Container(
      decoration:
          BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
      child: new TextField(
        controller: _searchview,
        decoration: InputDecoration(
          hintText: "Tìm món ăn bạn yêu thích",
          border: InputBorder.none,
          hintStyle: new TextStyle(color: Colors.red[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  //Create a ListView widget
  Widget _createListView() {
    return Container();
  }

  //Perform actual search
  Widget _performSearch() {
    _filterList = new List<String>();
    for (int i = 0; i < widget.listName.length; i++) {
      var item = widget.listName[i];
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList.add(item);
      }
    }
    return _createFilteredListView();
  }

  //Create the Filtered ListView
  Widget _createFilteredListView() {
    return new Flexible(
      child: new ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _filterList.length,
          itemBuilder: (BuildContext context, int index) {
            return new ListTile(
              title: Text(_filterList[index]),
              leading: Icon(Icons.search),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>Mid(name:_filterList[index] ,source: widget.source,),
                  ),
                );
              },
            );
          }),
    );
  }
}

class Mid extends StatefulWidget {
  Mid({Key key, this.name, this.source}) : super(key: key);
  String name;
  String source;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MidState();
  }
}
class MidState extends State<Mid> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: FutureBuilder(builder: (context,snapshot){
      return snapshot.hasData ? Recipe(source: widget.source,food: snapshot.data[0],) :SpinKitCircle(color: Colors.red);
    },future: Api.getFood(widget.source,widget.name)),
  );
}
