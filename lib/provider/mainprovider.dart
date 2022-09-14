import 'dart:convert';
import 'package:center_source_task_flutter/model/searchimagesmodel.dart';
import 'package:center_source_task_flutter/services/allimageservices.dart';
import 'package:center_source_task_flutter/utils/helpers.dart';
import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  String? searchImagesResponse;
  SearchImagesModel? searchImagesModel;
  List<Hits>? showSearchImagesModel=[];

  String searchItems = "";

  bool paginationLoader = false;
  int currentMaxImage = 0;
  ScrollController scrollController = ScrollController();

  @override
  void pageInit() {
    // scrollController.addListener(pagination);
    paginationLoader = false;
    searchImagesModel = null;

    notifyListeners();
  }

  void updatePaginationLoader(bool val) {
    paginationLoader = val;
    notifyListeners();
  }

  // getMoreData({List<Hits>? passSearchImagesModel}) {
  //   if (passSearchImagesModel != null &&
  //       passSearchImagesModel.isNotEmpty) {
  //     print("no null");
  //     if(currentMaxImage<passSearchImagesModel.length) {
  //       print(currentMaxImage);
  //       print(passSearchImagesModel.length);
  //
  //       for (int i = 0; i < currentMaxImage + 6; i++) {
  //         if(currentMaxImage<passSearchImagesModel.length) {
  //           showSearchImagesModel?.add(passSearchImagesModel[i]);
  //         }
  //       }
  //       currentMaxImage = currentMaxImage  +2;
  //     }
  //     print("getting more data");
  //     notifyListeners();
  //   }
  // }

  // void pagination() {
  //   if (scrollController.position.pixels >=
  //       (scrollController.position.maxScrollExtent/2)) {
  //
  // getMoreData(passSearchImagesModel: searchImagesModel?.hits);
  //   }
  //   updatePaginationLoader(true);
  // }

  Future<void> loadImages({required BuildContext context, String? text}) async {
    showSearchImagesModel=[];
    try {
      final network = await Helpers.isInternetAvailable();
      if (network) {
        if (text != null && text.isNotEmpty) {
          searchItems = text;
          if (searchItems.contains(" ")) {
            searchItems = searchItems.replaceAll(" ", "+");
          }
        }
        searchImagesResponse =
            await AllImageServices.getApiData(text: searchItems);
        SearchImagesModel? searchImagesModelValue =
            SearchImagesModel.fromJson(jsonDecode(searchImagesResponse ?? ""));
        searchImagesModel = searchImagesModelValue;
        // getMoreData(passSearchImagesModel: searchImagesModel?.hits);

        updatePaginationLoader(true);
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      updatePaginationLoader(false);
    }
    notifyListeners();
  }
}
