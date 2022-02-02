import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/thanks-health-check-in.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:page_transition/page_transition.dart';

class PopupcontentCheckin extends StatefulWidget {
  @override
  _PopupcontentCheckinState createState() => _PopupcontentCheckinState();
}

class _PopupcontentCheckinState extends State<PopupcontentCheckin> {
  submit(context) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: ThanksHealthCheckIn(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: AppColors.PRIMARY_COLOR,
          child: Column(
            children: <Widget>[
              Container(
                width: 125,
                height: 125,
                decoration: new BoxDecoration(
                  color: AppColors.PALE_BLUE,
                  borderRadius: new BorderRadius.circular(100),
                ),
                margin: const EdgeInsets.only(bottom: 27),
              ),
              Text("Are you sure?",
                  textAlign: TextAlign.center, style: AppCss.blue26semibold),
              Container(
                margin: const EdgeInsets.only(
                    top: 16.0, left: 20.0, right: 20, bottom: 23),
                child: Text(
                    "There are only 3 more short exercises for you to complete. It won’t take long!.",
                    textAlign: TextAlign.center,
                    style: AppCss.grey12regular),
              ),
              buttion(
                  btnwidth = 295,
                  btnheight = 44,
                  btntext = 'okay, I’ll finish the practices'.toUpperCase(),
                  AppCss.blue14bold,
                  AppColors.LIGHT_ORANGE,
                  btntypesubmit = true, () {
                Navigator.pop(context, true);
              }, 12, 11, 24, 23, context),
              SizedBox(height: 26),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/thanks-health-check-in');
                },
                child: Text("Yes, I’m sure I want to skip it",
                    textAlign: TextAlign.center, style: AppCss.green12semibold),
              ),
              SizedBox(height: 25),
            ],
          )),
    );
  }
}
