import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/pressure-health-check-in.dart';
import 'package:gemini/pages/health-check-in/weight-health-check-in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget/header.dart';

class PulseHealthCheckIn extends StatefulWidget {
  @override
  _PulseHealthCheckInState createState() => _PulseHealthCheckInState();
}

class _PulseHealthCheckInState extends State<PulseHealthCheckIn> {
  @override
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
                  currentStep: 2,
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
                    PressureHealthCheckIn(),
                    skiplink = false,
                    WeightHealthCheckIn(),
                    headingtext = 'Health check-in', isMsgActive =false,         isNotificationActive=false,
                    context),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 80, bottom: 16, left: 54, right: 54),
                  child: Text(
                    'What is your pulse reading today?',
                    style: AppCss.blue26semibold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 500,
                  margin: const EdgeInsets.only(top: 100.0),
                  child: Form(
                    // key: formKey,
                    child: Row(
                      children: <Widget>[
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: new TextField(
                                cursorColor: AppColors.MEDIUM_GREY2,
                                style: AppCss.grey12light,
                                decoration: InputDecoration(
                                  labelText: "Enter bpm",
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 160, bottom: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: WeightHealthCheckIn(),
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
