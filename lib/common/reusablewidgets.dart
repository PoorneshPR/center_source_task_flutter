import 'package:center_source_task_flutter/model/searchimagesmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ReusableWidgets {
  static Widget paginationLoader(bool async) {
    return AnimatedSwitcher(
      duration: const Duration(microseconds: 300),
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: async
          ? const Padding(
              padding: EdgeInsets.all(20),
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            )
          : const SizedBox(),
    );
  }

  static Widget imageContainer({String? imageUrl}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        border: Border.all(width: 2, color: Colors.black54),
      ),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? FadeInImage.memoryNetwork(placeholder:kTransparentImage, image:imageUrl,fit:BoxFit.fill,)
          : const SizedBox(height: 200, width: 200),
    );
  }
}
