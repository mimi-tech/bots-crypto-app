
import 'package:bots_crypto_app/utility/strings.dart';
import 'package:flutter/material.dart';

class RegValidation{
  //coin name validation
  static String validateCoinName(String value) {
    if(value.isEmpty) {
      return KCoinName;
    }
    return null;
  }

  //coin website validation
  static String validateCoinAbb(String value) {
    if(value.isEmpty) {
      return KCoinAbr;
    }
    return null;
  }

  //coin price validation
  static String validateCoinPrize(String value) {
    if(value.isEmpty) {
      return KCoinPrize;
    }
    return null;
  }
  //coin desc validation
  static String validateCoinDesc(String value) {
    if(value.isEmpty) {
      return KCoinDesc;
    }
    return null;
  }





}