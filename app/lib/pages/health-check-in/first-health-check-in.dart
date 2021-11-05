import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/pressure-health-check-in.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:page_transition/page_transition.dart';

class FirstHealthCheckIn extends StatefulWidget {
  @override
  _FirstHealthCheckInState createState() => _FirstHealthCheckInState();
}

class _FirstHealthCheckInState extends State<FirstHealthCheckIn> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          child: FractionallySizedBox(
            heightFactor: 1.0,
            widthFactor: 1.0,
            //for full screen set heightFactor: 1.0,widthFactor: 1.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      Scaffold(
        body: Container(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 103),
                    child: Container(
                      width: 125,
                      height: 125,
                      decoration: new BoxDecoration(
                        color: AppColors.PALE_BLUE,
                        borderRadius: new BorderRadius.circular(100),
                      ),
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 26, left: 30, right: 30),
                      child: Text(
                        'Keep up the good work!',
                        style: AppCss.blue26semibold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 27, left: 54, right: 54),
                    child: Text(
                      'We just have three more health questions for you, you can skip them if you want but it’s always a good habit to check in with yourself every day.',
                      style: AppCss.grey12regular,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70, bottom: 27, left: 20, right: 20),
                    child: buttion(
                      btnwidth = 295,
                      btnheight = 44,
                      btntext = 'OKAY, FINISH CHECK-IN',
                      AppCss.blue14bold,
                      AppColors.LIGHT_ORANGE,
                      btntypesubmit = true, () {
                        Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: PressureHealthCheckIn(),
                            ),
                          );
                      },12,12,40,59, context),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text("No thanks, I’ll do it next time.",
                          style: AppCss.green12semibold,
                          textAlign: TextAlign.center)),
                ]),
          ),
        ),
      ),
      ]
    );
  }
}
