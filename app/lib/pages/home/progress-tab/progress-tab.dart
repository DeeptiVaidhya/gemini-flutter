import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/home/progress-tab/currentclass-tab/current-class.dart';
import 'package:gemini/pages/home/progress-tab/garden-tab/garden-tab.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/helper.dart';

class ProgressTab extends StatefulWidget {
  @override
  _ProgressTabState createState() => _ProgressTabState();
}

class _ProgressTabState extends State<ProgressTab> with SingleTickerProviderStateMixin {

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: height,
            width: width,
            constraints: BoxConstraints(
              maxWidth: 375,
            ),
            child: Column(
              children: [
                Container(
                  height: 33,
                  width: 360,
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
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
                      child: Center(child: Text("Current class", style: AppCss.font12semibold))),
                    ),
                    Tab(
                      child: Container(
                      child: Center(child: Text("Garden", style: AppCss.font12semibold))),
                    ),
                ],
                ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [CurrentClass(), Garden()],
                  ),
                ),
              ],
            ),
          ),
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
