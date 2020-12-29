import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/https/ApiServices.dart';
import 'package:flutter_provider/model/Flower.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<Flower>>(
        create: (context) => getFlowers(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Flowers"),
            centerTitle: true,
            elevation: 0,
          ),
          body: Container(
            child: Consumer<List<Flower>>(
              builder: (context, flowerlist, child) {
                return (flowerlist != null && flowerlist.length > 0)
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: flowerlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          var photo =
                              "http://services.hanselandpetal.com/photos/${flowerlist[index].photo}";
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Container(
                                margin: EdgeInsets.only(
                                    bottom: 10, top: 10, right: 5),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)),
                                      child: CachedNetworkImage(
                                        imageUrl: photo,
                                        width: 110,
                                        height: 90,
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Text(
                                          "${flowerlist[index].name}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ))
                                  ],
                                )),
                          );
                        })
                    : Container(
                        child: Text("Loading"),
                      );
              },
            ),
          ),
        ));
  }

  Future<List<Flower>> getFlowers() async {
    // var flowerlist = await ApiServices().getFlowers();
    return await ApiServices().getFlowers();
  }
}
