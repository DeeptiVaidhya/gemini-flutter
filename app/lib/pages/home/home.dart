import 'package:flutter/material.dart';
import 'package:gemini/pages/home/dashboard-tab/dashboard-tab.dart';
import 'package:gemini/pages/home/progress-tab/progress-tab.dart';
import 'package:gemini/pages/home/community-tab/community-tab.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:localstorage/localstorage.dart';

class Home extends StatefulWidget {
  final String type;
  const Home({Key? key,this.type=""}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final LocalStorage storage = new LocalStorage('gemini');
  get username => null;
  int activeTabIndex = 0;
  var type;
  
  @override
  void initState() {
    type = widget.type;
   checkLoginToken(context);
    super.initState();
    _tabController = TabController(
      length: 3,
      initialIndex: (type=="community")? 2:0,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;    
    return Stack(
      children: <Widget>[
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
          '/',
          headingtext = storage.getItem('name') != null ? 'Hi, ' +storage.getItem('name')+'!' : 'Hi', isMsgActive =false,         isNotificationActive=false,
        context
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: 500,
              height: 33,
              margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: TabBar(
                indicatorPadding: EdgeInsets.symmetric(vertical: 0),
                unselectedLabelColor: AppColors.DEEP_GREEN,
                labelColor: Colors.white,
                indicatorColor: AppColors.DEEP_GREEN,
                indicator: BoxDecoration(borderRadius: BorderRadius.circular(30),
                color: AppColors.DEEP_GREEN),
                labelStyle: AppCss.white12semibold,
                labelPadding: EdgeInsets.zero,
                tabs: [
                  Tab(text: 'Dashboard'),
                  Tab(text: 'Progress'),
                  Tab(text: 'Community')
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 18.0),
                child: TabBarView(
                  children: [
                    DashboardTab(),
                    ProgressTab(),
                    CommunityTab()
                  ],
                  controller: _tabController,
                ),
              ),
            ),
          ],
        ),
      ),
      ),
      ]
    );
  }
}
