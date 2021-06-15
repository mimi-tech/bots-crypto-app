import 'dart:convert';
import 'dart:io';
import 'package:bots_crypto_app/utility/coinConstructor.dart';
import 'package:http/http.dart' as http;

import 'package:bots_crypto_app/utility/apis.dart';
import 'package:bots_crypto_app/utility/btn.dart';
import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/dimens.dart';
import 'package:bots_crypto_app/utility/fonts.dart';
import 'package:bots_crypto_app/utility/globalVariables.dart';
import 'package:bots_crypto_app/utility/regConst.dart';
import 'package:bots_crypto_app/utility/screensAppbar.dart';
import 'package:bots_crypto_app/utility/strings.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateCoinText extends StatefulWidget {
  UpdateCoinText({@required this.index});
  final int index;
  @override
  _UpdateCoinTextState createState() => _UpdateCoinTextState();
}

class _UpdateCoinTextState extends State<UpdateCoinText> {
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


  List<dynamic> exchangeList = <dynamic>[];
  bool progress = false;
  File imageUrI;
  final cloudinary = CloudinaryPublic('cloud1234', 'cveuj0by', cache: false);
  String logoUrl;
  Widget spacer() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.02);
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
  void initState() {
    // TODO: implement initState
    super.initState();
   setState(() {
     _coinName.text = GlobalVariables.myAllData[widget.index].name;
     _coinDesc.text = GlobalVariables.myAllData[widget.index].description;
     _coinPrize.text = GlobalVariables.myAllData[widget.index].price.toString();
     _coinAbr.text = GlobalVariables.myAllData[widget.index].website;
     exchangeList = GlobalVariables.myAllData[widget.index].exchange;
   });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        backgroundColor: kBlackColor,
        appBar: ScreenAppNoSearch(title: 'Update ${_coinName.text}',),
        body: ModalProgressHUD(
          inAsyncCall: progress,
          child: SingleChildScrollView(
            child: Column(
              children: [
                spacer(),

                Center(child:
                imageUrI == null? GestureDetector(
                    onTap: (){
                      getImageFromGallery();
                    },
                    child: CoinLogo(logo: GlobalVariables.myAllData[widget.index].logoUrl))

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

                ),

                Text( imageUrI == null? '${_coinName.text} logo':kEditLogo,
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

                        Text(KCoinAbr, style: GoogleFonts.oxanium(textStyle: Fonts.titleSize)),
                        TextFormField(
                          controller: _coinAbr,
                          autocorrect: true,

                          cursorColor: (kTextFieldBorderColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Fonts.textSize,
                          decoration: GlobalVariables.createCoinInput,
                          validator: RegValidation.validateCoinName,
                          onSaved: (String value) {
                            coinAbr = value;
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
                      ],
                    ),
                  ),
                ),


                spacer(),
                NewBtn(nextFunction: (){createCoin();}, bgColor: kOrangeColor, title: 'Update coin'),
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
      } else {

        setState(() {
          progress = true;
        });
        //check if client is changing the coin logo
        if(imageUrI != null){
        try {
          CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(imageUrI.path, resourceType: CloudinaryResourceType.Image),
          );
          logoUrl = response.secureUrl;
          print(response.secureUrl);
        } on CloudinaryException catch (e) {
          print(e.message);
          print(e.request);
        }}
// make Put request to create the coin
        try{
          final response = await http.put(
            Uri.parse('https://mimi-crypto.herokuapp.com/mimi/updateCoin/${GlobalVariables.myAllData[widget.index].id}'),

            body: jsonEncode({
              'name':_coinName.text,
              'description':_coinDesc.text,
              'price':_coinPrize.text,
              'exchanges': exchangeList,
              'website':_coinAbr.text,
              'logoUrl': 'https://res.cloudinary.com/cloud1234/image/upload/v1623677804/idku8rewv2y2uphuhpej.jpg'//imageUrI == null?GlobalVariables.myAllData[widget.index].logoUrl:logoUrl,

            }),

          );
           print(response.body);
           print(response.statusCode);
          if(response.statusCode == 200){
            setState(() {
              progress = false;
            });
            GlobalVariables.notifyFlutterToastSuccess(title: 'Coin updated successfully');

          }else{
            throw Exception('Failed to update coin');
          }

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
    //check if the text field is not empty
    if(_exchange.text.isNotEmpty){

    //get the list of exchanges for this coin
    setState(() {
      exchangeList.add(_exchange.text);
      //clear the text field when the text has been added to the list
      _exchange.clear();
    });
  }}
}
