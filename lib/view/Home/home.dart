import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:food/controller/category.dart';
import 'package:food/view/Home/detail.dart';

class Home extends StatefulWidget {
  List<Category> listCategory;
  Home({Key key, this.listCategory}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePage();
  }
}

class HomePage extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://freedesignfile.com/upload/2016/12/Food-spices-on-black-table-top-HD-picture-04.jpg'),
                        fit: BoxFit.cover)),
              ),
              title:
                  Text('Cookery', style: Theme.of(context).textTheme.headline),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return buildItem(context, index);
            }, childCount: widget.listCategory.length),
          ),
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    var _listCategory = widget.listCategory;
    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      height: 200,
      padding: EdgeInsets.only(top: 5.0),
      child: InkWell(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(_listCategory[index].title,
                  style: Theme.of(context).textTheme.body1),
              trailing: IconButton(
                  icon: Icon(
                    Icons.trending_flat,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(
                                  source: _listCategory[index].source,
                                  title: _listCategory[index].title,
                                )));
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Container(
                child: buildImg(widget.listCategory[index].img),
              ),
            )
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Detail(
                        source: _listCategory[index].source,
                        title: _listCategory[index].title,
                      )));
        },
      ),
    );
  }

  Widget buildImg(List<dynamic> listImg) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
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
        viewportFraction: 0.5,
        scale: 0.5,
        pagination: SwiperPagination(),
      ),
    );
  }
}
