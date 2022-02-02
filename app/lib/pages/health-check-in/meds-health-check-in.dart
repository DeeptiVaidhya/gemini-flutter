import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/blood-pressure-health-check-in.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget//header.dart';

class MedsHealthCheckIn extends StatefulWidget {
  final String mentalvalue;
  final String physicalvalue;
  const MedsHealthCheckIn({Key? key, required this.mentalvalue, required this.physicalvalue})
  : super(key: key);

  @override
  _MedsHealthCheckInState createState() => _MedsHealthCheckInState();
}

class _MedsHealthCheckInState extends State<MedsHealthCheckIn> {

  bool isYes =false;
  bool isNo =false;
  var text;
  submit(context,text) {
    Future.delayed(const Duration(milliseconds: 300), () {                
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(                         
        settings:  RouteSettings(name:'/blood-pressure-checkin'),
        builder: (context) => new BloodPressureHealthCheckIn(mentalvalue:widget.mentalvalue,physicalvalue:widget.physicalvalue,isSuplement:text.toString()) 
        )
      ); 
    });
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
        body: SingleChildScrollView(
          child: Center(
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
                      backlink = true,
                      '/physical-checkin',
                      skiplink = true,
                      '',
                      headingtext = 'Health check-in',
                      isMsgActive = false,
                      isNotificationActive = false,
                      context),
                  Container(
                    constraints: BoxConstraints(	
                      maxWidth: 375,	
                    ),	
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 55, bottom: 16, left: 20, right: 20),
                            child: Text(
                              'Did you take your medications or supplements today?',
                              style: AppCss.blue26semibold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 32, left: 54, right: 54),
                            child: Text(
                              'Please select one of the choices below.',
                              style: AppCss.grey10light,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          
                          (isYes==true) ? 
                          Container(
                            margin: const EdgeInsets.only(bottom: 13),
                            child: buttion(
                                btnwidth = 335,
                                btnheight = 60,
                                btntext = 'Yes',
                                AppCss.white16semibold,
                                AppColors.DEEP_BLUE,
                                btntypesubmit = false, () {
                                  setState(() {
                                    isNo = false;
                                    text = "1";
                                  });
                                  submit(context,text);
                                }, 18, 18, 18, 228, context),
                          ): 

                          buttion(
                              btnwidth = 335,
                              btnheight = 60,
                              btntext = 'Yes',
                              AppCss.blue16semibold,
                              AppColors.PRIMARY_COLOR,
                              btntypesubmit = false, () {                                
                                setState(() {
                                  isYes = true;
                                  text = "0";
                                });
                                submit(context,text);
                          }, 18, 18, 18, 228, context),

                          (isNo==true) ? 
                          Container(
                            margin: const EdgeInsets.only(bottom: 13),
                            child: buttion(
                                btnwidth = 335,
                                btnheight = 60,
                                btntext = 'NO',
                                AppCss.white16semibold,
                                AppColors.DEEP_BLUE,
                                btntypesubmit = false, () {
                                  setState(() {
                                    text = "1";
                                  });
                                  submit(context,text);
                                }, 18, 18, 18, 228, context),
                          ): Container(
                            margin: const EdgeInsets.only(top: 13),
                            child: buttion(
                              btnwidth = 335,
                              btnheight = 60,
                              btntext = 'No',
                              AppCss.blue16semibold,
                              AppColors.PRIMARY_COLOR,
                              btntypesubmit = false, () {                                
                                setState(() {
                                  isNo = true;
                                  text = "0";
                                });
                                submit(context,text);
                              }, 18, 18, 18, 228, context),
                          ),
                      ],
                    ),
                  ),
                  
                ]),
          ),
        ),
      )
    ]);
  }
}
