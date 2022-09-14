import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  FullImage({this.imageUrl,Key? key}) : super(key: key);
String ? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(5),
          child:  Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(imageUrl??"",fit: BoxFit.cover),
              ElevatedButton(
                child: Text("Back"),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
