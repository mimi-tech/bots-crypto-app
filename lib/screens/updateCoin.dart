import 'dart:async';

import 'package:bots_crypto_app/screens/updateCoinText.dart';
import 'package:bots_crypto_app/utility/coinConstructor.dart';
import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/fonts.dart';
import 'package:bots_crypto_app/utility/globalVariables.dart';
import 'package:bots_crypto_app/utility/screensAppbar.dart';
import 'package:bots_crypto_app/utility/strings.dart';
import 'package:flutter/material.dart';

class UpdateCoin extends StatefulWidget {
  @override
  _UpdateCoinState createState() => _UpdateCoinState();
}

class _UpdateCoinState extends State<UpdateCoin> {

  String filter;
  Timer _timer;

  @override
  void initState() {
  // TODO: implement initState
  super.initState();
  _timer =  Timer.periodic(Duration(seconds: 2), (Timer t) => setState((){}));
  GlobalVariables.searchController.addListener(() {
  setState(() {
  filter = GlobalVariables.searchController.text;
  });
  });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
  Widget bodyList(int index){
  return CoinConstructor(
  coinName: GlobalVariables.myAllData[index].name,
  coinPrize: GlobalVariables.myAllData[index].price,
  coinLogo: GlobalVariables.myAllData[index].logoUrl,
  coinTap: (){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateCoinText(index:index)));

  },
  );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: kBlackColor,
        appBar: ScreenAppBar(title: kUpdateCoin,),
        body: Container(


   child: SingleChildScrollView(
    child: Container(
    child: Column(
    children: [
      SizedBox(height: 30,),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(kTapCoin,
            textAlign: TextAlign.center,
            style:Fonts.titleSize),
      ),
    SizedBox(height: 30,),
    ListView.builder(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: GlobalVariables.myAllData.length,
    itemBuilder: (context, int index) {
    return  filter == null || filter == "" ?bodyList(index):
    '${GlobalVariables.myAllData[index].name}'.toLowerCase()
        .contains(filter.toLowerCase())

    ?bodyList(index):Container();
    })

    ],
    ),
    ),
    ))));
  }
}
