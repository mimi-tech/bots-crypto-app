import 'dart:convert';
import 'dart:io';
import 'package:bots_crypto_app/utility/apis.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:bots_crypto_app/utility/btn.dart';
import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/dimens.dart';
import 'package:bots_crypto_app/utility/fonts.dart';
import 'package:bots_crypto_app/utility/globalVariables.dart';
import 'package:bots_crypto_app/utility/regConst.dart';
import 'package:bots_crypto_app/utility/screensAppbar.dart';
import 'package:bots_crypto_app/utility/strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CreateCoins extends StatefulWidget {
  @override
  _CreateCoinsState createState() => _CreateCoinsState();
}

class _CreateCoinsState extends State<CreateCoins> {
  TextEditingController _coinName = TextEditingController();
  TextEditingController _coinAbr = TextEditingController();
  TextEditingController _coinPrize = TextEditingController();
  TextEditingController _coinDesc = TextEditingController();
  TextEditingController _companyName = TextEditingController();
  TextEditingController _exchange = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String coinName;
  String coinAbr;
  String coinPrize;
  String coinDesc;
  String companyName;
  String exchange;

  bool progress = false;
  File imageUrI;
  List<dynamic> exchangeList = <dynamic>[];
  final cloudinary = CloudinaryPublic('cloud1234', 'cveuj0by', cache: false);
String logoUrl;
  Widget spacer() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.04);
  }

  Future getImageFromGallery() async {

    File file = await FilePicker.getFile(
      type: FileType.image,

    );
    setState(() {
      imageUrI  = file;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: kBlackColor,
        appBar: ScreenAppNoSearch(title: KCreateCoins,),
        body: ModalProgressHUD(
          inAsyncCall: progress,
          child: SingleChildScrollView(
            child: Column(
              children: [
                spacer(),

                Center(child:
                imageUrI == null? Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: kTextFieldBorderColor,
                        shape: BoxShape.circle
                    ),
                    child: IconButton(icon: Icon(Icons.monetization_on), onPressed: (){getImageFromGallery();},color: kWhiteColor,)

                )

                    : GestureDetector(
                  onTap: (){

                    getImageFromGallery();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: FileImage(imageUrI),
                    radius: 50,

                  ),
                )

                )


                ,

                Text( imageUrI == null? kAddLogo:kEditLogo,
                  style:GoogleFonts.oxanium(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(kFontSize, allowFontScalingSelf: true),
                    color: imageUrI == null?  kPix:kRedColor,
                  ),
                ),

                spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: kHorizontal),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(KCoinName, style: GoogleFonts.oxanium(textStyle: Fonts.titleSize)),
                        TextFormField(
                          controller: _coinName,
                          autocorrect: true,

                          cursorColor: (kTextFieldBorderColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Fonts.textSize,
                          decoration: GlobalVariables.createCoinInput,
                          validator: RegValidation.validateCoinName,
                          onSaved: (String value) {
                            coinName = value;
                          },
                        ),


                        spacer(),

                        Text(KCoinPrize, style: GoogleFonts.oxanium(textStyle: Fonts.titleSize)),
                        TextFormField(
                          controller: _coinPrize,
                          autocorrect: true,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: (kTextFieldBorderColor),
                          keyboardType: TextInputType.numberWithOptions(),
                          style: Fonts.textSize,
                          decoration: GlobalVariables.createCoinInput,
                          validator: RegValidation.validateCoinPrize,
                          onSaved: (String value) {
                            coinPrize = value;
                          },
                        ),


                        spacer(),

                        Text(KCoinDesc, style: GoogleFonts.oxanium(textStyle: Fonts.titleSize)),
                        TextFormField(
                          controller: _coinDesc,
                          autocorrect: true,
                          maxLines: null,
                          cursorColor: (kTextFieldBorderColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Fonts.textSize,
                          decoration: GlobalVariables.createCoinInput,
                          validator: RegValidation.validateCoinDesc,
                          onSaved: (String value) {
                            coinDesc = value;
                          },
                        ),


                        spacer(),



                        Text(KCoinAbr, style: GoogleFonts.oxanium(textStyle: Fonts.titleSize)),
                        TextFormField(
                          controller: _coinAbr,
                          autocorrect: true,

                          cursorColor: (kTextFieldBorderColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Fonts.textSize,
                          decoration: GlobalVariables.createCoinInput,
                          validator: RegValidation.validateCoinAbb,
                          onSaved: (String value) {
                            coinAbr = value;
                          },
                        ),

                        spacer(),


                             ListView.builder(
                             physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                             itemCount: exchangeList.length,
                             itemBuilder: (context, int index) {
                               return ListTile(title: Text(exchangeList[index], style: GoogleFonts.oxanium(textStyle: Fonts.titleSize)),
                                 leading: Icon(Icons.circle,color: Colors.purpleAccent,),
                                 trailing: IconButton(icon: Icon(Icons.clear,color: kRedColor,), onPressed: (){
                                   //delete exchange based on index selected
                                   setState(() {
                                     exchangeList.removeAt(index);
                                   });

                                 }),
                               );
                                }),
                        spacer(),

                        Text(KExchange, style: GoogleFonts.oxanium(textStyle: Fonts.titleSize)),
                        TextFormField(
                          controller: _exchange,
                          autocorrect: true,
                          cursorColor: (kTextFieldBorderColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Fonts.textSize,
                          decoration: GlobalVariables.createCoinInput,
                          //validator: RegValidation.validateExchange,
                          onSaved: (String value) {
                            exchange = value;
                          },
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                              shape:BoxShape.circle,
                              color: Colors.blueAccent,
                            ),
                            child: IconButton(icon: Icon(Icons.add,color: kWhiteColor,), onPressed: (){
                              _addExchange();
                            }),
                          ),
                        ),
                        spacer(),
                      ],
                    ),
                  ),
    ),
                spacer(),
                NewBtn(nextFunction: (){createCoin();}, bgColor: kOrangeColor, title: kPost),
                spacer(),
              ],
            ),
          ),
        )));
  }

  Future<void> createCoin() async {
    //check if form inputs are not empty
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      //check if exchange list is empty
      if(exchangeList.length == 0){
        GlobalVariables.notifyFlutterToastError(title: kExchangeCoin);
      }

      //check if the client picked the coin logo
      if(imageUrI == null){
        GlobalVariables.notifyFlutterToastError(title: kAddLogo);
      }else {
        setState(() {
          progress = true;
        });
        try {
          CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(imageUrI.path, resourceType: CloudinaryResourceType.Image),
          );
          logoUrl = response.secureUrl;
          print(response.secureUrl);
        } on CloudinaryException catch (e) {
          print(e.message);
          print(e.request);
        }
//// make POST request to create the coin

        try{
          final response = http.post(
            Uri.parse(ApiCalls.createCoinApi),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'name':_coinName.text,
              'description':_coinDesc.text,
              'price':_coinPrize.text,
              'exchanges': exchangeList,
              'website':_coinAbr.text,
              'logoUrl':logoUrl,

            }),

          );
          response.then((value) {
            setState(() {
              progress = false;
            });
            GlobalVariables.notifyFlutterToastSuccess(title: 'Created successfully');

          });

        }catch (e){
          print(e);
          setState(() {
            progress = false;
          });
          GlobalVariables.notifyFlutterToastError(title: kError);
        }


      }


    }else{
      print('Empty fields');
    }



  }


  void _addExchange() {

    //get the list of exchanges for this coin
    setState(() {
      exchangeList.add(_exchange.text);
      //clear the text field when the text has been added to the list
      _exchange.clear();
    });
  }
}
