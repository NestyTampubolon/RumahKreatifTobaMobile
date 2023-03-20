import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rumah_kreatif_toba/pages/account/account_page.dart';
import 'package:rumah_kreatif_toba/pages/auth/register.dart';
import 'package:rumah_kreatif_toba/pages/home/main_home_page.dart';
import 'package:rumah_kreatif_toba/pages/kategori/kategori_produk.dart';

import '../../utils/colors.dart';
import '../auth/masuk.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PersistentTabController _controller;

  @override
  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainHomePage(),
      Masuk(),
      KategoriProduk(),
      AccountPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.redColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.redColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.rectangle_grid_2x2_fill),
        title: ("Produk"),
        activeColorPrimary: AppColors.redColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: ("Account"),
        activeColorPrimary: AppColors.redColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
  return PersistentTabView(
  context,
  controller: _controller,
  screens: _buildScreens(),
  items: _navBarsItems(),
  confineInSafeArea: true,
  backgroundColor: Colors.white, // Default is Colors.white.
  handleAndroidBackButtonPress: true, // Default is true.
  resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
  stateManagement: true, // Default is true.
  hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
  decoration: NavBarDecoration(
  borderRadius: BorderRadius.circular(10.0),
  colorBehindNavBar: Colors.white,
  ),
  popAllScreensOnTapOfSelectedTab: true,
  popActionScreens: PopActionScreensType.all,
  itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
  duration: Duration(milliseconds: 200),
  curve: Curves.ease,
  ),
  screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
  animateTabTransition: true,
  curve: Curves.ease,
  duration: Duration(milliseconds: 200),
  ),
  navBarStyle: NavBarStyle.style13, // Choose the nav bar style with this property.
  );
  }
}
