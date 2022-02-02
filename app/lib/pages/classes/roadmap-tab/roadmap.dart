import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/classes/class-details.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/class.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Roadmap extends StatefulWidget {
  const Roadmap({Key? key}) : super(key: key);
  @override
  _RoadmapState createState() => _RoadmapState();
}

class _RoadmapState extends State<Roadmap> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var classList = [];
  late String? classTitle;
  late String? weekNumber;
  late String? description;
  late String? classIds;

  @override
  void initState() {
    checkLoginToken(context);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loader(context, _keyLoader));
    allClasses();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<void> allClasses() async {
    try {
      final data = await getClassList(<String, dynamic>{});
      if ((data["data"]?.isNotEmpty ?? true)) {
        if (data['status'] == "success") {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
            classList = data['data']['classes'];
          });
        } else {
          if (data['is_valid'] == false) {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
            Navigator.pushNamed(context, '/signin');
          } else {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
            errortoast(data['msg']);
          }
        }
      } else {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
      Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(builder: (context, constraints) {
            return Container(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 375,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: classList.isEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: 150,
                                      bottom: 150,
                                      left: 40,
                                      right: 40),
                                  child: Text(
                                    "No list yet.",
                                    style: AppCss.grey12medium,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                      top: 8.0,
                                      left: 20,
                                      right: 20,
                                      bottom: 30),
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext context,
                                            int index) =>
                                        Container(
                                            margin: EdgeInsets.only(bottom: 0)),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: classList.length,
                                    itemBuilder: (context, index) {
                                      classIds = classList[index]['class_id'];
                                      classTitle = classList[index]['title'];
                                      weekNumber =
                                          classList[index]['week_number'];
                                      description =
                                          classList[index]['description'];
                                      return Column(children: [
                                        (classList[index]['class_status'] ==
                                                "lock")
                                            ? Opacity(
                                                opacity: 0.5,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20, bottom: 21),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .PRIMARY_COLOR,
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(12.0),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: AppColors
                                                                .SHADOWCOLOR,
                                                            blurRadius: 3.0,
                                                            offset:
                                                                Offset(0, 3)),
                                                      ]),
                                                  child: Column(children: [
                                                    ListTile(
                                                      minLeadingWidth: 0,
                                                      horizontalTitleGap: 0.0,
                                                      isThreeLine: true,
                                                      dense: true,
                                                      title: (weekNumber !=
                                                              null)
                                                          ? Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 13,
                                                                      bottom:
                                                                          4),
                                                              child: Text(
                                                                  "Class " +
                                                                      classList[
                                                                              index]
                                                                          [
                                                                          'week_number']!,
                                                                  style: AppCss
                                                                      .mediumgrey10bold))
                                                          : Container(),
                                                      subtitle: (classTitle !=
                                                              null)
                                                          ? Text(classTitle!,
                                                              style: AppCss
                                                                  .blue16semibold)
                                                          : Container(),
                                                      trailing: Icon(
                                                          GeminiIcon.lock,
                                                          size: 19),
                                                    ),
                                                    (description != null)
                                                        ? Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 4,
                                                                    left: 18,
                                                                    right: 20,
                                                                    bottom: 20),
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                                description!,
                                                                style: AppCss
                                                                    .grey12regular))
                                                        : Container(),
                                                  ]),
                                                ),
                                              )
                                            : Stack(children: [
                                                new Positioned(
                                                  top: 0.0,
                                                  bottom: 0.0,
                                                  left: 5.0,
                                                  child: new Container(
                                                    height: height,
                                                    width: 1.5,
                                                    color:
                                                        AppColors.TRANSPARENT,
                                                  ),
                                                ),
                                                new Positioned(
                                                  top: 0,
                                                  left: 1.0,
                                                  child: new Container(
                                                    height: 10.0,
                                                    width: 10.0,
                                                    decoration:
                                                        new BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: AppColors
                                                                .DEEP_GREEN),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20, bottom: 21),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10.0),
                                                      color: AppColors
                                                          .PRIMARY_COLOR,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: AppColors
                                                                .SHADOWCOLOR,
                                                            spreadRadius: 0,
                                                            blurRadius: 3,
                                                            offset:
                                                                Offset(0, 3))
                                                      ],
                                                    ),
                                                    child: Column(children: [
                                                      ListTile(
                                                        minLeadingWidth: 0,
                                                        horizontalTitleGap: 0.0,
                                                        isThreeLine: true,
                                                        dense: true,
                                                        title: (weekNumber !=
                                                                null)
                                                            ? Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 13,
                                                                        bottom:
                                                                            4),
                                                                child: Text(
                                                                    "Class " +
                                                                        classList[index]
                                                                            [
                                                                            'week_number']!,
                                                                    style: AppCss
                                                                        .mediumgrey10bold))
                                                            : Container(),
                                                        subtitle: (classTitle !=
                                                                null)
                                                            ? Text(classTitle!,
                                                                style: AppCss
                                                                    .blue16semibold)
                                                            : Container(),
                                                        trailing: (classList[
                                                                        index][
                                                                    'class_status'] ==
                                                                "complete")
                                                            ? Material(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: AppColors
                                                                    .EMERALD_GREEN,
                                                                child: SizedBox(
                                                                  width: 20,
                                                                  height: 20,
                                                                  child: Icon(
                                                                      Icons
                                                                          .done,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 16),
                                                                ),
                                                              )
                                                            : CircularStepProgressIndicator(
                                                                totalSteps: 2,
                                                                currentStep: 1,
                                                                stepSize: 5,
                                                                selectedColor:
                                                                    Color(
                                                                        0xFF5FB852),
                                                                unselectedColor:
                                                                    AppColors
                                                                        .TRANSPARENT,
                                                                padding: 0,
                                                                width: 22,
                                                                height: 22,
                                                                selectedStepSize:
                                                                    3,
                                                                roundedCap:
                                                                    (_, __) =>
                                                                        true,
                                                              ),
                                                        onTap: () {
                                                          var classId = isVarEmpty(
                                                              classList[index]
                                                                  ['class_id']);
                                                          var week = isVarEmpty(
                                                              classList[index][
                                                                  'week_number']);
                                                          var url =
                                                              "class-details/$classId";
                                                          Navigator.of(context).pushReplacement(
                                                              new MaterialPageRoute(
                                                                  settings:
                                                                      RouteSettings(
                                                                          name:
                                                                              url),
                                                                  builder:
                                                                      (context) =>
                                                                          new ClasseDetails(
                                                                            classId:
                                                                                classId,
                                                                            weekNumber:
                                                                                week,
                                                                          )));
                                                        },
                                                      ),
                                                      (description != "")
                                                          ? Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 4,
                                                                      left: 18,
                                                                      right:
                                                                          20),
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                  isVarEmpty(
                                                                          description)
                                                                      .toString(),
                                                                  style: AppCss
                                                                      .grey12regular))
                                                          : Container(),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 8,
                                                            left: 18,
                                                            right: 20),
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              SvgPicture.asset(
                                                                  "assets/images/icons/classes-icon/learning-icon/learning.svg",
                                                                  width: 18,
                                                                  height: 18),
                                                              SizedBox(
                                                                  width: 7),
                                                              SvgPicture.asset(
                                                                  "assets/images/icons/classes-icon/meditation_pose/meditation.svg",
                                                                  width: 15.5,
                                                                  height: 21),
                                                              SizedBox(
                                                                  width: 7),
                                                              SvgPicture.asset(
                                                                  "assets/images/icons/classes-icon/practice-icon/practice.svg",
                                                                  width: 18,
                                                                  height: 16),
                                                              SizedBox(
                                                                  width: 7),
                                                              SvgPicture.asset(
                                                                  "assets/images/icons/classes-icon/community-icon/community.svg",
                                                                  width: 18.59,
                                                                  height: 18),
                                                              SizedBox(
                                                                  width: 7),
                                                              SvgPicture.asset(
                                                                  "assets/images/icons/classes-icon/journal-icon/journal.svg",
                                                                  width: 15.5,
                                                                  height: 18),
                                                            ]),
                                                      ),
                                                      (classList[index][
                                                                  'class_status'] ==
                                                              "complete")
                                                          ? Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 16,
                                                                      left: 15,
                                                                      bottom:
                                                                          20,
                                                                      right:
                                                                          15),
                                                              child: buttion(
                                                                  btnwidth =
                                                                      295,
                                                                  btnheight =
                                                                      36,
                                                                  btntext = 'COMPLETE CLASS ' +
                                                                      classList[
                                                                              index]
                                                                          [
                                                                          'week_number']!,
                                                                  AppCss
                                                                      .blue13bold,
                                                                  AppColors
                                                                      .PALE_BLUE,
                                                                  btntypesubmit =
                                                                      true, () {
                                                                var classId = isVarEmpty(
                                                                    classList[
                                                                            index]
                                                                        [
                                                                        'class_id']);
                                                                var week = isVarEmpty(
                                                                    classList[
                                                                            index]
                                                                        [
                                                                        'week_number']);
                                                                var url =
                                                                    "class-details/$classId";
                                                                Navigator.of(context).pushReplacement(
                                                                    new MaterialPageRoute(
                                                                        settings: RouteSettings(
                                                                            name:
                                                                                url),
                                                                        builder: (context) =>
                                                                            new ClasseDetails(
                                                                              classId: classId,
                                                                              weekNumber: week,
                                                                            )));
                                                              }, 9, 9, 57, 57,
                                                                  context),
                                                            )
                                                          : Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 16,
                                                                      left: 15,
                                                                      bottom:
                                                                          20,
                                                                      right:
                                                                          15),
                                                              child: Container(
                                                                width: 295,
                                                                height: 36,
                                                                child: Material(
                                                                  shape: RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                          color: AppColors
                                                                              .DEEP_BLUE,
                                                                          width:
                                                                              2,
                                                                          style: BorderStyle
                                                                              .solid),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50)),
                                                                  color: AppColors
                                                                      .PRIMARY_COLOR,
                                                                  child:
                                                                      MaterialButton(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            1,
                                                                            5,
                                                                            1,
                                                                            4),
                                                                    onPressed:
                                                                        () {
                                                                      var classId =
                                                                          isVarEmpty(classList[index]
                                                                              [
                                                                              'class_id']);
                                                                      var url =
                                                                          "class-details/$classId";
                                                                      Navigator.of(context).pushReplacement(new MaterialPageRoute(
                                                                          settings: RouteSettings(
                                                                              name:
                                                                                  url),
                                                                          builder: (context) =>
                                                                              new ClasseDetails(classId: classId)));
                                                                    },
                                                                    textColor:
                                                                        AppColors
                                                                            .DEEP_BLUE,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                            "REVIEW CLASS " +
                                                                                classList[index]['week_number']!,
                                                                            style: AppCss.blue13bold),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    ]),
                                                  ),
                                                ),
                                              ])
                                      ]);
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    ]);
  }
}
