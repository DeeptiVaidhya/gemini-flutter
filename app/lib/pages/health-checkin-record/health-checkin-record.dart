import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';

class HealthCheckinRecord extends StatefulWidget {
  @override
  _HealthCheckinRecordState createState() => _HealthCheckinRecordState();
}

class _HealthCheckinRecordState extends State<HealthCheckinRecord>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _libraryItem = [
      {
        "title": "Session 2",
        "subtitle" : "08/01/2019",
        "icon": Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
        "selected": false,
      },
      {
        "title": "Session 3",
        "subtitle" : "08/01/2019",
        "icon": Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
        "selected": false,
      },
      {
        "title": "Session 4",
        "subtitle" : "08/01/2019",
        "icon": Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
        "selected": false,
      },
      {
        "title": "Session 5",
        "subtitle" : "08/01/2019",
        "icon": Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30),
        "selected": false,
      }
  ];
    return Stack(      
      children: <Widget>[
      Image.asset(
        "images/bg.png",
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
         body: LayoutBuilder(
            builder: (context, constraints) {
            return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: constraints.maxWidth < 500 ? EdgeInsets.zero : const EdgeInsets.all(0.0),
            child: Center(
              child: Container(   
              child: Column(
                children: [
                  Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 500,
                    ), 
                    margin: const EdgeInsets.only(top:20,left: 20,right: 20),
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) => Padding(padding: EdgeInsets.only(top:5)),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _libraryItem.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shadowColor: Color(0xFF3333331A),
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            elevation: 1.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ListTile(
                              minLeadingWidth: 0,
                              horizontalTitleGap: 0.0,
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal:
                              20.0),
                              isThreeLine:true, 
                              dense:true,
                              title: Text(_libraryItem[index]['title'],style: AppCss.mediumgrey10bold),
                              subtitle: ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Card(
                                      color: Color(0XFFF4F9FD),
                                      child: Column(        
                                        children: <Widget>[
                                          Text("Mood",style: AppCss.mediumgrey10bold),
                                          Text("10",style: AppCss.blue16semibold),
                                        ]
                                      ),
                                    ), 
                                    Card(
                                      color: Color(0XFFF4F9FD),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,          
                                        children: <Widget>[
                                          Text("Mood",style: AppCss.mediumgrey10bold),
                                          Text("10",style: AppCss.blue16semibold),
                                        ]
                                      ),
                                    ), 
                                ]),
                              ),
                              trailing:Text(_libraryItem[index]['subtitle'],style: AppCss.mediumgrey10bold),                                                 
                              onTap: () {}, 
                              selected: _libraryItem[index]['selected'],
                            ),
                          );
                      },
                    ),
                  ),
                ),                                           
                ],
              ),
            ),
            ),
            );
            }
            )
        ),
      ]
        );
  }
}
