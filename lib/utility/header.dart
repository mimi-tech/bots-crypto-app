
import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  Header({@required this.title});

  final String title;

  Widget space() {
    return SizedBox(height: 10.h);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      height: 65.h,

      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          space(),
          space(),
          Center(


              child: Text(title.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.oxanium(
                    textStyle: TextStyle(

                      color: kOrangeColor,
                      fontSize: ScreenUtil()
                          .setSp(kFontSize, allowFontScalingSelf: true),
                      fontWeight: FontWeight.bold,

                      shadows: [
                        Shadow(
                          blurRadius: 1.0,
                          color: kBlackColor,
                          offset: Offset(0.5, 0.5),
                        ),
                      ],
                    )
                ),
              )

          ),
          //space(),
          Divider(thickness: 3.0,color: kNavyBlue,),

        ],
      ),
    );
  }
}