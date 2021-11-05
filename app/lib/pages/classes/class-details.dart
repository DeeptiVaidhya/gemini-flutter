import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/classes/todos-tab/todos-tab.dart';
import 'package:gemini/pages/home/home.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../widget/header.dart';

class ClasseDetails extends StatefulWidget {
  final String classId;
  final String weekNumber;
  const ClasseDetails({Key? key,required this.classId,this.weekNumber=""}) : super(key: key);
  @override
  _ClasseDetailsState createState() => _ClasseDetailsState();
}

class _ClasseDetailsState extends State<ClasseDetails>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var cId;
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
    return Scaffold(
      appBar: header(
        logedin = true,
        back = true,
        logo = false,
        skip = false,
        backlink = true,
        '/classes',
        skiplink = false,
        '/',
        headingtext = 'Class '+widget.weekNumber,
        isMsgActive =false,
        isNotificationActive=false,
        context),
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              children: [
              Container(
                margin : const EdgeInsets.only(top: 18,left: 20, right: 24),
                child : Text("Our Bodies and Inflammation",textAlign: TextAlign.center,style: AppCss.blue20semibold),
              ),        
              Container(
                 margin: EdgeInsets.only(top:15),
                 child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                     Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         CircularStepProgressIndicator(
                           totalSteps: 1,
                           currentStep: 1,
                           stepSize: 5,
                           selectedColor: AppColors.ORANGE,
                           unselectedColor: AppColors.TRANSPARENT,
                           padding: 0,
                           width: 40,
                           height: 40,
                           child: Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: SvgPicture.asset("assets/images/icons/classes-icon/learning-icon/learning.svg",width: 18,height: 18),
                           ),
                           selectedStepSize: 3,
                           roundedCap: (_, __) => true,
                         ),
                          Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                           child: Container(
                             alignment: Alignment.bottomCenter,
                             child: Text("learning".toUpperCase(),
                                 textAlign: TextAlign.center,
                                 style: AppCss.mediumgrey10bold),
                           ),
                         ),
                       ],
                     ),
                     Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         CircularStepProgressIndicator(
                           totalSteps: 2,
                           currentStep: 1,
                           stepSize: 5,
                           selectedColor: AppColors.ORANGE,
                           unselectedColor: AppColors.TRANSPARENT,
                           padding: 0,
                           width: 40,
                           height: 40,
                           child: Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: SvgPicture.asset("assets/images/icons/classes-icon/meditation_pose/meditation.svg",
                             width: 15,height: 21),
                           ),
                           selectedStepSize: 3,
                           roundedCap: (_, __) => true,
                         ),
                         Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                           child: Container(
                             width: 50,
                             child: Text("Mind Practice".toUpperCase(),style: AppCss.mediumgrey10bold,textAlign: TextAlign.center),
                           ),
                         ),
                       ],
                     ),
                     Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         CircularStepProgressIndicator(
                           totalSteps: 2,
                           currentStep: 1,
                           stepSize: 5,
                           selectedColor: AppColors.ORANGE,
                           unselectedColor: AppColors.TRANSPARENT,
                           padding: 0,
                           width: 40,
                           height: 40,
                           child: Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: SvgPicture.asset("assets/images/icons/classes-icon/practice-icon/practice.svg",
                                 width: 20,
                                 height: 17),
                           ),
                           selectedStepSize: 3,
                           roundedCap: (_, __) => true,
                         ),
                          Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                           child: Container(
                             width: 50,
                             child: Text("body Practice".toUpperCase(),
                                 textAlign: TextAlign.center,
                                 style: AppCss.mediumgrey10bold),
                           ),
                         ),
                       ],
                     ),
                     InkWell(
                      onTap: () {
                        var type = "community";                
                        var url="/home";                              
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute( 
                          settings:  RouteSettings(name:url),
                          builder: (context) => new Home(
                            type : type,
                          ) 
                          )
                        );
                      },
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           CircularStepProgressIndicator(
                             totalSteps: 2,
                             currentStep: 1,
                             stepSize: 5,
                             selectedColor: AppColors.ORANGE,
                             unselectedColor: AppColors.TRANSPARENT,
                             padding: 0,
                             width: 40,
                             height: 40,
                             child: Padding(
                               padding: const EdgeInsets.all(5.0),
                               child: SvgPicture.asset("assets/images/icons/classes-icon/community-icon/community.svg",width: 20,height: 20),
                             ),
                             selectedStepSize: 3,
                             roundedCap: (_, __) => true,
                           ),
                            Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                             child: Container(
                               width: 64,
                               child: Text("community".toUpperCase(),
                                   textAlign: TextAlign.center,
                                   style: AppCss.mediumgrey10bold),
                             ),
                           ),
                         ],
                       ),
                     ),
                     Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         CircularStepProgressIndicator(
                           totalSteps: 2,
                           currentStep: 1,
                           stepSize: 5,
                           selectedColor: AppColors.ORANGE,
                           unselectedColor: AppColors.TRANSPARENT,
                           padding: 0,
                           width: 40,
                           height: 40,
                           child: Padding(
                             padding: const EdgeInsets.all(5.0),
                             child: SvgPicture.asset("assets/images/icons/classes-icon/journal-icon/journal.svg",width: 18,height: 20),
                           ),
                           selectedStepSize: 3,
                           roundedCap: (_, __) => true,
                         ),
                         Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Container(
                            width: 50,
                            child: Text("Journal".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: AppCss.mediumgrey10bold),
                          ),
                         ),
                       ],
                     ),
                     ]
                   ),
                 ),
              ),
              Container(
                width: 336,
                height: 33,
                margin: const EdgeInsets.fromLTRB(5, 18, 8, 0),
                decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(50),
                 border: Border.all(color: AppColors.DEEP_GREEN, width: 1)
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: ( activeTabIndex == 0) ? 
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
                      child: Center(child: Text("To Do’s", style: AppCss.font12semibold))),
                    ),
                    Tab(
                      child: Container(
                          child: Center(child: Text("Practice log", style: AppCss.font12semibold))),
                    ),
                ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 18.0),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ToDoTab(classId: widget.classId), 
                      Container(
                        child: Center(child: Text("You have no practice to read",style: AppCss.grey12medium,textAlign: TextAlign.center)),
                      ), 
                    ],
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
            context));
  }
}
