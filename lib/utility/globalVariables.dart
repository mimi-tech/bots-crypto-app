import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/dimens.dart';
import 'package:bots_crypto_app/utility/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalVariables{
//for searching coins
  static TextEditingController searchController = TextEditingController();
 static List<MyModel> myAllData = [];
  static List<SelectedCoinModel> selectedCoin = [];
  /// search decoration
  static final searchInput = InputDecoration(
    prefixIcon: Icon(Icons.search,color: kOrangeColor,),
    hintText: "Search...",
    hintStyle:GoogleFonts.oxanium(
      fontSize: ScreenUtil().setSp(kFontSize, allowFontScalingSelf: true),
      color: kHintColor,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide:
      BorderSide(color: kBlackColor),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kBlackColor),


    ),
    border:
    OutlineInputBorder(borderSide: BorderSide(color: kBlackColor)),
  );


  ///First name decoration
  static final createCoinInput = InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(
          20.0, 18.0, 20.0, 18.0),
      border: OutlineInputBorder(
          borderSide: BorderSide(
              color: kGreyColor),
          borderRadius: BorderRadius.circular(
              kBorder)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: kGreyColor),
          borderRadius: BorderRadius.circular(
              kBorder)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: kOrangeColor))



  );


  static notifyFlutterToastError({@required title})async{
    // String title;
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: kRedColor,
        textColor: kWhiteColor);
  }
  static notifyFlutterToastSuccess({@required title})async{
    // String title;
    Fluttertoast.showToast(
        msg: title,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: kWhiteColor );
  }
}