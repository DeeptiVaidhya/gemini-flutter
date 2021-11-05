
import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/first-health-check-in.dart';
import 'package:gemini/pages/health-check-in/physical-health-check-in.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget//header.dart';

class MedsHealthCheckIn extends StatefulWidget {
  @override
  _MedsHealthCheckInState createState() => _MedsHealthCheckInState();
}

class _MedsHealthCheckInState extends State<MedsHealthCheckIn> {
  submit(context) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: FirstHealthCheckIn(),
      ),
    );
  }

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
                  currentStep: 3,
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
                    skip = false,
                    backlink = false,
                    PhysicallyHealthCheckIn(),
                    skiplink = true,
                    '',
                    headingtext = 'Health check-in',
                    isMsgActive =false,isNotificationActive=false,
                    context),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 55, bottom: 16, left: 54, right: 54),
                  child: Text(
                    'Did you take your medications or supplements today?',
                    style: AppCss.blue26semibold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 32, left: 54, right: 54),
                  child: Text(
                    'Please select one of the choices below.',
                    style: AppCss.grey10light,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: buttion(
                      btnwidth = 335,
                      btnheight = 60,
                      btntext = 'Yes',
                      AppCss.white16semibold,
                      AppColors.DEEP_BLUE,
                      btntypesubmit = false, () {
                    submit(context);
                  }, 18,18,18,18,context),
                ),
                buttion(
                    btnwidth = 335,
                    btnheight = 60,
                    btntext = 'No',
                    AppCss.blue16semibold,
                    AppColors.PRIMARY_COLOR,
                    btntypesubmit = false, () {
                  submit(context);
                }, 18,18,18,18,context),
                
              ]),
        ),
      ),
    );
  }
}
