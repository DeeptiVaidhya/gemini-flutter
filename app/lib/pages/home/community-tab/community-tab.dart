import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/home/community-tab/buddies-tab/buddies-tab.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/discussion-tab.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/helper.dart';

class CommunityTab extends StatefulWidget {
  @override
  _CommunityTabState createState() => _CommunityTabState();
}

class _CommunityTabState extends State<CommunityTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int activeTabIndex = 0;

  @override
  void initState() {
    checkLoginToken(context);    
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Container(
              height: 33,
              width: 336,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.DEEP_GREEN, width: 1)),
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
                      child: Center(child: Text("Discussion", style: AppCss.font12semibold))),
                    ),
                    Tab(
                      child: Container(
                      child: Center(child: Text("Buddies", style: AppCss.font12semibold))),
                    ),
                ],
                ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 18.0),
                child: TabBarView(
                  controller: _tabController,
                  children: [Discussion(controller: _tabController), BuddiesTab()],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: floatingactionbuttion(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: footer(
            ishomepageactive = true,
            isclassespageactive = false,
            islibyrarypageactive = false,
            ismorepageactive = false,
            context));
  }
}
