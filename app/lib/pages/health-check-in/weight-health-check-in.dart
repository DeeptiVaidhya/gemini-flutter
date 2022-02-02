import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/thanks-health-check-in.dart';
import 'package:gemini/services/checkin.dart';
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
                textAlign: TextAlign.center,
                style: AppCss.blue26semibold),
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
              }, 12, 11, 37, 37, context),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 29, 0, 49),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/thanks-health-check-in");
              },
              child: Text("Yes, I want to skip it",
                  style: AppCss.green12semibold, textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}

class WeightHealthCheckIn extends StatefulWidget {
  final String bpm;
  final String bpsystolic;
  final String bpdiastolic;
  final String mentalvalue;
  final String physicalvalue;
  final String isSuplement;
  const WeightHealthCheckIn({Key? key,required this.bpsystolic, required this.bpdiastolic, required this.mentalvalue, required this.physicalvalue,required this.bpm,required this.isSuplement}) : super(key: key);
  @override
  _WeightHealthCheckInState createState() => _WeightHealthCheckInState();
}

class _WeightHealthCheckInState extends State<WeightHealthCheckIn> {

  var currentSelectedValue;
  final dropdownType = ["ibs"];
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _weightkey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _weightFormKey = GlobalKey<FormFieldState>();
  
  bool _isSubmitButtonEnabled = true;
  var weight;
  bool  isLabelWeight = false;

  // bool _isFormFieldValid() {
  //   return ((_weightFormKey.currentState!.isValid));
  // }

  // bool _isLabelBpmValid() {
  //   if (_weightFormKey.currentState!.value.length > 0) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  submit() async {
    loader(context, _keyLoader); //invoking login
    final data = await createDailyCheckin(<String, dynamic>{
      "emotional_feeling":(widget.mentalvalue !="") ? widget.mentalvalue : "",
      "physical_feeling": (widget.physicalvalue !="") ? widget.physicalvalue : "",
      "is_supplement_taken":(widget.isSuplement !="") ? widget.isSuplement : "",
      "systolic_bp":(widget.bpsystolic !="") ? widget.bpsystolic : 0,
      "diastolic_bp":(widget.bpdiastolic !="") ? widget.bpdiastolic : 0,
      "pulse_reading":(widget.bpm !="") ? widget.bpm : "",
      "weight": _weightFormKey.currentState!.value,
      "weight_unit": (currentSelectedValue!="") ? currentSelectedValue : ""
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();        
      });
      Navigator.pushNamed(context, '/thanks-health-check-in');
      toast(data['msg']);
    } else {
      if (data['is_valid'] == false) {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        });
      } else {
        Navigator.pushNamed(context, '/home');
        errortoast(data['msg']);
      }
    }
  }

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      Image.asset(
        "assets/images/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
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
                      backlink = true,
                      '/pulse-checkin',
                      skiplink = false,
                      '',
                      headingtext = 'Health check-in',
                      isMsgActive = false,
                      isNotificationActive = false,
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
                     width: 375,
                      margin: const EdgeInsets.only(top: 100.0,left: 20),
                    child: Form(
                       key: _weightkey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: new TextFormField(
                                  cursorColor: AppColors.MEDIUM_GREY2,
                                  style: AppCss.grey12light,
                                  onChanged: (value) {
                                    setState(() {
                                     // _weightFormKey.currentState!.validate();
                                      //_isSubmitButtonEnabled = _isFormFieldValid();
                                      //isLabelWeight = _isLabelBpmValid();
                                    });
                                  },
                                  key: _weightFormKey,
                                  onSaved: (e) => weight = e!,
                                  keyboardType: TextInputType.number, 
                                  inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s")),
                                  FilteringTextInputFormatter.allow(RegExp("[0-9]"))],    
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
                                child: Container(
                                  width: 300,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: FormField<String>(
                                    builder: (FormFieldState<String> state) {
                                      return InputDecorator(
                                        decoration: InputDecoration(),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: currentSelectedValue,
                                            isDense: true,
                                            onChanged: (String? value) {
                                              setState(() {
                                                currentSelectedValue = value.toString();
                                              });
                                            },
                                            items: dropdownType.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value.toString(),
                                                child: Text(
                                                  value.toString(),
                                                  style: AppCss.blue16bold,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                  margin: const EdgeInsets.only(top: 179, bottom: 78, left: 20, right: 20),
                  child: buttion(
                    btnwidth = 295,
                    btnheight = 44,
                    btntext = 'NEXT',
                   _isSubmitButtonEnabled
                      ? AppCss.blue14bold
                      : AppCss.white14bold,
                  _isSubmitButtonEnabled
                      ? AppColors.LIGHT_ORANGE
                      : AppColors.LIGHT_GREY,
                      btntypesubmit = true,
                      _isSubmitButtonEnabled
                        ? () {                                             
                        submit();
                      }
                      : null,13,13,73,72, context),
                ),
                ]),
          ),
        ),
      )
    ]);
  }
}
