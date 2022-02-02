import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/pulse-health-check-in.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget/header.dart';

class BloodPressureHealthCheckIn extends StatefulWidget {
  final String mentalvalue;
  final String physicalvalue;
  final String isSuplement;
  const BloodPressureHealthCheckIn({Key? key, required this.mentalvalue, required this.physicalvalue,required this.isSuplement})
  : super(key: key);

  @override
  _BloodPressureHealthCheckInState createState() => _BloodPressureHealthCheckInState();
}

class _BloodPressureHealthCheckInState extends State<BloodPressureHealthCheckIn> {
  final _bpKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _systolicFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _diastolicFormKey = GlobalKey<FormFieldState>();
  bool _isSubmitButtonEnabled = false;
  var  systolic,diastolic;
  bool _isLabelSystolic = false;
  bool _isLabelDiastolic = false;

  bool _isFormFieldValid() {
    return ((_systolicFormKey.currentState!.isValid && _diastolicFormKey.currentState!.isValid));
  }

  bool _isLabelSystolicValid() {
    if (_systolicFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool _isLabelDiastolicValid() {
    if (_diastolicFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(            
            child: Column(                
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
                    backlink = true,
                    '/meds-checkin',
                    skiplink = false,
                    '',
                    headingtext = 'Health check-in', 
                    isMsgActive =false,         
                    isNotificationActive=false,
                    context),
                  Container(
                    constraints: BoxConstraints(maxWidth: 375),
                    margin: const EdgeInsets.only(top: 80, bottom: 16, left: 20, right: 20),
                    child: Text('What is your blood pressure today?',style: AppCss.blue26semibold,
                    textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(maxWidth: 375),
                    margin: const EdgeInsets.only(top: 100.0),
                    child: Form(
                      key: _bpKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(left: 10,right: 10),
                                  child: Text(_isLabelSystolic ? 'Systolic #' : '',style: AppCss.grey10light,
                                  textAlign: TextAlign.left)
                                ),
                                Container(
                                  child: new TextFormField(
                                      cursorColor: AppColors.MEDIUM_GREY2,
                                      style: AppCss.grey12light,
                                      key: _systolicFormKey,
                                      onSaved: (e) => systolic = e!, 
                                      onChanged: (value) {
                                        setState(() {
                                          _systolicFormKey.currentState!.validate();
                                          _isSubmitButtonEnabled = _isFormFieldValid();
                                          _isLabelSystolic = _isLabelSystolicValid();
                                        });
                                      }, 
                                      //keyboardType: TextInputType.number, 
                                      inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s")),
                                       FilteringTextInputFormatter.allow(RegExp("[0-9]"))],                                      
                                      decoration: InputDecoration(
                                        hintText: "Enter systolic #",
                                        hintStyle: AppCss.mediumgrey12light,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.MEDIUM_GREY1,width: 0.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.MEDIUM_GREY1),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.MEDIUM_GREY1),
                                        ),
                                      )),
                                ),
                              ],
                            )
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                Container(
                                  width: 16,
                                  height: 36,
                                  margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0),
                                  child: Text("/", style: AppCss.blue26semibold),
                                )
                              ]
                            ),
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(_isLabelDiastolic ? 'Diastolic #' : '',style: AppCss.grey10light,textAlign: TextAlign.left)
                                ),
                                Container(
                                  child: new TextFormField(
                                      cursorColor: AppColors.MEDIUM_GREY2,
                                      style: AppCss.grey12light,
                                      key: _diastolicFormKey,
                                      onSaved: (e) => diastolic = e!,
                                      onChanged: (value) {
                                        setState(() {
                                          _diastolicFormKey.currentState!.validate();
                                          _isSubmitButtonEnabled = _isFormFieldValid();
                                          _isLabelDiastolic= _isLabelDiastolicValid();
                                        });
                                      },
                                      //keyboardType: TextInputType.number, 
                                      inputFormatters: [FilteringTextInputFormatter.deny(new RegExp(r"\s")),
                                       FilteringTextInputFormatter.allow(RegExp("[0-9]"))], 
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        hintText: "Enter diastolic #",
                                        hintStyle: AppCss.mediumgrey12light,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.MEDIUM_GREY1,width: 0.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.MEDIUM_GREY1),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppColors.MEDIUM_GREY1),
                                        ),
                                      )),
                                ),
                              ],
                            )
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
                    _isSubmitButtonEnabled ? AppCss.blue14bold : AppCss.white14bold,
                    _isSubmitButtonEnabled ? AppColors.LIGHT_ORANGE : AppColors.LIGHT_GREY,
                    btntypesubmit = true,
                    _isSubmitButtonEnabled
                        ? () {
                        setState(() {
                          systolic = _systolicFormKey.currentState!.value.toString();  
                          diastolic = _diastolicFormKey.currentState!.value.toString();
                        });                                                
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute(                         
                            settings:  RouteSettings(name:'/pulse-checkin'),
                            builder: (context) => new PulseHealthCheckIn(bpsystolic: systolic,bpdiastolic: diastolic, mentalvalue: widget.mentalvalue, physicalvalue: widget.physicalvalue,isSuplement:widget.isSuplement
                            ) 
                          )
                        ); 
                      }
                      : null,13,13,73,72, context),
                ),
                ]),
          ),
        ),
      ),
    )
    ]
    );
  }
}
