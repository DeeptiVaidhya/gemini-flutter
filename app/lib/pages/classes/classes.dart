import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/classes/roadmap-tab/roadmap.dart';
import 'package:gemini/pages/classes/virtualvisits-tab/virtual-visits.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/helper.dart';
import '../widget/header.dart';

class Classes extends StatefulWidget {
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int activeTabIndex = 0;
  @override
  void initState() {
    checkLoginToken(context);
    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
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
    return Stack(
      children: <Widget>[
      Image.asset(
        "assets/images/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: header(
        logedin = true,
        back = false,
        logo = false,
        skip = false,
        backlink = true,
        '/home',
        skiplink = false,
        '',
        headingtext = 'Classes',
        isMsgActive =false,   
        isNotificationActive=false,
        context),
        body: Center(
          child: Container(
            width: 500,
            child: Column(
            children: [
              Container(
                width: 336,
                height: 33,
                margin: const EdgeInsets.fromLTRB(5, 18, 0, 0),
                decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(50),
                 border: Border.all(color: AppColors.DEEP_GREEN, width: 1)
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: (activeTabIndex == 0) ? 
                    BoxDecoration(                   
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                    color: AppColors.DEEP_GREEN,
                  ) :  BoxDecoration(                   
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: AppColors.DEEP_GREEN,
                  ) ,
                  labelColor: AppColors.PRIMARY_COLOR,
                  unselectedLabelColor: AppColors.DEEP_GREEN,
                  tabs: [
                    Tab(
                      child: Container(
                      child: Center(child: Text("Roadmap", style: AppCss.font12semibold))),
                    ),
                    Tab(
                      child: Container(
                      child: Center(child: Text("Virtual Visits", style: AppCss.font12semibold))),
                    ),
                ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 18.0),
                  child: TabBarView(
                    controller: _tabController,
                    children: [Roadmap(), VirtualVisits()],
                  ),
                ),
              ),
            ],
          ),
      ),
        ),          
      floatingActionButton: floatingactionbuttion(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: footer(
          ishomepageactive = false,
          isclassespageactive = true,
          islibyrarypageactive = false,
          ismorepageactive = false,
          context)
          )
    ]);
  }
}