import 'package:bots_crypto_app/utility/regConst.dart';
import 'package:bots_crypto_app/utility/strings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
//coin Name input
  test('empty coin name returns error string', () {

    final result = RegValidation.validateCoinName('');
    expect(result, KCoinName);
  });

  test('non-empty coin name returns null', () {

    final result = RegValidation.validateCoinName('coin name');
    expect(result, null);
  });


  //coin website input
  test('empty coin website returns error string', () {

    final result = RegValidation.validateCoinAbb('');
    expect(result, KCoinAbr);
  });

  test('non-empty coin website returns null', () {

    final result = RegValidation.validateCoinAbb('coin website');
    expect(result, null);
  });




  //coin price input
  test('empty coin price returns error string', () {

    final result = RegValidation.validateCoinPrize('');
    expect(result, KCoinPrize);
  });

  test('non-empty coin price returns null', () {

    final result = RegValidation.validateCoinPrize('coin price');
    expect(result, null);
  });

  //coin description input
  test('empty coin description returns error string', () {

    final result = RegValidation.validateCoinDesc('');
    expect(result, KCoinDesc);
  });

  test('non-empty coin description returns null', () {

    final result = RegValidation.validateCoinDesc('coin description');
    expect(result, null);
  });


}
