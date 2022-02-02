import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/weight-health-check-in.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget/header.dart';

class PulseHealthCheckIn extends StatefulWidget {
  final String bpsystolic;
  final String bpdiastolic;
  final String mentalvalue;
  final String physicalvalue;
  final String isSuplement;
  const PulseHealthCheckIn({Key? key,required this.bpsystolic, required this.bpdiastolic, required this.mentalvalue, required this.physicalvalue,required this.isSuplement}) : super(key: key);
  @override
  _PulseHealthCheckInState createState() => _PulseHealthCheckInState();
}

class _PulseHealthCheckInState extends State<PulseHealthCheckIn> {
  final _bpmkey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _bpmFormKey = GlobalKey<FormFieldState>();
  
  bool _isSubmitButtonEnabled = false;
  var bpm;
  bool  isLabelBpm = false;

  bool _isFormFieldValid() {
    return ((_bpmFormKey.currentState!.isValid));
  }

  bool _isLabelBpmValid() {
    if (_bpmFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
     return Stack(children: <Widget>[
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
                    backlink = true,
                    '/blood-pressure-checkin',
                    skiplink = false,
                    '',
                    headingtext = 'Health check-in', isMsgActive =false,
                    isNotificationActive=false,
                    context),
                Container(
                  constraints: BoxConstraints(maxWidth: 375),
                  margin: const EdgeInsets.only(top: 80, bottom: 16, left: 20, right: 20),
                  child: Text(
                    'What is your pulse reading today?',
                    style: AppCss.blue26semibold,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 375,
                  margin: const EdgeInsets.only(top: 100.0),
                  child: Form(
                    key: _bpmkey,
                    child: Row(
                      children: <Widget>[
                        new Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: new TextFormField(
                                cursorColor: AppColors.MEDIUM_GREY2,
                                style: AppCss.grey12light,
                                onChanged: (value) {
                                  setState(() {
                                    _bpmFormKey.currentState!.validate();
                                    _isSubmitButtonEnabled = _isFormFieldValid();
                                    isLabelBpm = _isLabelBpmValid();
                                  });
                                },
                                key: _bpmFormKey,
                                keyboardType: TextInputType.number, 
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(new RegExp(r"\s")),
                                  FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                                ],     
                                onSaved: (e) => bpm = e!,
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
                Container(
                  margin: const EdgeInsets.only(top: 179, bottom: 78, left: 20, right: 20),
                  child: buttion(
                    btnwidth = 295,
                    btnheight = 44,
                    btntext = 'SUBMIT',
                   _isSubmitButtonEnabled
                      ? AppCss.blue14bold
                      : AppCss.white14bold,
                  _isSubmitButtonEnabled
                      ? AppColors.LIGHT_ORANGE
                      : AppColors.LIGHT_GREY,
                      btntypesubmit = true,
                      _isSubmitButtonEnabled
                        ? () {
                        setState(() {
                          bpm = _bpmFormKey.currentState!.value.toString();  
                        });                                                
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(                         
                            settings:  RouteSettings(name:'/weight-health-check-in'),
                            builder: (context) => new WeightHealthCheckIn(bpdiastolic: widget.bpdiastolic,bpsystolic: widget.bpsystolic, mentalvalue: widget.mentalvalue, physicalvalue: widget.physicalvalue,bpm: bpm,isSuplement:widget.isSuplement
                            ) 
                          )
                        ); 
                      }
                      : null,13,13,73,72, context),
                ),
              ]),
        ),
      ),
    )
     ]
     );
  }
}
