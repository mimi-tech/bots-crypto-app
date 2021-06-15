import 'dart:async';

import 'package:bots_crypto_app/utility/coinConstructor.dart';
import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/fonts.dart';
import 'package:bots_crypto_app/utility/globalVariables.dart';
import 'package:bots_crypto_app/utility/screensAppbar.dart';
import 'package:bots_crypto_app/utility/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class DeleteCoin extends StatefulWidget {
  @override
  _DeleteCoinState createState() => _DeleteCoinState();
}

class _DeleteCoinState extends State<DeleteCoin> {

  String filter;
bool progress = false;

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
      coinTap: (){_deleteCoin(index);},
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: kBlackColor,
        appBar: ScreenAppBar(title: kDeleteCoin,),
        body: ModalProgressHUD(
          inAsyncCall: progress,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(kDeleteCoin2,
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
          ),
        )));
  }

  Future<void> _deleteCoin(int index) async {
    setState(() {
      progress = true;
    });

    try{
    final url = Uri.parse('https://mimi-crypto.herokuapp.com/mimi/deleteCoin/${GlobalVariables.myAllData[index].id}');
    final response = await delete(url);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    setState(() {
      progress = false;
      GlobalVariables.myAllData.removeAt(index);
    });
    GlobalVariables.notifyFlutterToastSuccess(title: 'Coin deleted successfully');

  }catch(e){
      setState(() {
        progress = false;
      });
      GlobalVariables.notifyFlutterToastError(title: kError);
    }
  }
}
