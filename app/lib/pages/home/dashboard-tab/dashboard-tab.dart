import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/classes/class-details.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/post.dart';
import 'package:gemini/pages/journal/journal.dart';
import 'package:gemini/pages/learning-topic/learning-topic.dart';
import 'package:gemini/pages/practice/body-practice/body-practice.dart';
import 'package:gemini/pages/practice/mind-practice/mind-practice.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';
import 'package:localstorage/localstorage.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardTab extends StatefulWidget {
  @override
  _DashboardTabState createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  final LocalStorage storage = new LocalStorage('gemini');
  final GlobalKey<State> _keyLoading = new GlobalKey<State>();
  var classList = [];
  var dataList;
  var practiceList = [];
  var postTopicList = [];
  var postTopicInstruction;
  var postTopicId;
  var classId;
  var classTitle;
  var totalParticipant;
  var note;
  var leaders;
  var teleconfUrl;
  var status;
  var classDescription;
  var classWeek;
  var visitDate;
  var visitTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loader(context, _keyLoading));
    this.getDashboard();
    // Future.delayed(Duration.zero, () {

    // });
  }

  Future<void> getDashboard() async {
    try {
      final data = await getDashboardDetails(<String, dynamic>{});
      if ((data["data"]?.isNotEmpty ?? true)) {
        if (data['status'] == "success") {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
            classList = data['data']['class_list'];
            dataList = data['data'];
            practiceList = data['data']['current_class_detail']
                ['class_activity']['practices'];
            postTopicList = data['data']['current_class_detail']['post_topics'];
            classId = data['data']['current_class_detail']['class_id'];
            classTitle = data['data']['current_class_detail']['title'];
            classWeek = data['data']['current_class_detail']['week_number'];
            classDescription =
                data['data']['current_class_detail']['description'];
            totalParticipant =
                data['data']['group_detail']['total_participants'];
            leaders = data['data']['group_detail']['leaders'];
            visitDate = data['data']['group_detail']['visit_date'];
            visitTime = data['data']['group_detail']['visit_time'];
            note = data['data']['group_detail']['note'];
            teleconfUrl = data['data']['group_detail']['teleconf_url'];
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
            Navigator.pushNamed(context, '/home');
          }
        }
      } else {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        });
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 375,
                  ),
                  child: Column(
                    children: <Widget>[
                      (classList.isEmpty)
                          ? Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: (storage.getItem('name') != null)
                                      ? Text(
                                          'Welcome, ' +
                                              storage.getItem('name') +
                                              '!',
                                          style: AppCss.blue20semibold)
                                      : Text('Welcome,',
                                          style: AppCss.blue20semibold),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 70.0,
                                    child: ListView(
                                        physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: new BoxDecoration(
                                                color: AppColors.LIME_GREEN
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: new BoxDecoration(
                                                color: AppColors.LIME_GREEN
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              decoration: new BoxDecoration(
                                                color: AppColors.LIME_GREEN
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                                width: 55,
                                                height: 60,
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                decoration: new BoxDecoration(
                                                  color:
                                                      AppColors.DARK_LIME_GREEN,
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              left: 8,
                                                              right: 8),
                                                      child: Text(
                                                          "Class".toUpperCase(),
                                                          style:
                                                              AppCss.white8bold,
                                                          textAlign:
                                                              TextAlign.center),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 19,
                                                              bottom: 2),
                                                      child: Text("5",
                                                          style: AppCss
                                                              .white26bold,
                                                          textAlign:
                                                              TextAlign.center),
                                                    )
                                                  ],
                                                )),
                                          ),
                                          Center(
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  width: 50,
                                                  height: 50,
                                                  decoration: new BoxDecoration(
                                                      color: AppColors
                                                          .PRIMARY_COLOR
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .DEEP_GREEN)),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8,
                                                                left: 8,
                                                                right: 8),
                                                        child: Text("Class",
                                                            style: AppCss
                                                                .green6bold,
                                                            textAlign: TextAlign
                                                                .center),
                                                      ),
                                                      Container(
                                                        child: Text("6",
                                                            style: AppCss
                                                                .green19bold,
                                                            textAlign: TextAlign
                                                                .center),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Center(
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  width: 50,
                                                  height: 50,
                                                  decoration: new BoxDecoration(
                                                      color: AppColors
                                                          .PRIMARY_COLOR
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .DEEP_GREEN)),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 8,
                                                                left: 8,
                                                                right: 8),
                                                        child: Text("Class",
                                                            style: AppCss
                                                                .green6bold,
                                                            textAlign: TextAlign
                                                                .center),
                                                      ),
                                                      Container(
                                                        child: Text("8",
                                                            style: AppCss
                                                                .green19bold,
                                                            textAlign: TextAlign
                                                                .center),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Center(
                                            child: Opacity(
                                              opacity: 0.5,
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  width: 50,
                                                  height: 50,
                                                  decoration: new BoxDecoration(
                                                      color: AppColors
                                                          .PRIMARY_COLOR
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .DEEP_GREEN)),
                                                  child: Container(
                                                    child: Image.asset(
                                                        'assets/images/icons/navbar-icon/green-dots.png'),
                                                  )),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ),
                                // Container(
                                //   margin: const EdgeInsets.only(
                                //       top: 15, bottom: 11),
                                //   child: Text('Lorem ipsum dolor,',
                                //       style: AppCss.blue18semibold),
                                // ),
                                // Container(
                                //   margin: const EdgeInsets.only(
                                //       left: 30, right: 30, bottom: 11),
                                //   child: Text(
                                //       'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut,',
                                //       style: AppCss.grey12regular,
                                //       textAlign: TextAlign.center),
                                // ),
                                Container(
                                    margin: const EdgeInsets.only(top: 120),
                                    child: buttion(
                                        btnwidth = 215,
                                        btnheight = 44,
                                        btntext = 'GET STARTED',
                                        AppCss.blue14bold,
                                        AppColors.LIGHT_ORANGE,
                                        btntypesubmit = true, () {
                                      Navigator.pushNamed(
                                          context, '/mental-checkin');
                                    }, 12, 12, 30, 29, context)),
                              ],
                            )
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: (storage.getItem('name') != null)
                                      ? Text(
                                          'Welcome back, ' +
                                              storage.getItem('name') +
                                              '!',
                                          style: AppCss.blue20semibold)
                                      : Text('Welcome back,',
                                          style: AppCss.blue20semibold),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 25.0, right: 24.0, bottom: 11),
                                  child: Text.rich(
                                    TextSpan(
                                        text: "You are currently on ",
                                        style: AppCss.grey12regular,
                                        children: <InlineSpan>[
                                          (classWeek != null)
                                              ? TextSpan(
                                                  text: "Class $classWeek",
                                                  style: AppCss.blue12semibold,
                                                )
                                              : TextSpan(
                                                  text: "Class",
                                                  style: AppCss.blue12semibold,
                                                ),
                                          TextSpan(
                                            text: " but you still have some ",
                                            style: AppCss.grey12regular,
                                          ),
                                          TextSpan(
                                            text:
                                                "activities to finish for previous classes. See ",
                                            style: AppCss.grey12regular,
                                          ),
                                          WidgetSpan(
                                              child: Container(
                                            width: 12.5,
                                            height: 12.5,
                                            margin:
                                                EdgeInsets.only(bottom: 2.5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.BRIGHT_RED,
                                            ),
                                            child: Icon(
                                                GeminiIcon.icon_exclamation,
                                                size: 9,
                                                color: AppColors.PRIMARY_COLOR),
                                          )),
                                          TextSpan(
                                            text: " below.",
                                            style: AppCss.grey12regular,
                                          )
                                        ]),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                classList.isEmpty
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: 70.0,
                                          child: ListView(
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: AppColors
                                                          .LIME_GREEN
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: AppColors
                                                          .LIME_GREEN
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: AppColors
                                                          .LIME_GREEN
                                                          .withOpacity(0.3),
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(10),
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Container(
                                                      width: 55,
                                                      height: 60,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: AppColors
                                                            .DARK_LIME_GREEN,
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5,
                                                                    left: 8,
                                                                    right: 8),
                                                            child: Text(
                                                                "Class"
                                                                    .toUpperCase(),
                                                                style: AppCss
                                                                    .white8bold,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20,
                                                                    right: 19,
                                                                    bottom: 2),
                                                            child: Text("5",
                                                                style: AppCss
                                                                    .white26bold,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                Center(
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      width: 50,
                                                      height: 50,
                                                      decoration: new BoxDecoration(
                                                          color: AppColors
                                                              .PRIMARY_COLOR
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .DEEP_GREEN)),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8,
                                                                    left: 8,
                                                                    right: 8),
                                                            child: Text("Class",
                                                                style: AppCss
                                                                    .green6bold,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                          Container(
                                                            child: Text("6",
                                                                style: AppCss
                                                                    .green19bold,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                Center(
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      width: 50,
                                                      height: 50,
                                                      decoration: new BoxDecoration(
                                                          color: AppColors
                                                              .PRIMARY_COLOR
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .DEEP_GREEN)),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 8,
                                                                    left: 8,
                                                                    right: 8),
                                                            child: Text("Class",
                                                                style: AppCss
                                                                    .green6bold,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          ),
                                                          Container(
                                                            child: Text("8",
                                                                style: AppCss
                                                                    .green19bold,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                Center(
                                                  child: Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      width: 50,
                                                      height: 50,
                                                      decoration: new BoxDecoration(
                                                          color: AppColors
                                                              .PRIMARY_COLOR
                                                              .withOpacity(0.5),
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .DEEP_GREEN)),
                                                      child: Container(
                                                        child: Image.asset(
                                                            'assets/images/icons/navbar-icon/green-dots.png'),
                                                      )),
                                                ),
                                              ]),
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 55,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: classList.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Stack(
                                                        children: <Widget>[
                                                          (classList[index][
                                                                      'class_status'] ==
                                                                  "complete")
                                                              ? Center(
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      var classId =
                                                                          isVarEmpty(classList[index]
                                                                              [
                                                                              'class_id']);
                                                                      var week =
                                                                          isVarEmpty(classList[index]
                                                                              [
                                                                              'week_number']);
                                                                      var url =
                                                                          "class-details/$classId";
                                                                      Navigator.of(context).pushReplacement(new MaterialPageRoute(
                                                                          settings: RouteSettings(name: url),
                                                                          builder: (context) => new ClasseDetails(
                                                                                classId: classId,
                                                                                weekNumber: week,
                                                                              )));
                                                                    },
                                                                    child: Container(
                                                                        width: 55,
                                                                        height: 54,
                                                                        margin: const EdgeInsets.only(right: 10),
                                                                        decoration: new BoxDecoration(
                                                                          color:
                                                                              AppColors.DARK_LIME_GREEN,
                                                                          borderRadius:
                                                                              new BorderRadius.circular(10),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                color: AppColors.SHADOWCOLOR,
                                                                                spreadRadius: 0,
                                                                                blurRadius: 3,
                                                                                offset: Offset(0, 3))
                                                                          ],
                                                                        ),
                                                                        child: Column(
                                                                          children: [
                                                                            Container(
                                                                              padding: const EdgeInsets.only(top: 3),
                                                                              child: Text("Class".toUpperCase(), style: AppCss.white8bold, textAlign: TextAlign.center),
                                                                            ),
                                                                            Text(isVarEmpty(classList[index]['week_number']).toString(),
                                                                                style: AppCss.white26bold,
                                                                                textAlign: TextAlign.center)
                                                                          ],
                                                                        )),
                                                                  ),
                                                                )
                                                              : ((classList[index]
                                                                          [
                                                                          'class_status'] ==
                                                                      "lock")
                                                                  ? Opacity(
                                                                      opacity:
                                                                          0.5,
                                                                      child: Container(
                                                                          margin: const EdgeInsets.only(right: 10),
                                                                          width: 45,
                                                                          height: 45,
                                                                          decoration: new BoxDecoration(color: AppColors.PRIMARY_COLOR.withOpacity(0.5), borderRadius: new BorderRadius.circular(10), border: Border.all(color: AppColors.DEEP_GREEN)),
                                                                          child: Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 1, left: 6, right: 6, bottom: 3),
                                                                                child: Text("Class".toUpperCase(), style: AppCss.green6bold, textAlign: TextAlign.center),
                                                                              ),
                                                                              Text(isVarEmpty(classList[index]['week_number']).toString(), style: AppCss.green19bold, textAlign: TextAlign.center)
                                                                            ],
                                                                          )),
                                                                    )
                                                                  : Stack(
                                                                      children: [
                                                                        Container(
                                                                            margin:
                                                                                const EdgeInsets.only(right: 10),
                                                                            width: 45,
                                                                            height: 45,
                                                                            decoration: new BoxDecoration(
                                                                              color: AppColors.PRIMARY_COLOR,
                                                                              borderRadius: new BorderRadius.circular(10),
                                                                              border: Border.all(color: AppColors.DEEP_GREEN),
                                                                              boxShadow: [
                                                                                BoxShadow(color: AppColors.SHADOWCOLOR, spreadRadius: 0, blurRadius: 3, offset: Offset(0, 3))
                                                                              ],
                                                                            ),
                                                                            child: Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(top: 2, left: 6, right: 6, bottom: 2),
                                                                                  child: Text("Class".toUpperCase(), style: AppCss.green6bold),
                                                                                ),
                                                                                Text(isVarEmpty(classList[index]['week_number']).toString(), style: AppCss.green19bold)
                                                                              ],
                                                                            )),
                                                                        Positioned(
                                                                          bottom:
                                                                              33.0,
                                                                          right:
                                                                              7.0,
                                                                          child:
                                                                              Material(
                                                                            borderRadius:
                                                                                BorderRadius.circular(100),
                                                                            color:
                                                                                AppColors.EMERALD_GREEN,
                                                                            child:
                                                                                SizedBox(
                                                                              width: 12,
                                                                              height: 12,
                                                                              child: Icon(Icons.done, color: Colors.white, size: 10),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ))
                                                        ],
                                                      ),
                                                    ]);
                                              }),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 18, left: 25, right: 24, bottom: 4),
                                  child: Text(
                                      '“You may not always have a comfortable life and you will not always be able to solve all of the world’s problems at once but don’t ever underestimate the importance you can have because history has shown us that courage can be contagious and hope can take on a life of its own.”',
                                      style: AppCss.blue11bolditalic,
                                      textAlign: TextAlign.center),
                                ),
                                Text('Michelle Obama',
                                    style: AppCss.blue10semibold),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                new Text("Virtual visit",
                                                    style: AppCss
                                                        .mediumgrey10bold),
                                                Spacer(),
                                                Image.asset(
                                                    "assets/images/zoom.png")
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 85,
                                                    height: 19,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 2,
                                                                  bottom: 2,
                                                                  left: 6,
                                                                  right: 6),
                                                          child: (visitDate !=
                                                                  null)
                                                              ? Text(
                                                                  "Visit in progress",
                                                                  style: AppCss
                                                                      .white9semibold)
                                                              : Container(),
                                                        )
                                                      ],
                                                    ),
                                                    color: (visitDate != null)
                                                        ? AppColors.RED
                                                        : AppColors
                                                            .PRIMARY_COLOR,
                                                  ),
                                                  SizedBox(width: 6),
                                                  // Text.rich(TextSpan(
                                                  //     text: "Finishes in: ",
                                                  //     style: AppCss.red9light,
                                                  //     children: <InlineSpan>[
                                                  //       TextSpan(
                                                  //         text: "N/A",
                                                  //         style: AppCss
                                                  //             .red9semibold,
                                                  //       )
                                                  //     ])
                                                  //),
                                                ])
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //     alignment: Alignment.topLeft,
                                      //     margin: const EdgeInsets.only(
                                      //         left: 79, right: 36, bottom: 5.0),
                                      //     child: Text(
                                      //       "Chronic Pain - Group A",
                                      //       style: AppCss.blue16semibold,
                                      //     )),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.only(
                                            left: 79, right: 36),
                                        child: Text.rich(TextSpan(
                                            text: "Date : ",
                                            style: AppCss.grey12semibold,
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: (visitDate != null)
                                                    ? visitDate['visit_date']
                                                    : "N/A",
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
                                                text: (visitTime != null)
                                                    ? visitTime['visit_time']
                                                    : "N/A",
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
                                                text: (leaders != null)
                                                    ? leaders.toString()
                                                    : "N/A",
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
                                                text: (totalParticipant != null)
                                                    ? totalParticipant
                                                        .toString()
                                                    : "N/A",
                                                style: AppCss.grey12regular,
                                              )
                                            ])),
                                      ),
                                      Container(
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
                                                    color: AppColors.PALE_BLUE,
                                                    width: 1,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            color: AppColors.PALE_BLUE,
                                            child: MaterialButton(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      1, 5, 1, 4),
                                              onPressed: () {
                                                _launchURL(teleconfUrl);
                                              },
                                              textColor: AppColors.DEEP_BLUE,
                                              child: Text(
                                                  "JOIN VISIT NOW"
                                                      .toUpperCase(),
                                                  style: AppCss.blue13bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                                (classTitle != null)
                                    ? Column(
                                        children: [
                                          Container(
                                            width: 500,
                                            padding: EdgeInsets.only(
                                                left: 20, top: 32, bottom: 24),
                                            child: Text(
                                              "To Do : Current Module",
                                              textAlign: TextAlign.left,
                                              style: AppCss.blue18semibold,
                                            ),
                                          ),
                                          //learning topic
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                              color: AppColors.PRIMARY_COLOR,
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      12.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        AppColors.SHADOWCOLOR,
                                                    spreadRadius: 0,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 3))
                                              ],
                                            ),
                                            child: ClipPath(
                                              clipper: ShapeBorderClipper(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              child: Column(children: <Widget>[
                                                ListTile(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 20.0,
                                                          right: 20),
                                                  leading: SvgPicture.asset(
                                                      "assets/images/icons/learning/learning.svg",
                                                      width: 46,
                                                      height: 46),
                                                  title: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: Text(
                                                              "Learning",
                                                              style: AppCss
                                                                  .mediumgrey10bold)),
                                                    ],
                                                  ),
                                                  subtitle: Column(
                                                    children: [
                                                      Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  right: 10,
                                                                  bottom: 3),
                                                          child: Text(
                                                              isVarEmpty(
                                                                      classTitle)
                                                                  .toString(),
                                                              style: AppCss
                                                                  .blue16semibold)),
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Text(
                                                            isVarEmpty(
                                                                    classDescription)
                                                                .toString(),
                                                            style: AppCss
                                                                .grey12regular),
                                                      ),
                                                    ],
                                                  ),
                                                  trailing:
                                                      CircularStepProgressIndicator(
                                                    totalSteps: 2,
                                                    currentStep: 1,
                                                    stepSize: 5,
                                                    selectedColor:
                                                        Color(0xFF5FB852),
                                                    unselectedColor:
                                                        AppColors.TRANSPARENT,
                                                    padding: 0,
                                                    width: 22,
                                                    height: 22,
                                                    selectedStepSize: 3,
                                                    roundedCap: (_, __) => true,
                                                  ),
                                                ),
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
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      color:
                                                          AppColors.PALE_BLUE,
                                                      child: MaterialButton(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                1, 5, 1, 4),
                                                        onPressed: () {
                                                          var cId = isVarEmpty(
                                                              classId);
                                                          var url =
                                                              "/learning-topics/$cId";
                                                          Navigator.of(context).pushReplacement(
                                                              new MaterialPageRoute(
                                                                  settings:
                                                                      RouteSettings(
                                                                          name:
                                                                              url),
                                                                  builder:
                                                                      (context) =>
                                                                          new LearningTopic(
                                                                            classId:
                                                                                cId,
                                                                            type:
                                                                                "home",
                                                                          )));
                                                        },
                                                        textColor:
                                                            AppColors.DEEP_BLUE,
                                                        child: Text(
                                                            "Read learning topics"
                                                                .toUpperCase(),
                                                            style: AppCss
                                                                .blue13bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                                //practice list
                                practiceList.isEmpty
                                    ? Container()
                                    : ListView.separated(
                                        separatorBuilder: (BuildContext context,
                                                int index) =>
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 8)),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: practiceList.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 0,
                                                left: 15,
                                                right: 15,
                                                bottom: 16),
                                            decoration: BoxDecoration(
                                              color: AppColors.PRIMARY_COLOR,
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        AppColors.SHADOWCOLOR,
                                                    spreadRadius: 0,
                                                    blurRadius: 7,
                                                    offset: Offset(0, 4))
                                              ],
                                            ),
                                            child: ClipPath(
                                              clipper: ShapeBorderClipper(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              child: Column(children: <Widget>[
                                                (practiceList[index]['type'] ==
                                                        "body")
                                                    ? ListTile(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 10.0,
                                                                left: 20.0,
                                                                right: 20),
                                                        leading: SvgPicture.asset(
                                                            "assets/images/icons/body-scan/body-scan.svg",
                                                            width: 37.5,
                                                            height: 50,
                                                            fit: BoxFit.fill),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                              "Body Practice",
                                                              style: AppCss
                                                                  .mediumgrey10bold),
                                                        ),
                                                        subtitle: Column(
                                                          children: [
                                                            Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            3),
                                                                child: Text(
                                                                    isVarEmpty(practiceList[index]
                                                                            [
                                                                            'title'])
                                                                        .toString(),
                                                                    style: AppCss
                                                                        .blue16semibold)),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              child: Text(
                                                                  isVarEmpty(practiceList[
                                                                              index]
                                                                          [
                                                                          'description'])
                                                                      .toString(),
                                                                  style: AppCss
                                                                      .grey12regular),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing:
                                                            CircularStepProgressIndicator(
                                                          totalSteps: 2,
                                                          currentStep: 1,
                                                          stepSize: 5,
                                                          selectedColor:
                                                              Color(0xFF5FB852),
                                                          unselectedColor:
                                                              AppColors
                                                                  .TRANSPARENT,
                                                          padding: 0,
                                                          width: 22,
                                                          height: 22,
                                                          selectedStepSize: 3,
                                                          roundedCap: (_, __) =>
                                                              true,
                                                        ),
                                                      )
                                                    : ListTile(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 10.0,
                                                                left: 20.0,
                                                                right: 20),
                                                        leading: SvgPicture.asset(
                                                            "assets/images/icons/meditation/meditation.svg",
                                                            width: 37.5,
                                                            height: 50,
                                                            fit: BoxFit.fill),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                              "Mind Practice",
                                                              style: AppCss
                                                                  .mediumgrey10bold),
                                                        ),
                                                        subtitle: Column(
                                                          children: [
                                                            Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            3),
                                                                child: Text(
                                                                    isVarEmpty(practiceList[index]
                                                                            [
                                                                            'title'])
                                                                        .toString(),
                                                                    style: AppCss
                                                                        .blue16semibold)),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              child: Text(
                                                                  isVarEmpty(practiceList[
                                                                              index]
                                                                          [
                                                                          'description'])
                                                                      .toString(),
                                                                  style: AppCss
                                                                      .grey12regular),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing:
                                                            CircularStepProgressIndicator(
                                                          totalSteps: 2,
                                                          currentStep: 1,
                                                          stepSize: 5,
                                                          selectedColor:
                                                              Color(0xFF5FB852),
                                                          unselectedColor:
                                                              AppColors
                                                                  .TRANSPARENT,
                                                          padding: 0,
                                                          width: 22,
                                                          height: 22,
                                                          selectedStepSize: 3,
                                                          roundedCap: (_, __) =>
                                                              true,
                                                        ),
                                                      ),
                                                (practiceList[index]['type'] ==
                                                        "body")
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
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
                                                                    style: BorderStyle
                                                                        .solid),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            color: AppColors
                                                                .PALE_BLUE,
                                                            child:
                                                                MaterialButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      1,
                                                                      5,
                                                                      1,
                                                                      4),
                                                              onPressed: () {
                                                                var prId =
                                                                    practiceList[
                                                                            index]
                                                                        ['id']!;
                                                                var url =
                                                                    "/body-practice/$prId";
                                                                Navigator.of(context).pushReplacement(
                                                                    new MaterialPageRoute(
                                                                        settings: RouteSettings(
                                                                            name:
                                                                                url),
                                                                        builder: (context) =>
                                                                            new BodyPractice(
                                                                              practiceId: practiceList[index]['id'],
                                                                              type: "home",
                                                                            )));
                                                              },
                                                              textColor:
                                                                  AppColors
                                                                      .DEEP_BLUE,
                                                              child: Text(
                                                                  "Do body practice"
                                                                      .toUpperCase(),
                                                                  style: AppCss
                                                                      .blue13bold),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.only(
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
                                                                    style: BorderStyle
                                                                        .solid),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            color: AppColors
                                                                .PALE_BLUE,
                                                            child:
                                                                MaterialButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      1,
                                                                      5,
                                                                      1,
                                                                      4),
                                                              onPressed: () {
                                                                var prId =
                                                                    practiceList[
                                                                            index]
                                                                        ['id']!;
                                                                var url =
                                                                    "/mind-practice/$prId";
                                                                Navigator.of(context).pushReplacement(
                                                                    new MaterialPageRoute(
                                                                        settings: RouteSettings(
                                                                            name:
                                                                                url),
                                                                        builder: (context) =>
                                                                            new MindPractice(
                                                                              practiceId: practiceList[index]['id'],
                                                                              type: "home",
                                                                            )));
                                                              },
                                                              textColor:
                                                                  AppColors
                                                                      .DEEP_BLUE,
                                                              child: Text(
                                                                  "Do mind practice"
                                                                      .toUpperCase(),
                                                                  style: AppCss
                                                                      .blue13bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ]),
                                            ),
                                          );
                                        }),
                                //post community and journal
                                postTopicList.isEmpty
                                    ? Container()
                                    : ListView.separated(
                                        separatorBuilder: (BuildContext context,
                                                int index) =>
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 8)),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: postTopicList.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.only(
                                                top: 0,
                                                left: 15,
                                                right: 15,
                                                bottom: 16),
                                            decoration: BoxDecoration(
                                              color: AppColors.PRIMARY_COLOR,
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      12.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        AppColors.SHADOWCOLOR,
                                                    spreadRadius: 0,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 3))
                                              ],
                                            ),
                                            child: ClipPath(
                                              clipper: ShapeBorderClipper(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              child: Column(children: <Widget>[
                                                (postTopicList[index]['type'] ==
                                                        "community")
                                                    ? ListTile(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 10.0,
                                                                left: 20.0,
                                                                right: 20),
                                                        leading: SvgPicture.asset(
                                                            "assets/images/icons/community/community.svg",
                                                            width: 37.5,
                                                            height: 50,
                                                            fit: BoxFit.fill),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text(
                                                              "Community",
                                                              style: AppCss
                                                                  .mediumgrey10bold),
                                                        ),
                                                        subtitle: Column(
                                                          children: [
                                                            Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 1,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            3),
                                                                child: Text(
                                                                    isVarEmpty(postTopicList[index]
                                                                            [
                                                                            'title'])
                                                                        .toString(),
                                                                    style: AppCss
                                                                        .blue16semibold)),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 10,
                                                              ),
                                                              child: Text(
                                                                  isVarEmpty(postTopicList[
                                                                              index]
                                                                          [
                                                                          'instruction'])
                                                                      .toString(),
                                                                  style: AppCss
                                                                      .grey12regular),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing:
                                                            CircularStepProgressIndicator(
                                                          totalSteps: 2,
                                                          currentStep: 1,
                                                          stepSize: 5,
                                                          selectedColor:
                                                              Color(0xFF5FB852),
                                                          unselectedColor:
                                                              AppColors
                                                                  .TRANSPARENT,
                                                          padding: 0,
                                                          width: 22,
                                                          height: 22,
                                                          selectedStepSize: 3,
                                                          roundedCap: (_, __) =>
                                                              true,
                                                        ),
                                                      )
                                                    : ListTile(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 10.0,
                                                                left: 20.0,
                                                                right: 20),
                                                        leading: SvgPicture.asset(
                                                            "assets/images/icons/journal/journal.svg",
                                                            width: 37.5,
                                                            height: 50,
                                                            fit: BoxFit.fill),
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Text("Journal",
                                                              style: AppCss
                                                                  .mediumgrey10bold),
                                                        ),
                                                        subtitle: Column(
                                                          children: [
                                                            Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 1,
                                                                        right:
                                                                            10,
                                                                        bottom:
                                                                            3),
                                                                child: Text(
                                                                    isVarEmpty(postTopicList[index]
                                                                            [
                                                                            'title'])
                                                                        .toString(),
                                                                    style: AppCss
                                                                        .blue16semibold)),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                right: 10,
                                                              ),
                                                              child: Text(
                                                                  isVarEmpty(postTopicList[
                                                                              index]
                                                                          [
                                                                          'instruction'])
                                                                      .toString(),
                                                                  style: AppCss
                                                                      .grey12regular),
                                                            ),
                                                          ],
                                                        ),
                                                        trailing:
                                                            CircularStepProgressIndicator(
                                                          totalSteps: 2,
                                                          currentStep: 1,
                                                          stepSize: 5,
                                                          selectedColor:
                                                              Color(0xFF5FB852),
                                                          unselectedColor:
                                                              AppColors
                                                                  .TRANSPARENT,
                                                          padding: 0,
                                                          width: 22,
                                                          height: 22,
                                                          selectedStepSize: 3,
                                                          roundedCap: (_, __) =>
                                                              true,
                                                        ),
                                                      ),
                                                (postTopicList[index]['type'] ==
                                                        "community")
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
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
                                                                    style: BorderStyle
                                                                        .solid),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            color: AppColors
                                                                .PALE_BLUE,
                                                            child:
                                                                MaterialButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      1,
                                                                      5,
                                                                      1,
                                                                      4),
                                                              onPressed: () {
                                                                var postTopicid =
                                                                    isVarEmpty(postTopicList[
                                                                            index]
                                                                        ['id']);
                                                                var url =
                                                                    "/post/$postTopicid";
                                                                Navigator.of(context).pushReplacement(
                                                                    new MaterialPageRoute(
                                                                        settings: RouteSettings(
                                                                            name:
                                                                                url),
                                                                        builder: (context) =>
                                                                            new Post(
                                                                              topicId: postTopicid!,
                                                                            )));
                                                              },
                                                              textColor:
                                                                  AppColors
                                                                      .DEEP_BLUE,
                                                              child: Text(
                                                                  "Post in the community"
                                                                      .toUpperCase(),
                                                                  style: AppCss
                                                                      .blue13bold),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.only(
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
                                                                    style: BorderStyle
                                                                        .solid),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                            color: AppColors
                                                                .PALE_BLUE,
                                                            child:
                                                                MaterialButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      1,
                                                                      5,
                                                                      1,
                                                                      4),
                                                              onPressed: () {
                                                                var postId = isVarEmpty(
                                                                    postTopicList[
                                                                            index]
                                                                        ['id']);
                                                                var url =
                                                                    "/journal/$postId";
                                                                Navigator.of(context).pushReplacement(
                                                                    new MaterialPageRoute(
                                                                        settings: RouteSettings(
                                                                            name:
                                                                                url),
                                                                        builder: (context) =>
                                                                            new Journal(
                                                                              postId: postId!,
                                                                            )));
                                                              },
                                                              textColor:
                                                                  AppColors
                                                                      .DEEP_BLUE,
                                                              child: Text(
                                                                  "Do journal exercise"
                                                                      .toUpperCase(),
                                                                  style: AppCss
                                                                      .blue13bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ]),
                                            ),
                                          );
                                        }),
                                (classId != null)
                                    ? Column(
                                        children: [
                                          Container(
                                            width: 500,
                                            padding: EdgeInsets.only(
                                                left: 20, top: 31, bottom: 24),
                                            child: Text(
                                              "Still to Do : Module",
                                              textAlign: TextAlign.left,
                                              style: AppCss.blue18semibold,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                bottom: 50),
                                            decoration: BoxDecoration(
                                              color: AppColors.PRIMARY_COLOR,
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      12.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        AppColors.SHADOWCOLOR,
                                                    spreadRadius: 0,
                                                    blurRadius: 3,
                                                    offset: Offset(0, 3))
                                              ],
                                            ),
                                            child: ClipPath(
                                              clipper: ShapeBorderClipper(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20),
                                                      leading: SvgPicture.asset(
                                                          "assets/images/icons/journal/journal.svg",
                                                          width: 43.28,
                                                          height: 50.33,
                                                          fit: BoxFit.fill),
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Text("Journal",
                                                            style: AppCss
                                                                .mediumgrey10bold),
                                                      ),
                                                      subtitle: Column(
                                                        children: [
                                                          Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 1,
                                                                      right: 10,
                                                                      bottom:
                                                                          3),
                                                              child: Text(
                                                                  "Reflect on Inflammation in Your Body",
                                                                  style: AppCss
                                                                      .blue16semibold)),
                                                          Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            child: Text(
                                                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed dui est, suscipit sed.",
                                                                style: AppCss
                                                                    .grey12regular),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing:
                                                          CircularStepProgressIndicator(
                                                        totalSteps: 2,
                                                        currentStep: 1,
                                                        stepSize: 5,
                                                        selectedColor:
                                                            Color(0xFF5FB852),
                                                        unselectedColor:
                                                            AppColors
                                                                .TRANSPARENT,
                                                        padding: 0,
                                                        width: 22,
                                                        height: 22,
                                                        selectedStepSize: 3,
                                                        roundedCap: (_, __) =>
                                                            true,
                                                      ),
                                                    ),
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
                                                            onPressed: () {},
                                                            textColor: AppColors
                                                                .DEEP_BLUE,
                                                            child: Text(
                                                                "Do relfection exercise"
                                                                    .toUpperCase(),
                                                                style: AppCss
                                                                    .blue13bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                SizedBox(height: 10)
                              ],
                            ),
                    ],
                  ),
                ),
              ),
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
