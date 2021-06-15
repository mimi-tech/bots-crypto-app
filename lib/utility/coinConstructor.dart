import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/dimens.dart';
import 'package:bots_crypto_app/utility/fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CoinConstructor extends StatelessWidget {
  CoinConstructor({@required this.coinName, @required this.coinPrize,@required this.coinTap,@required this.coinLogo});
  final dynamic coinName;
  final dynamic coinPrize;
  final dynamic coinLogo;
  final Function coinTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: coinTap,
      child: Card(
        color: kListView,
        elevation: 4,
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: coinLogo,
            imageBuilder: (context, imageProvider) => Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(

                shape: BoxShape.circle,
                image: DecorationImage(
                    image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) =>  Icon(Icons.ac_unit_outlined,color: kOrangeColor,),
          ),
          title: Text(coinName.toUpperCase(),
            style: Fonts.coinSize,
          ),
          trailing: Text('\$$coinPrize'.toString(),
            style: Fonts.prizeStyle,
          ),),
      ),
    );
  }
}


class CoinLogo extends StatelessWidget {
  CoinLogo({@required this.logo});
  final dynamic logo;
  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
      imageUrl: logo,
      imageBuilder: (context, imageProvider) => Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(

          shape: BoxShape.circle,
          image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) =>  Icon(Icons.ac_unit_outlined,color: kOrangeColor,),
    );
  }
}



class Headings extends StatelessWidget {
  Headings({@required this.title});
  final dynamic title;
  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: GoogleFonts.oxanium(
          decoration: TextDecoration.underline,
          textStyle:TextStyle(
            fontSize: ScreenUtil().setSp(kFontSize, allowFontScalingSelf: true),
            color: Colors.blueAccent,
          )),
    );
  }
}
