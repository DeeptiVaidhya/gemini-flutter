import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/health-check-in/physical-health-check-in.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget//header.dart';

class MentalHealthCheckIn extends StatefulWidget {
  @override
  _MentalHealthCheckInState createState() => _MentalHealthCheckInState();
}

class _MentalHealthCheckInState extends State<MentalHealthCheckIn> {
  double _currentSliderValue = 4;

  final List<String> checkinMood = [
    '« Really bad »', 
    '« Really bad »',
    '« Not good »',
    '« Not good »', 
    '« I’m okay »', 
    '« I’m okay »',
    '« Good »', 
    '« Good »', 
    '« Really good »',
    '« Really good »'
  ];

  final List<String> checkinMoodIcon = [
    "assets/images/checkin-mood/cry.png", 
    "assets/images/checkin-mood/cry.png", 
    "assets/images/checkin-mood/sad.png", 
    "assets/images/checkin-mood/sad.png",  
    "assets/images/checkin-mood/nuetral.png",  
    "assets/images/checkin-mood/nuetral.png", 
    "assets/images/checkin-mood/smile.png",  
    "assets/images/checkin-mood/smile.png",  
    "assets/images/checkin-mood/laugh.png", 
    "assets/images/checkin-mood/laugh.png"
  ];

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
                  '/start-checkin',
                  skiplink = true,
                  '',
                  headingtext = 'Health check-in', isMsgActive =false,isNotificationActive=false,
                  context),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 375,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 55, bottom: 16, left: 20, right: 20),
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
                          child: Image.asset(checkinMoodIcon[_currentSliderValue.toInt()],width: 100,height: 100),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(checkinMood[_currentSliderValue.toInt()],style: AppCss.blue20semibold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: 335,
                          child: Row(children: <Widget>[
                            Container(
                            width: 40, child: Image.asset('assets/images/sad_face.png')),
                            Container(
                              width: 255,
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 4,
                                  thumbShape:RoundSliderThumbShape(enabledThumbRadius: 12),
                                  activeTrackColor: AppColors.PALE_GREEN,
                                  inactiveTrackColor: Colors.black26,
                                  activeTickMarkColor: AppColors.LIGHT_GREY,
                                  inactiveTickMarkColor: AppColors.LIGHT_GREY,
                                  overlayColor: AppColors.LIGHT_GREY,
                                  thumbColor: AppColors.EMERALD_GREEN,
                                // valueIndicatorColor: AppColors.EMERALD_GREEN,
                                ),
                                child: Slider(
                                  value: _currentSliderValue,
                                  min: 0,
                                  max: 9,
                                  divisions: 5,
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentSliderValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                                width: 40, child: Image.asset('assets/images/happy.png')),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 41, bottom: 78, left: 20, right: 20),
                          child: buttion(
                            btnwidth = 295,
                            btnheight = 44,
                            btntext = 'SUBMIT',
                            AppCss.blue14bold,
                            AppColors.LIGHT_ORANGE,
                            btntypesubmit = true, () { 
                              var sliderVal = _currentSliderValue.toInt();                          
                              Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(                         
                                settings:  RouteSettings(name:'/physical-checkin'),
                                builder: (context) => new PhysicallyHealthCheckIn(
                                  mentalvalue : sliderVal.toString()
                                ) 
                                )
                              ); 
                            },13,13,73,72, context),
                        ),
                      ]
                    ),
                  )
              ]),
        ),
      ),
    )
    ]
    );
  }
}
