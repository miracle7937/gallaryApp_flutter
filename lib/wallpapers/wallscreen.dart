import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_ui/wallpapers/fullscrean.dart';







class WallScreen extends StatefulWidget {
  @override
  _WallScreenState createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  List wallpaperList;
StreamSubscription<QuerySnapshot> subscription;
    final CollectionReference collectionReference = Firestore.instance.collection('wallpapers');

@override
  void initState() {
   collectionReference.snapshots().listen((dataSnapshot){

      setState(() {
       wallpaperList=dataSnapshot.documents; 
      });

   });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wallpaper'),),

      body: wallpaperList==null? Center(child: CircularProgressIndicator(backgroundColor: Colors.cyanAccent,),): StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        crossAxisCount: 4,
        itemCount: wallpaperList.length,
        itemBuilder: (context,index){
          var image = wallpaperList[index].data['url'];
          return Material(
            elevation: 5,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: InkWell(
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> FullScrean(imaPath: image,))),
              child: Hero(
              
tag: image,
child: FadeInImage(
  image: NetworkImage(image,),
  fit:  BoxFit.fill,
  placeholder: AssetImage('assets/myImage.jpeg'),
),

            ),),

          );
        },
        staggeredTileBuilder: (index)=>StaggeredTile.count(2, index.isEven? 2:3),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      
    );
  }
  @override
  void dispose() {
   
   subscription?.cancel();
    super.dispose();
  }
}