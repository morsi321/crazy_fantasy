import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {
  const AppBarCustom({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final String title;

  @override
  final Size preferredSize;

  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: AppBar(

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(widget.title,
            style: const TextStyle(
                fontSize: 22, fontFamily: 'janna', color: Colors.white)),
        backgroundColor: const Color.fromRGBO(28, 22, 54, .9),
      ),
    );
  }
}

 teasttt() async {
  DocumentSnapshot result = await FirebaseFirestore.instance
      .collection("organizers")
      .doc("thugGiza")
      .collection("vip_league")
      .doc("512-1")
      .get();
  Map tt = result.data() as Map;
  for(int i=0;i<15;i++){
    print("${i+1} => ${tt["groups"]["group2"][0]["matches"][i]}");

    print("===="*20);
  }


}
