import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/checkin.dart';

class HealthCheckinRecord extends StatefulWidget {
  @override
  _HealthCheckinRecordState createState() => _HealthCheckinRecordState();
}

class _HealthCheckinRecordState extends State<HealthCheckinRecord>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var healthCheckinList = [];
  var sum = 1;
  var diastolicBp;
  var systolicBp;
  var supplementTaken;


  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    getHealthCheckin();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

   Future<void> getHealthCheckin() async {
    try {
      final data = await getHealthCheckinRecords(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          healthCheckinList = data['data']['sessions'];
        });
      } else {
        if (data['is_valid']) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          toast(data['msg']);
        } else {
          Navigator.pushNamed(context, '/');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }  


  @override
  Widget build(BuildContext context) {
    
  //   final List<Map<String, dynamic>> _libraryItem = [
  //     {
  //       "title": "Session 2",
  //       "subtitle" : "08/01/2019",
  //       "icon": Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
  //       "selected": false,
  //     },
  //     {
  //       "title": "Session 3",
  //       "subtitle" : "08/01/2019",
  //       "icon": Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
  //       "selected": false,
  //     },
  //     {
  //       "title": "Session 4",
  //       "subtitle" : "08/01/2019",
  //       "icon": Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
  //       "selected": false,
  //     },
  //     {
  //       "title": "Session 5",
  //       "subtitle" : "08/01/2019",
  //       "icon": Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
  //       "selected": false,
  //     }
  // ];
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
          back = true,
          logo = false,
          skip = false,
          backlink = true,
          '/more',
          skiplink = false,
          '/health-check-in',
          headingtext = 'Health Check-in', isMsgActive =false,         isNotificationActive=false,
          context
        ),
        resizeToAvoidBottomInset: true,  
        body: SingleChildScrollView(
              child: Center(                
                child:  Container(
                  margin: EdgeInsets.only(top:18,bottom: 40, left: 20.0, right: 20.0),
                  child: healthCheckinList.isEmpty
                 ? Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40, left: 40, right: 40),
                    child: Text( "No records yet.", style: AppCss.grey12medium,textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                    Container(margin: EdgeInsets.only(bottom: 8)),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: healthCheckinList.length,
                    itemBuilder: (context, index) {
                      diastolicBp = healthCheckinList[index]['diastolic_bp'].toString();
                      systolicBp = healthCheckinList[index]['systolic_bp'].toString();
                      supplementTaken = healthCheckinList[index]['is_supplement_taken'].toString();
                      

                      return Container(
                        height: 157.0,
                        width: 335.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.SHADOWCOLOR,
                                spreadRadius: 0,
                                blurRadius: 7,
                                offset: Offset(0, 4))
                          ],
                        ),
                        child: Container(
                        child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, right: 70),
                                child: Text("Session " +(sum + index).toString(),style: AppCss.mediumgrey10bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 20, top: 10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.F4F9FD,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Container(
                                    width: 142,
                                    height: 44,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 80,
                                                      left: 10,
                                                      top: 1),
                                                  child: Text('Mood',style:AppCss.grey10light,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5, right: 85),
                                                  child: Text('10',
                                                      style: AppCss.blue14semibold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(bottom: 15, right: 0),
                                                  child: Image.asset("assets/images/icons/mood/mood-multicolor.png",width: 15,height: 15),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 20, top: 10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.F4F9FD,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Container(
                                    width: 142,
                                    height: 44,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20,
                                                      left: 10,
                                                      top: 1),
                                                  child: Text(
                                                    'Medication Usage',
                                                    style:AppCss.grey10light,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5, right: 80),
                                                  child: Text('Yes',style: AppCss.blue14semibold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15, right: 0),
                                                 child: Image.asset("assets/images/icons/mood/mood-multicolor.png",width: 15,height: 15),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          VerticalDivider(
                            width: 10,
                            color: Colors.transparent,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, right: 0, left: 70),
                                child:  (healthCheckinList[index]['session_date'] !=null)
                                ? Text(dateTimeFormate(healthCheckinList[index]['session_date'],dateFormat:'mm/dd/yyyy'),
                                style: AppCss.mediumgrey10bold,textAlign: TextAlign.left)
                                : Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 0, top: 10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.F4F9FD,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Container(
                                    width: 142,
                                    height: 44,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 70,
                                                      left: 10,
                                                      top: 1),
                                                  child: Text(
                                                    'Comfort',
                                                    style:AppCss.grey10light,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5, right: 90),
                                                  child: Text('10',
                                                      style: AppCss.blue14semibold),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15, right: 0),
                                                  child: Image.asset("assets/images/icons/mood/mood-multicolor.png",width: 15,height: 15),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.F4F9FD,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Container(
                                    width: 142,
                                    height: 44,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 40,left: 10,top: 1),
                                                  child: Text(
                                                    'Blood Pressure',
                                                    style:AppCss.grey10light,
                                                  ),
                                                ),
                                                ((diastolicBp !=null) && (systolicBp !=null)) ?
                                                Padding(
                                                  padding: EdgeInsets.only(top: 5, right: 70, left: 0),
                                                  child: Text(
                                                    (diastolicBp !=null) ? diastolicBp : "" +"/"+ systolicBp,
                                                    style: AppCss.blue14semibold),
                                                )
                                                :Container(),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: 15,
                                                    right: 0,
                                                  ),
                                                  child: Image.asset("assets/images/icons/mood/mood-multicolor.png",width: 15,height: 15),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                      );
                    },
                  ),
                  // child: Container(
                  //   margin:EdgeInsets.only(left: 0, right: 0, top: 20, bottom: 117),
                  //   height: 157.0,
                  //   width: 335.0,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(10),
                  //         topRight: Radius.circular(10),
                  //         bottomLeft: Radius.circular(10),
                  //         bottomRight: Radius.circular(10)),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: AppColors.SHADOWCOLOR,
                  //           spreadRadius: 0,
                  //           blurRadius: 7,
                  //           offset: Offset(0, 4))
                  //     ],
                  //   ),
                  //   child: 
                  // ),
                ),
              ),
            ), 
             floatingActionButton: floatingactionbuttion(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: footer(
              ishomepageactive = false,
              isclassespageactive = false,
              islibyrarypageactive = false,
              ismorepageactive = false,
              context)), 
        ]);
  }
}