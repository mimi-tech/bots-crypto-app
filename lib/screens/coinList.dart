import 'dart:async';
import 'dart:convert';

import 'package:bots_crypto_app/screens/newTest.dart';
import 'package:bots_crypto_app/screens/viewCoin.dart';
import 'package:bots_crypto_app/utility/apis.dart';
import 'package:bots_crypto_app/utility/barChart.dart';
import 'package:bots_crypto_app/utility/coinConstructor.dart';
import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/models.dart';
import 'package:http/http.dart' as http;
import 'package:bots_crypto_app/utility/globalVariables.dart';
import 'package:bots_crypto_app/utility/screensAppbar.dart';
import 'package:bots_crypto_app/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class CoinsList extends StatefulWidget {
  @override
  _CoinsListState createState() => _CoinsListState();
}

class _CoinsListState extends State<CoinsList> {

  String filter;
  bool progress = false;
String value;
Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListCoin();
    _timer = Timer.periodic(Duration(seconds: 2), (_) => getListCoin());
    GlobalVariables.searchController.addListener(() {
      setState(() {
        filter = GlobalVariables.searchController.text;
      });
    });

  }

  Widget bodyList(int index){
    return CoinConstructor(
      coinName: GlobalVariables.myAllData[index].name,
      coinPrize: GlobalVariables.myAllData[index].price,
      coinLogo: GlobalVariables.myAllData[index].logoUrl,
      coinTap: (){
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => ViewCoins(coinId:GlobalVariables.myAllData[index].id, coinName:GlobalVariables.myAllData[index].name));


      },
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: kBlackColor,
        appBar: ScreenAppBar(title: KAllCoins,),
        body: ModalProgressHUD(
          inAsyncCall: progress,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [

                  GraphScreen(),
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
          ),
        )));
  }

  Future<void> getListCoin() async {
    //get the list of coins
    if(GlobalVariables.myAllData.length == 0){
      setState(() {
        progress = true;

      });
    }
    try {
      http.Response res = await http.get(ApiCalls.getCoinApi);
      if (res.statusCode == 201) {

        //String responseBody = res.body;
        Map<String, dynamic>  jsonBody = json.decode(res.body);
         var coins = jsonBody['allCoins'];
        GlobalVariables.myAllData.clear();
        for (var data in coins) {

          GlobalVariables.myAllData.add(MyModel(
            data['id'],
            data['name'],
            data['price'],
            data['website'],
            data['createdAt'],
            data['description'],
            data['logoUrl'],
            data['exchanges']

          ));
        }
        setState(() {});
        setState(() {
          progress = false;
        });
      } else {
        setState(() {
          progress = false;
        });
        GlobalVariables.notifyFlutterToastError(title: kError);
      }
    }catch(e){
      print(e);
    }


}



}


