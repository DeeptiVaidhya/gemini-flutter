import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/first-health-check-in.dart';
import 'package:gemini/pages/health-check-in/pulse-health-check-in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget/header.dart';

class PressureHealthCheckIn extends StatefulWidget {
  @override
  _PressureHealthCheckInState createState() => _PressureHealthCheckInState();
}

class _PressureHealthCheckInState extends State<PressureHealthCheckIn> {
  @override
  // ignore: override_on_non_overriding_member
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StepProgressIndicator(
                  totalSteps: 3,
                  currentStep: 1,
                  size: 4,
                  padding: 0,
                  selectedColor: AppColors.DEEP_GREEN,
                  unselectedColor: AppColors.PALE_GREEN,
                  roundedEdges: Radius.circular(10),
                ),
                header(
                    logedin = false,
                    back = true,
                    logo = false,
                    skip = true,
                    backlink = false,
                    FirstHealthCheckIn(),
                    skiplink = false,
                    PulseHealthCheckIn(),
                    headingtext = 'Health check-in', isMsgActive =false,         isNotificationActive=false,
                    context),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 80, bottom: 16, left: 54, right: 54),
                  child: Text(
                    'What is your blood pressure today?',
                    style: AppCss.blue26semibold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 100.0),
                  child: Form(
                    // key: formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //margin: const EdgeInsets.only(bottom: 100.0),
                      //child: new Column(
                      children: <Widget>[
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new TextField(
                                cursorColor: AppColors.MEDIUM_GREY2,
                                style: AppCss.grey12light,
                                decoration: InputDecoration(
                                  // hintText: "Enter systolic #",
                                  labelText: "Enter Systolic #",
                                  labelStyle: AppCss.mediumgrey12light,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1,
                                        width: 0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                )),
                          ),
                        ),
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0),
                            child: Text("/", style: AppCss.blue26semibold),
                          ),
                        ),
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new TextField(
                                cursorColor: AppColors.MEDIUM_GREY2,
                                style: AppCss.grey12light,
                                decoration: InputDecoration(
                                  // hintText: "Enter diastolic #",
                                  labelStyle: AppCss.mediumgrey12light,
                                  labelText: "Enter Diastolic #",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1,
                                        width: 0.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 39, bottom: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: PulseHealthCheckIn(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(22),
                        ),
                        primary: AppColors.LIGHT_ORANGE),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, left: 88, right: 87),
                      child: Text("Next".toUpperCase(),
                          style: AppCss.blue14bold,
                          textAlign: TextAlign.center),
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
