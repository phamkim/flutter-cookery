import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food/controller/food.dart';
import 'package:food/controller/food_stream.dart';
import 'package:food/view/Home/recipe.dart';
import 'package:food/view/Home/search.dart';

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  Detail({Key key, this.source, this.title}) : super(key: key);
  String source;
  String title;
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  FoodStream foodStream;
  @override
  void initState() {
    foodStream = new FoodStream();
    foodStream.getData(widget.source);
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
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.body2,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Search(
                    source: widget.source,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          return snapshot.hasData
              ? buildFood(snapshot.data)
              : SpinKitCircle(color: Colors.red);
        },
        stream: foodStream.foodStream,
      ),
    );
  }

  Widget buildFood(List<Food> listFood) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ExpandableNotifier(
            child: Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Recipe(
                        source: widget.source,
                        food: listFood[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  margin: EdgeInsets.only(left: 20,right: 20,top: 30.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      image: DecorationImage(
                          image:
                              CachedNetworkImageProvider(listFood[index].img),
                          fit: BoxFit.cover)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          listFood[index].title,
                          style: Theme.of(context).textTheme.title,
                        )),
                    collapsed: Text(
                      listFood[index].des,
                      softWrap: true,
                      style: Theme.of(context).textTheme.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          listFood[index].des,
                          style: Theme.of(context).textTheme.subtitle,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                    iconColor: Colors.red,
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                  ),
                ),
              )
            ],
          ),
        ));
      },
      itemCount: listFood.length,
    );
  }
}
