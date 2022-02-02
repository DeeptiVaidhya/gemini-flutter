import 'package:flutter/material.dart';
import 'package:gemini/pages/library/all-library.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/library.dart';
import '../app-css.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  var menuList = [];
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  void initState() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loader(context, _keyLoader));
    checkLoginToken(context);
    getLibraryFilter(context);
    super.initState();
  }

  Future<void> getLibraryFilter([context]) async {
    try {
      final data = await getLibraryFilterMenu(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          menuList = data['data']['menu'];
        });
        onSelect(0);
      } else {
        if (data['is_valid']) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          toast(data['msg']);
        } else {
          Navigator.pushNamed(context, '/');
          Navigator.of(context, rootNavigator: true).pop();
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  onSelect(sIndex, [isSelect = false]) {
    var dmenu = [];
    menuList.asMap().forEach((index, fltr) {
      fltr['isChecked'] = sIndex == index ? isSelect : false;
      dmenu.add(fltr);
    });
    setState(() {
      menuList:
      dmenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Map<String, IconData> _icons = {
      'favorite': Icons.favorite,
    };

    List<Tab> tabs = <Tab>[];
    for (var menu in menuList) {
      tabs.add(Tab(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.DEEP_BLUE, width: 2)),
        child: menu['isIcon']
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(menu['title']),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Icon(
                    _icons['favorite'],
                    color: AppColors.LIGHT_ORANGE,
                  ),
                ],
              )
            : Align(
                alignment: Alignment.center,
                child: Text(menu['title']),
              ),
      )));
    }
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/bg.png",
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: header(
            logedin = true,
            back = false,
            logo = false,
            skip = false,
            backlink = false,
            '/',
            skiplink = false,
            '',
            headingtext = 'Library',
            isMsgActive = false,
            isNotificationActive = false,
            context),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            margin: const EdgeInsets.only(top: 18.0),
            child: DefaultTabController(
              length: tabs.length,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    color: Colors.transparent,
                    constraints: BoxConstraints.expand(height: 33, width: 375),
                    child: TabBar(
                      indicatorColor: AppColors.DEEP_BLUE,
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.DEEP_BLUE,
                      labelStyle: AppCss.white14medium,
                      unselectedLabelStyle: AppCss.blue14semibold,
                      isScrollable: true,
                      tabs: tabs,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 2.0,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.DEEP_BLUE),
                      labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: menuList.map((e) {
                        return AllLibrary(type: e['id']);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        floatingActionButton: floatingactionbuttion(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: footer(
            ishomepageactive = false,
            isclassespageactive = false,
            islibyrarypageactive = true,
            ismorepageactive = false,
            context),
      ),
    ]);
  }
}
