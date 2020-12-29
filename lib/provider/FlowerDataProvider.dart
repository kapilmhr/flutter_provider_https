import 'package:either_option/either_option.dart';
import 'package:flutter_provider/https/ApiServices.dart';
import 'package:flutter_provider/https/ApiUrl.dart';
import 'package:flutter_provider/model/Flower.dart';
import 'package:flutter_provider/provider/BaseProvider.dart';

class FlowerDataProvider extends BaseProvider {
  List<Flower> flowerList = List<Flower>();

  getAllFlowers() async {
    flowerList = await ApiServices().getFlowers();
    setUiStateAndNotify(UISTATE.SUCCESS);
  }

  getFlowerList() async {
    final Either<String, List<Flower>> result =
        await ApiServices().getFlowerList();

    result.fold((e) {
      setErrorMessage(e);
      setUiStateAndNotify(UISTATE.ERROR);
    }, (f) {
      flowerList = f;
      setUiStateAndNotify(UISTATE.SUCCESS);
    });
  }
}
