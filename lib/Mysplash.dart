import 'dart:async';

import 'package:blooddonner/Mydonners.dart';
import 'package:flutter/material.dart';

class Mysplash extends StatefulWidget {
  const Mysplash({super.key});

  @override
  State<Mysplash> createState() => _MysplashState();
}

class _MysplashState extends State<Mysplash> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Mydonners()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
        height: 200,
        child:Align( alignment: Alignment.center,  child: Text("Blood Donner",style: TextStyle(color: Colors.red,fontSize: 21),))

    );
  }
}
