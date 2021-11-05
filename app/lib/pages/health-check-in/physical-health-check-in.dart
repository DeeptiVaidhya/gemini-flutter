import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/meds-health-check-in.dart';
import 'package:gemini/pages/health-check-in/mental-health-check-in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget//header.dart';

class PhysicallyHealthCheckIn extends StatefulWidget {
  @override
  _PhysicallyHealthCheckInState createState() =>
      _PhysicallyHealthCheckInState();
}

class _PhysicallyHealthCheckInState extends State<PhysicallyHealthCheckIn> {
  double _currentSliderValue = 40.0;
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
                    skip = false,
                    backlink = false,
                    MentalHealthCheckIn(),
                    skiplink = false,
                    '',
                    headingtext = 'Health check-in', isMsgActive =false,         isNotificationActive=false,
                    context),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 55, bottom: 16, left: 54, right: 54),
                  child: Text(
                    'How are you feeling today physically?',
                    style: AppCss.blue26semibold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 27, left: 54, right: 54),
                  child: Text(
                    'Please slide the round green button below to the left or right to select how you feel.',
                    style: AppCss.grey10light,
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Image.asset('images/calm.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    '« Really bad »',
                    style: AppCss.blue20semibold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 335,
                  child: Row(children: <Widget>[
                    Container(
                        width: 40, child: Image.asset('images/sad_face.png')),
                    Container(
                      width: 255,
                      child: SliderTheme(
                        data: SliderThemeData(
                          thumbColor: AppColors.DEEP_GREEN,
                          trackHeight: 4,
                          thumbShape:RoundSliderThumbShape(enabledThumbRadius: 15),
                          activeTrackColor: AppColors.PALE_GREEN,
                          inactiveTrackColor: AppColors.PALE_GREEN,
                        ),
                        child: Slider(
                          value: _currentSliderValue,
                          min: 0,
                          max: 100,
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                        width: 40, child: Image.asset('images/happy.png')),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 39, bottom: 80),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: MedsHealthCheckIn(),
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
                          style: AppCss.white14medium,
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
