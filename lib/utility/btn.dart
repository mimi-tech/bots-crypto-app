

import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/dimens.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NewBtn extends StatelessWidget {
  NewBtn({@required this.nextFunction, @required this.bgColor, @required this.title});
  final Function nextFunction;
  final Color bgColor;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(bgColor)

        ),

        onPressed:nextFunction,
        child:Text(title,
          style: GoogleFonts.oxanium(
            fontSize: ScreenUtil().setSp(
                kFontSize, allowFontScalingSelf: true),
            color: kWhiteColor,
          ),
        ));

  }
}
