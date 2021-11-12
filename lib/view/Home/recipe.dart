import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food/controller/food.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:food/controller/food_stream.dart';

class Recipe extends StatefulWidget {
  Recipe({Key key, this.food, this.source}) : super(key: key);
  Food food;
  String source;
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  FoodStream compStream;
  @override
  void initState() {
    compStream = new FoodStream();
    compStream.getComp(widget.source, widget.food.name);
    super.initState();
  }

  @override
  void dispose() {
    compStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.food != null
        ? Scaffold(
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: true,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        //borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(widget.food.img),
                            fit: BoxFit.cover)),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.all(3.0),
                    padding: EdgeInsets.all(5.0),
                    child: ListTile(
                      title: Text(widget.food.name,
                          style: Theme.of(context).textTheme.title),
                      subtitle: Text('${widget.food.des}',
                          style: Theme.of(context).textTheme.subtitle),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: 12.0),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                        'Thời gian : ${widget.food.time.toString()} Phút',
                        style: Theme.of(context).textTheme.title),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: 12.0),
                    padding: EdgeInsets.all(10.0),
                    child: Text('Level : ${widget.food.level}',
                        style: Theme.of(context).textTheme.title),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: 12.0),
                    padding: EdgeInsets.all(10.0),
                    child: Text('Nguyên Liệu :',
                        style: Theme.of(context).textTheme.body1),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    padding: EdgeInsets.all(10.0),
                    height: 80,
                    child: StreamBuilder(
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? buildComponents(snapshot.data)
                            : SpinKitCircle(color: Colors.red);
                      },
                      stream: compStream.componentStream,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return buildRecipe(context, index);
                  }, childCount: widget.food.cookSteps.length),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget buildComponents(List<Component> list) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text(
                  list[index].name,
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${list[index].quantity} ( ${list[index].unit} )",
                  style: Theme.of(context).textTheme.subtitle,
                )
              ],
            ),
          ),
        );
      },
      itemCount: list.length,
    );
  }

  Widget buildRecipe(BuildContext context, int index) {
    List<CookStep> _listCookSteps = widget.food.cookSteps;
    return Container(
      margin: EdgeInsets.all(20.0),
      child: _buildStep(_listCookSteps[index]),
    );
  }

  Widget _buildStep(CookStep cookStep) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: primaryColor,
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Text(cookStep.step.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0)),
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Text("Step", style: Theme.of(context).textTheme.title),
                subtitle: Text(cookStep.des,
                    style: Theme.of(context).textTheme.subtitle),
              ),
              Container(
                height: 200,
                child: buildImg(cookStep.pictures),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildImg(List<dynamic> listImg) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 2.0),
      child: Swiper(
        fade: 0.9,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(listImg[index]),
                    fit: BoxFit.cover)),
          );
        },
        itemCount: listImg.length,
        viewportFraction: 1,
        scale: 0.2,
        pagination: SwiperPagination(),
      ),
    );
  }
}
