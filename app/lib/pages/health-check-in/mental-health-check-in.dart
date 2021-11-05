import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/physical-health-check-in.dart';
import 'package:gemini/pages/widget/helper.dart';
// import 'package:gemini/pages/health-check-in/start-health-check-in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget//header.dart';

class MentalHealthCheckIn extends StatefulWidget {
  @override
  _MentalHealthCheckInState createState() => _MentalHealthCheckInState();
}

class _MentalHealthCheckInState extends State<MentalHealthCheckIn> {
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
                    skip = false,
                    backlink = true,
                    '/health-check-in',
                    skiplink = true,
                    '',
                    headingtext = 'Health check-in', isMsgActive =false,isNotificationActive=false,
                    context),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 55, bottom: 16, left: 54, right: 54),
                  child: Text(
                    'How are you feeling today emotionally?',
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
                          thumbColor: AppColors.EMERALD_GREEN,
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
                  padding: const EdgeInsets.only(top: 41, bottom: 78, left: 20, right: 20),
                  child: buttion(
                    btnwidth = 295,
                    btnheight = 44,
                    btntext = 'NEXT',
                    AppCss.blue14bold,
                    AppColors.LIGHT_ORANGE,
                    btntypesubmit = true, () {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: PhysicallyHealthCheckIn(),
                          ),
                        );
                    },13,13,73,72, context),
                ),
              ]),
        ),
      ),
    );
  }
}
