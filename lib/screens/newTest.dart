import 'dart:async';

import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/globalVariables.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  List<Color> color = [kOrangeColor, Colors.blueAccent, Colors.pink, Colors.green];


  List<Feature> getFeature(){

    List<double> a = [0.3, 0.6, 0.8, 0.9, 1, 1.2];
    List<double> b = [1, 0.8, 0.6, 0.7, 0.3, 0.1];
    List<double> c = [0.4, 0.2, 0.9, 0.5, 0.6,0.4];
    List<double> d = [0.5, 0.2, 0, 0.3, 1, 1.3];

    List<List<double>> abc = [a,b,c,d];

    List<Feature> list =  List<Feature>();
    for(var i = 0; i < 4; i++){

      Feature w =  Feature(
        title: GlobalVariables.myAllData[i].name,
        color: color[i],
        data: abc[i],
      );



      list.add(w);
    }
    return list;
  }

/*
  final List<Feature> features = [
    Feature(
      title: "Flutter",
      color: Colors.blue,
      data: [0.3, 0.6, 0.8, 0.9, 1, 1.2],
    ),
    Feature(
      title: "Kotlin",
      color: Colors.black,
      data: [1, 0.8, 0.6, 0.7, 0.3, 0.1],
    ),
    Feature(
      title: "Java",
      color: Colors.orange,
      data: [0.4, 0.2, 0.9, 0.5, 0.6, 0.4],
    ),
    Feature(
      title: "React Native",
      color: Colors.red,
      data: [0.5, 0.2, 0, 0.3, 1, 1.3],
    ),
    Feature(
      title: "Swift",
      color: Colors.green,
      data: [0.25, 0.6, 1, 0.5, 0.8, 1,4],
    ),
  ];*/

  List<String> fj = <String> [];
  List<String> p = <String> [];
Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (_) => getDetails());

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return  GlobalVariables.myAllData.length == 0?Container():LineGraph(
      features: getFeature(),
      size: Size(420, 450),
      labelX: fj,
      labelY: p,
      showDescription: true,
      graphColor:kGreyColor,
    );
  }

  void getDetails() {
    p.clear();
    fj.clear();
    getFeature();


    for(int i = 0; i < GlobalVariables.myAllData.length; i++){
      String o = GlobalVariables.myAllData[i].price.toString();
      p.add(o);
      fj.add(GlobalVariables.myAllData[i].name);
    }
  }
}
