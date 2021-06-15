
import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts{


  static final textSize = GoogleFonts.oxanium(
      textStyle:TextStyle(
    fontSize: ScreenUtil().setSp(kFontSize, allowFontScalingSelf: true),
    color: kWhiteColor,
  ));

  static final titleSize = GoogleFonts.oxanium(
      textStyle:TextStyle(
    fontSize: ScreenUtil().setSp(kFontSize, allowFontScalingSelf: true),
    color: kGreyColor,
  ));

  static final coinSize = TextStyle(
    fontSize: ScreenUtil().setSp(kFontSize, allowFontScalingSelf: true),
    color: kWhiteColor,
  );

  static final prizeStyle =  GoogleFonts.oxanium(
      textStyle:TextStyle(
    fontSize: ScreenUtil().setSp(14, allowFontScalingSelf: true),
    color: kSeaGreen,
    fontWeight: FontWeight.bold
  ));

  static final driverLicence = TextStyle(
    fontSize: ScreenUtil().setSp(12, allowFontScalingSelf: true),
    color: kBlackColor,
  );
}