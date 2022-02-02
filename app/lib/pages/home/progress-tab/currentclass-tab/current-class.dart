import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/post.dart';
import 'package:gemini/pages/learning-topic/learning-topic.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';

import '../../home.dart';

class CurrentClass extends StatefulWidget {
  @override
  _CurrentClassState createState() => _CurrentClassState();
}

class _CurrentClassState extends State<CurrentClass> {
  var classId;
  var cId;
  var url;
  var posttopicId;
  var objectiveList = [];
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loader(context, _keyLoader));
    courseClassDetailData();
    super.initState();
  }

  Future<void> courseClassDetailData() async {
    try {
      final data = await courseClassDetail(
          <String, dynamic>{"class_id": "", "is_current_class": true});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          classId = data['data']['class_id'];
          posttopicId = data['data']['post_topic_id'];
          objectiveList = data['data']['class_objective'];
        });
      } else {
        if (data['is_valid'] == false) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          var type = "progress";
          var url = "/home";
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              settings: RouteSettings(name: url),
              builder: (context) => new Home(type: type)));
          toast(data['msg']);
        } else {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          var type = "progress";
          var url = "/home";
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              settings: RouteSettings(name: url),
              builder: (context) => new Home(type: type)));
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.pushNamed(context, '/home');
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isVarEmpty(classId) == '') {
      return Container();
    }
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(builder: (context, constraints) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              child: Container(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 375,
                      ),
                      padding:
                          const EdgeInsets.only(top: 23, left: 20, right: 20),
                      child: Column(
                        children: [
                          Text(
                            "Below is your progress for this class so far.",
                            style: AppCss.grey12regular,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 11, bottom: 19),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('',
                                      style: TextStyle(color: Colors.white)),
                                  SvgPicture.asset(
                                      "assets/images/icons/trowel.svg",
                                      width: 20,
                                      height: 20),
                                  SvgPicture.asset(
                                      "assets/images/icons/seeds.svg",
                                      width: 20,
                                      height: 20),
                                  SvgPicture.asset(
                                      "assets/images/icons/watering-can.svg",
                                      width: 20,
                                      height: 20),
                                  SvgPicture.asset(
                                      "assets/images/icons/sun.svg",
                                      width: 20,
                                      height: 20),
                                  SvgPicture.asset(
                                      "assets/images/icons/sprout.svg",
                                      width: 20,
                                      height: 20),
                                ]),
                          ),
                          //   Padding(
                          //   padding: EdgeInsets.all(15.0),
                          //   child: new LinearProgressIndicator(
                          //     width: MediaQuery.of(context).size.width - 50,
                          //     animation: true,
                          //     lineHeight: 20.0,
                          //     animationDuration: 2500,
                          //     percent: 0.8,
                          //     center: Text("80.0%"),
                          //     linearStrokeCap: LinearStrokeCap.roundAll,
                          //     progressColor: Colors.green,
                          //   ),
                          // ),
                          //
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 18,
                                decoration: new BoxDecoration(
                                  color: Color(0xffCEF5CC),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30)), // round angle
                                ),
                              ),
                              Positioned(
                                left: 0,
                                child: Container(
                                  width: 70,
                                  height: 18,
                                  decoration: new BoxDecoration(
                                    color: AppColors.DEEP_GREEN,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30)), // round angle
                                  ),
                                ),
                              )
                            ],
                          ),
                          // Container(
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.all(Radius.circular(30)),
                          //       child: LinearProgressIndicator(
                          //         value: 0.2,
                          //         backgroundColor: Color(0xffCEF5CC),
                          //         valueColor: AlwaysStoppedAnimation<Color>(AppColors.DEEP_GREEN),
                          //         minHeight: 18,
                          //       ),
                          //     ),
                          //   ),

                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "0",
                                  style: AppCss.grey12regular,
                                ),
                                Text(
                                  "20",
                                  style: AppCss.grey12regular,
                                ),
                                Text(
                                  "40",
                                  style: AppCss.grey12regular,
                                ),
                                Text(
                                  "60",
                                  style: AppCss.grey12regular,
                                ),
                                Text(
                                  "80",
                                  style: AppCss.grey12regular,
                                ),
                                Text(
                                  "100",
                                  style: AppCss.grey12regular,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/mental-checkin');
                            },
                            child: new Container(
                              height: 62.0,
                              margin: EdgeInsets.only(top: 19),
                              decoration: BoxDecoration(
                                color: AppColors.PRIMARY_COLOR,
                                borderRadius: new BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.SHADOWCOLOR,
                                      spreadRadius: 0,
                                      blurRadius: 7,
                                      offset: Offset(0, 4))
                                ],
                              ),
                              child: new Center(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0,
                                            left: 20,
                                            right: 20.0,
                                            bottom: 19),
                                        child: new Text('Health Check-in',
                                            style: AppCss.blue18semibold,
                                            textAlign: TextAlign.left),
                                      ))),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              var cId = isVarEmpty(classId);
                              var url = "/learning-topics/$cId";
                              Navigator.of(context)
                                  .pushReplacement(new MaterialPageRoute(
                                      settings: RouteSettings(name: url),
                                      builder: (context) => new LearningTopic(
                                            classId: cId,
                                            type: "home",
                                          )));
                            },
                            child: new Container(
                              margin: EdgeInsets.only(top: 9),
                              height: 62.0,
                              decoration: BoxDecoration(
                                color: AppColors.PRIMARY_COLOR,
                                borderRadius: new BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.SHADOWCOLOR,
                                      spreadRadius: 0,
                                      blurRadius: 7,
                                      offset: Offset(0, 4))
                                ],
                              ),
                              child: new Center(
                                  child: Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                    top: 20.0,
                                    left: 20,
                                    right: 20.0,
                                    bottom: 16),
                                child: new Text('Learning',
                                    style: AppCss.blue18semibold,
                                    textAlign: TextAlign.left),
                              )),
                            ),
                          ),

                          InkWell(
                            onTap: () => {},
                            child: new Container(
                              margin: EdgeInsets.only(top: 9),
                              height: 62.0,
                              decoration: BoxDecoration(
                                color: AppColors.PRIMARY_COLOR,
                                borderRadius: new BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.SHADOWCOLOR,
                                      spreadRadius: 0,
                                      blurRadius: 7,
                                      offset: Offset(0, 4))
                                ],
                              ),
                              child: new Center(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0,
                                            left: 20,
                                            right: 20.0,
                                            bottom: 19),
                                        child: new Text('Mind Practice',
                                            style: AppCss.blue18semibold,
                                            textAlign: TextAlign.left),
                                      ))),
                            ),
                          ),

                          InkWell(
                            onTap: () => {},
                            child: new Container(
                              margin: EdgeInsets.only(top: 9),
                              height: 62.0,
                              decoration: BoxDecoration(
                                color: AppColors.PRIMARY_COLOR,
                                borderRadius: new BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.SHADOWCOLOR,
                                      spreadRadius: 0,
                                      blurRadius: 7,
                                      offset: Offset(0, 4))
                                ],
                              ),
                              child: new Center(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0,
                                            left: 20,
                                            right: 20.0,
                                            bottom: 19),
                                        child: new Text('Body Practice',
                                            style: AppCss.blue18semibold,
                                            textAlign: TextAlign.left),
                                      ))),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(new MaterialPageRoute(
                                      settings: RouteSettings(name: url),
                                      builder: (context) => new Post(
                                            topicId: posttopicId!,
                                          )));
                            },
                            child: new Container(
                              margin: EdgeInsets.only(top: 9, bottom: 40),
                              height: 62.0,
                              decoration: BoxDecoration(
                                color: AppColors.PRIMARY_COLOR,
                                borderRadius: new BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.SHADOWCOLOR,
                                      spreadRadius: 0,
                                      blurRadius: 7,
                                      offset: Offset(0, 4))
                                ],
                              ),
                              child: new Center(
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0,
                                            left: 20,
                                            right: 20.0,
                                            bottom: 19),
                                        child: new Text('Community',
                                            style: AppCss.blue18semibold,
                                            textAlign: TextAlign.left),
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
