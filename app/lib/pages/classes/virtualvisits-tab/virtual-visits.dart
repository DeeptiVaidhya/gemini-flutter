import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';
import 'package:localstorage/localstorage.dart';
import 'package:url_launcher/url_launcher.dart';

class VirtualVisits extends StatefulWidget {
  @override
  _VirtualVisitsState createState() => _VirtualVisitsState();
}

class _VirtualVisitsState extends State<VirtualVisits> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var currentSelectedValue;
  var virtualVisitsList = [];
  var sum = 1;
  late String? classId;
  var note;
  var leaders;
  var teleconfUrl;

  @override
  void initState() {
    checkLoginToken(context);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loader(context, _keyLoader));
    getVirtualVisitsData();
    super.initState();
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final LocalStorage storage = new LocalStorage('gemini');

  Future<void> getVirtualVisitsData() async {
    try {
      final data = await getVirtualVisits(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          virtualVisitsList = data['data']['visits'];
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: Container(
              width: width,
              height: height,
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 375,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 20),
                          child: virtualVisitsList.isEmpty
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
                              : ListView.separated(
                                  separatorBuilder: (BuildContext context,
                                          int index) =>
                                      Container(
                                          margin: EdgeInsets.only(bottom: 16)),
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: virtualVisitsList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.PRIMARY_COLOR,
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.SHADOWCOLOR,
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              offset: Offset(0, 4))
                                        ],
                                      ),
                                      child: ClipPath(
                                        clipper: ShapeBorderClipper(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        child: Column(children: <Widget>[
                                          ListTile(
                                            contentPadding: EdgeInsets.only(
                                                top: 20.0, left: 20.0),
                                            leading: SvgPicture.asset(
                                                "assets/images/group-visit/group-visit.svg",
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.fill),
                                            title: Column(
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Virtual visit",
                                                        style: AppCss
                                                            .mediumgrey10bold),
                                                    Spacer(),
                                                    Image.asset(
                                                        "assets/images/zoom.png")
                                                  ],
                                                ),
                                                SizedBox(height: 6),
                                                (virtualVisitsList[index][
                                                            'is_current_week'] ==
                                                        true)
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                            Container(
                                                              width: 85,
                                                              height: 19,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 4,
                                                                        bottom:
                                                                            3,
                                                                        left: 6,
                                                                        right:
                                                                            6),
                                                                    child: Text(
                                                                        "Visit in progress",
                                                                        style: AppCss
                                                                            .white9semibold),
                                                                  )
                                                                ],
                                                              ),
                                                              color:
                                                                  AppColors.RED,
                                                            ),
                                                            SizedBox(width: 6),
                                                            Text.rich(TextSpan(
                                                                text:
                                                                    "Finishes in: ",
                                                                style: AppCss
                                                                    .red9light,
                                                                children: <
                                                                    InlineSpan>[
                                                                  TextSpan(
                                                                    text:
                                                                        "30 mins",
                                                                    style: AppCss
                                                                        .red9semibold,
                                                                  )
                                                                ])),
                                                          ])
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left: 3,
                                                                      top: 10,
                                                                      right:
                                                                          120.0),
                                                                  child: Text(
                                                                      "Upcoming visit ",
                                                                      style: AppCss
                                                                          .green10semibold),
                                                                ),
                                                              ],
                                                            ),
                                                          ]),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              alignment: Alignment.topLeft,
                                              margin: const EdgeInsets.only(
                                                  left: 79,
                                                  right: 36,
                                                  bottom: 5.0),
                                              child: Text(
                                                "Chronic Pain - Group A",
                                                style: AppCss.blue16semibold,
                                              )),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.only(
                                                left: 79, right: 36),
                                            child: Text.rich(TextSpan(
                                                text: "Date : ",
                                                style: AppCss.grey12semibold,
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: (virtualVisitsList[
                                                                    index][
                                                                'visit_date'] !=
                                                            null)
                                                        ? virtualVisitsList[
                                                            index]['visit_date']
                                                        : "Not available",
                                                    style: AppCss.grey12regular,
                                                  )
                                                ])),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.only(
                                                left: 79, right: 36),
                                            child: Text.rich(TextSpan(
                                                text: "Time : ",
                                                style: AppCss.grey12semibold,
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: (virtualVisitsList[
                                                                    index][
                                                                'visit_time'] !=
                                                            null)
                                                        ? virtualVisitsList[
                                                            index]['visit_time']
                                                        : "Not available",
                                                    style: AppCss.grey12regular,
                                                  )
                                                ])),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.only(
                                                left: 79, right: 36),
                                            child: Text.rich(TextSpan(
                                                text: "Host(s): ",
                                                style: AppCss.blue12semibold,
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: isVarEmpty(
                                                            virtualVisitsList[
                                                                    index]
                                                                ['leaders'])
                                                        .toString(),
                                                    style: AppCss.grey12regular,
                                                  )
                                                ])),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.only(
                                                left: 79, right: 36),
                                            child: Text.rich(TextSpan(
                                                text: "Participants: ",
                                                style: AppCss.grey12semibold,
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: isVarEmpty(
                                                            virtualVisitsList[
                                                                    index][
                                                                'total_participants'])
                                                        .toString(),
                                                    style: AppCss.grey12regular,
                                                  )
                                                ])),
                                          ),
                                          (virtualVisitsList[index]
                                                      ['is_current_week'] ==
                                                  true)
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 16,
                                                      left: 15,
                                                      bottom: 20,
                                                      right: 15),
                                                  child: Container(
                                                    width: 295,
                                                    height: 36,
                                                    child: Material(
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: AppColors
                                                                  .LIGHT_ORANGE,
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      color: AppColors
                                                          .LIGHT_ORANGE,
                                                      child: MaterialButton(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                1, 5, 1, 4),
                                                        onPressed: () {
                                                          _launchURL(
                                                              virtualVisitsList[
                                                                      index][
                                                                  'teleconf_url']);
                                                        },
                                                        textColor:
                                                            AppColors.DEEP_BLUE,
                                                        child: Text(
                                                            "JOIN VISIT NOW"
                                                                .toUpperCase(),
                                                            style: AppCss
                                                                .blue13bold),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 16,
                                                          left: 15,
                                                          bottom: 20,
                                                          right: 15),
                                                      child: Container(
                                                        width: 295,
                                                        height: 36,
                                                        child: Material(
                                                          shape: RoundedRectangleBorder(
                                                              side: BorderSide(
                                                                  color: AppColors
                                                                      .PALE_BLUE,
                                                                  width: 1,
                                                                  style:
                                                                      BorderStyle
                                                                          .solid),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          color: AppColors
                                                              .PALE_BLUE,
                                                          child: MaterialButton(
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    1, 5, 1, 4),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      "/start-previsit");
                                                            },
                                                            textColor: AppColors
                                                                .PALE_BLUE,
                                                            child: Text(
                                                                "Complete pre-visit questionnaire"
                                                                    .toUpperCase(),
                                                                style: AppCss
                                                                    .blue13bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 295,
                                                      height: 40,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 30,
                                                              left: 20,
                                                              right: 20),
                                                      child: Material(
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: AppColors
                                                                    .DEEP_BLUE,
                                                                width: 1,
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        color: AppColors
                                                            .PRIMARY_COLOR,
                                                        child: MaterialButton(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  57, 5, 56, 4),
                                                          onPressed: () {},
                                                          textColor: AppColors
                                                              .DEEP_BLUE,
                                                          child: Text(
                                                              "See visit invite"
                                                                  .toUpperCase(),
                                                              style: AppCss
                                                                  .blue13bold),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                        ]),
                                      ),
                                    );
                                  },
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
