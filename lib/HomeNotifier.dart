import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/https/ApiUrl.dart';
import 'package:flutter_provider/provider/BaseProvider.dart';
import 'package:flutter_provider/provider/FlowerDataProvider.dart';
import 'package:provider/provider.dart';

class HomeNotifier extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeNotifier> {
  @override
  void initState() {
    super.initState();
    Provider.of<FlowerDataProvider>(context, listen: false)
        .getFlowerList();
  }

  @override
  Widget build(BuildContext context) {
    final datas = Provider.of<FlowerDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flowers"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: mainView(datas),
      ),
    );
  }

  Widget mainView(FlowerDataProvider datas) {
    if (datas.state == UISTATE.LOADING)
      return Center(
        child: CircularProgressIndicator(),
      );
    else if (datas.state == UISTATE.SUCCESS) {
      return flowerListWidget(datas);
    } else {
      return Center(
        child: Text(datas.uiErrorMessage),
      );
    }
  }

  ListView flowerListWidget(FlowerDataProvider datas) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: datas.flowerList.length,
        itemBuilder: (BuildContext context, int index) {
          var photo =
              "${ApiUrl.baseUrl}${ApiUrl.photos}/${datas.flowerList[index].photo}";
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Container(
                margin: EdgeInsets.only(bottom: 10, top: 10, right: 5),
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
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "${datas.flowerList[index].name}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ))
                  ],
                )),
          );
        });
  }
}
