import 'package:flutter/material.dart';
class FullScrean extends StatelessWidget {
  final String imaPath;

  FullScrean({Key key, this.imaPath}) : super(key: key);

   final LinearGradient gradient = new LinearGradient(colors: [Colors.black45,Colors.red],begin: Alignment.bottomCenter, end: Alignment.topCenter);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(gradient: gradient),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Hero(
              
                tag: imaPath,
                child: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: FadeInImage(image: NetworkImage(imaPath), placeholder: AssetImage('assets/myImage.jpeg'),),),
              ),
            ),Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(icon: Icon(Icons.high_quality),onPressed: ()=>Navigator.pop(context),),
                  )
                ],
              ),
            )
          ],),
        ),
      ),
    );
  }
}