import 'dart:async';

import 'package:bots_crypto_app/screens/addCoins.dart';
import 'package:bots_crypto_app/screens/coinList.dart';
import 'package:bots_crypto_app/screens/deleteCoin.dart';
import 'package:bots_crypto_app/screens/updateCoin.dart';
import 'package:bots_crypto_app/utility/colors.dart';
import 'package:bots_crypto_app/utility/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {


  int _selectedIndex = 0;
  static  List<Widget> _pages = <Widget>[
    CoinsList(),
    CreateCoins(),
    UpdateCoin(),
    DeleteCoin(),
  ];


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        type:  BottomNavigationBarType.fixed,
        backgroundColor: kBlackColor,
        elevation: 0,
        mouseCursor: SystemMouseCursors.grab,
        iconSize: 20,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 20,
        selectedIconTheme: IconThemeData(color: kOrangeColor, size: 20),
        selectedItemColor: kOrangeColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,
          color: kGreyColor,
          fontSize: ScreenUtil().setSp(kFontSize, allowFontScalingSelf: true),
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
        ),
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[


      BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.add),
      label: 'Add coin',
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.edit),
      label: 'Edit',
      ),

          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
      ],
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );

  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
