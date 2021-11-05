import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/pulse-health-check-in.dart';
import 'package:gemini/pages/health-check-in/thanks-health-check-in.dart';
// import 'package:gemini/pages/widget/modal.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:page_transition/page_transition.dart';

class Popupcontent extends StatefulWidget {
  @override
  _PopupcontentState createState() => _PopupcontentState();
}

class _PopupcontentState extends State<Popupcontent> {
  submit(context) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: ThanksHealthCheckIn(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.only(top:60,bottom: 80),
      child: Column(
      children: <Widget>[ 
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 24, 30, 0),
          child: Text(
            "Are you sure you don’t want to finish the rest of your health check-in?",
            textAlign: TextAlign.center,style: AppCss.blue26semibold
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: buttion(
            btnwidth = 295,
            btnheight = 44,
            btntext = 'OKAY, I’ll fINISH CHECK-IN',
            AppCss.blue14bold,
            AppColors.LIGHT_ORANGE,
            btntypesubmit = true, () {
                  submit(context);
                }, 12,11,37,37,context),
          ),
        ),

        Container(
         margin: const EdgeInsets.fromLTRB(0, 29, 0, 49),
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/thanks-check-in");
            },
            child: Text("Yes, I want to skip it",style: AppCss.green12semibold,textAlign: TextAlign.center),
          ),
        ),
      ],
      ),
    );
  }
}

class WeightHealthCheckIn extends StatefulWidget {
  @override
  _WeightHealthCheckInState createState() => _WeightHealthCheckInState();
}

class _WeightHealthCheckInState extends State<WeightHealthCheckIn> {
  var currentSelectedValue;
  final dropdownType = ["ibs", "bpm", "bpm"];

  Widget typeFieldWidget() {
    return Container(
      width: 300,
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                // border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(5.0))
                ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                //hint: Text("Select Value"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValue = newValue;
                  });
                },
                items: dropdownType.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: AppCss.blue16bold,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

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
                    skip = true,
                    backlink = false,
                    PulseHealthCheckIn(),
                    skiplink = false,
                    ThanksHealthCheckIn(),
                    headingtext = 'Health check-in', isMsgActive =false,         isNotificationActive=false,
                    context),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 80, bottom: 16, left: 54, right: 54),
                  child: Text(
                    'What is your weight today?',
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
                      children: <Widget>[
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: new TextField(
                                cursorColor: AppColors.MEDIUM_GREY2,
                                style: AppCss.grey12light,
                                decoration: InputDecoration(
                                  labelText: "Enter weight",
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
                              padding: const EdgeInsets.all(20.0),
                              child: typeFieldWidget()),
                        )
                      ],
                    ),
                  ),
                ),               
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 149, bottom: 149,right: 20,left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        //modalPopup(context,  AppColors.DEEP_BLUE, Popupcontent(), 335, 369);
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
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
