import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/previsit-questions/previsit-question.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';

class PrevisitIntroduction extends StatefulWidget {
  PrevisitIntroduction({Key? key}) : super(key: key);

  @override
  _PrevisitIntroductionState createState() => _PrevisitIntroductionState();
}

class _PrevisitIntroductionState extends State<PrevisitIntroduction> {
  _previsitQuestionList() {
    //var qid = isVarEmpty(questionSequence);
    var url ="/previsit-ques";
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(settings: RouteSettings(name:url),
      builder: (context) =>new PrevisitQuestion1(qid: "")));
  }

  // void initState() {  
  //   WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
  //   getWeekly();
  //   super.initState();
  // }
  // var checkinList = [];
  // var questionSequence= [];

  // Future<void> getWeekly() async {
  //   try {
  //     final data = await getWeeklyCheckin(<String, dynamic>{"question_id": ""});
  //     if (data['status'] == "success") {       
  //       setState(() {
  //         Navigator.of(context, rootNavigator: true).pop();
  //         checkinList = data['data']['checkin'];  
  //         questionSequence = data['data']['question_sequence'];                  
  //       }); 
  //     } else {      
  //       if (data['is_valid']) {	
  //         setState(() {	
  //           Navigator.of(context, rootNavigator: true).pop();	
  //         });	
  //         Navigator.pushNamed(context, 'signin');
  //         errortoast(data['msg']);
  //       } else {	
  //         Navigator.pushNamed(context, 'home');
  //         errortoast(data['msg']);	
  //       }	
  //     }	
  //  } catch (err) {
  //     Navigator.of(context, rootNavigator: true).pop();	
  //     print('Caught error: $err');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Image.asset("assets/images/bg.png",
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
           appBar: header(
                logedin = false,
                back = true,
                logo = false,
                skip = false,
                backlink = true,
                '/home',
                skiplink = false,
                '',
                headingtext = 'Pre-visit questionnaire', isMsgActive =false,         isNotificationActive=false,
                context),
                body: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 375),
                    child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:120,bottom: 24,left: 30,right: 30),
                          child: Text("Welcome to the pre-visit questionnaire for module xx",
                          textAlign:TextAlign.center,
                          style: AppCss.blue26semibold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 120,left: 30,right: 30),
                            child: Center(
                              child: Text("Need some text for a brief into to the questionnaire ….. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt.",
                              textAlign:TextAlign.center,
                              style: AppCss.grey14regular
                              ),
                            ),
                        ),
                        Padding(
                        padding: const EdgeInsets.only(bottom: 78,left: 50,right: 30),
                        child:buttion(
                          btnwidth = 295,
                          btnheight = 44,
                          btntext = 'START'.toUpperCase(),
                          AppCss.blue14bold,
                          AppColors.LIGHT_ORANGE,
                          btntypesubmit = true, () {
                           _previsitQuestionList();
                          },13,13,73,72, context),
                        ),
                      ],
                    ),
                    ),
                  ),
                ),
        )
      ],
    );
  }
}