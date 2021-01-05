import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glossary/shared/theme/design_colors.dart';
import 'package:flutter_glossary/ui/pages/listview_builder_page.dart';
import 'package:flutter_glossary/ui/pages/new_page.dart';
import 'package:flutter_glossary/ui/pages/wrap_page.dart';
import 'package:flutter_glossary/ui/widgets/navigation_screen.dart';

class Root extends StatefulWidget {
  Root({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with SingleTickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of first screen

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;
  String title;

  final iconList = <IconData>[
    Icons.home,
    Icons.list,
    Icons.list,
    Icons.list,
    Icons.list,
  ];

  final pagesList = <Widget>[
    WrapPage(),
    NewPage(),
    NewPage(),
    NewPage(),
    ListViewPage(),
  ];

  final titleList = <String>[
    "Início",
    "Categorias",
    "Promoções",
    "Contato",
    "Contato"
  ];

  @override
  void initState() {
    super.initState();
    title = "Início";
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    // Future.delayed(
    //   Duration(seconds: 1),
    //   () => _animationController.forward(),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        leading: IconButton(icon: Icon(Icons.person), onPressed: () {}),
        actions: [
          Padding(
            padding: EdgeInsets.all(12),
            child:
                IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          )
        ],
        title: Text(title),
      ),
      extendBody: true,
      body: NavigationScreen(pagesList[_bottomNavIndex]),
      // ACTIVATE THIS IF YOU WANT FLOATING ACTION BUTTON
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green,
      //   child: Icon(Icons.shopping_cart),
      //   onPressed: () {},
      //   //params
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: pagesList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.amber : DesignColors.COR_TEMA;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 28,
                color: color,
              ),
            ],
          );
        },
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        splashColor: DesignColors.COR_CINZA_TEMA,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.none,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        onTap: (index) => setState(() {
          _bottomNavIndex = index;
          title = titleList[index];
        }),
      ),
    );
  }
}
