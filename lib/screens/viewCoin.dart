import 'dart:convert';

import 'package:bots_crypto_app/utility/apis.dart';
import 'package:bots_crypto_app/utility/barChart.dart';
import 'package:bots_crypto_app/utility/coinConstructor.dart';
import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/dimens.dart';
import 'package:bots_crypto_app/utility/fonts.dart';
import 'package:bots_crypto_app/utility/globalVariables.dart';
import 'package:bots_crypto_app/utility/header.dart';
import 'package:bots_crypto_app/utility/models.dart';
import 'package:bots_crypto_app/utility/screensAppbar.dart';
import 'package:bots_crypto_app/utility/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sticky_headers/sticky_headers.dart';

class ViewCoins extends StatefulWidget {
  ViewCoins({@required this.coinId,@required this.coinName});
  final dynamic coinId;
  final dynamic coinName;
  @override
  _ViewCoinsState createState() => _ViewCoinsState();
}

class _ViewCoinsState extends State<ViewCoins> {
  bool progress = true;
  Widget spacer() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.04);
  }
  Map<String, dynamic> selectedCoin;
  List<dynamic> coinExchanges = <dynamic>[];
  List<dynamic> coinPrices = <dynamic>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinSelected();
  }

  List<Widget> getExchanges(){
    List<Widget> list =  List<Widget>();
    for(var i = 0; i < coinExchanges.length; i++){
      Widget w = Column(
        children: [
          Text(coinExchanges[i], style: Fonts.titleSize),
        ],

      );
      list.add(w);
    }
    return list;
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
    duration: const Duration(milliseconds: 600),
    curve: Curves.decelerate,
    child: Container(
      //color: kBlackColor.withOpacity(0.4),
    height: MediaQuery.of(context).size.height * 0.8,
    child: SingleChildScrollView(
    child:   StickyHeader(
    header:  Header(title: widget.coinName.toUpperCase(),),

    content:progress?Center(child: CircularProgressIndicator()):Container(
      margin: EdgeInsets.symmetric(horizontal: kHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      spacer(),
      Row(
        children: [
          CoinLogo(logo: selectedCoin['coin']['logoUrl']),
          Text(selectedCoin['coin']['name'], style: Fonts.titleSize),

          Spacer(),
          Text(selectedCoin['coin']['price'].toString(), style: Fonts.prizeStyle),
        ],
      ),

      SelectedCoinChart(title: widget.coinName,),


     spacer(),
      Headings(title: 'Description',),
      Text(selectedCoin['coin']['description'], style: Fonts.titleSize),
      spacer(),
      Headings(title: 'Website',),
      Text(selectedCoin['coin']['website'], style: Fonts.titleSize),

      spacer(),
      Headings(title: 'Exchanges',),

         Column(
           children: getExchanges(),
         ),

      spacer(),
      Text('Created Date',
        style: GoogleFonts.oxanium(
            decoration: TextDecoration.underline,
            textStyle:TextStyle(
              fontSize: ScreenUtil().setSp(kFontSize, allowFontScalingSelf: true),
              color: Colors.blueAccent,
            )),
      ),
      Text(selectedCoin['coin']['createdAt'], style: Fonts.titleSize),

    ],
      ),
    ))))));
  }

  Future<void> getCoinSelected() async {
    //get the list of coins
    setState(() {
      progress = true;
    });
    try {
      http.Response res = await http.get('https://mimi-crypto.herokuapp.com/mimi/getACoin/${widget.coinId}');
      print(res.statusCode);
     // print(res.body);
      if (res.statusCode == 201) {
        setState(() {
          selectedCoin = json.decode(res.body);
          coinExchanges = selectedCoin['coin']['exchanges'];
        });

        var priceChanges = selectedCoin['coinPrices'];

        for (var data in priceChanges){

          GlobalVariables.selectedCoin.add(SelectedCoinModel(
            data['price'],
            data['createdAt'],
          ));

        }
        print(coinPrices);
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
      setState(() {
        progress = false;
      });

    }
}

}
