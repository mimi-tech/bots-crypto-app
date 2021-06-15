import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bots_crypto_app/screens/coinList.dart';
import 'package:bots_crypto_app/utility/globalVariables.dart';
import 'package:bots_crypto_app/utility/models.dart';
import 'package:bots_crypto_app/utility/strings.dart';

class ApiCalls {
  static String getCoinApi = 'https://mimi-crypto.herokuapp.com/mimi/getAllListedCoins';
  static String createCoinApi = 'https://mimi-crypto.herokuapp.com/mimi/listCoin';
  static bool checkRes = true;

}