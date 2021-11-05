
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/previsit-questions/previsit-question10.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:page_transition/page_transition.dart';

class PrevisitQuestion1 extends StatefulWidget {
  @override
  _PrevisitQuestion1State createState() => _PrevisitQuestion1State();
}

class _PrevisitQuestion1State extends State<PrevisitQuestion1> {
  submit(context) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: PrevisitQuestion10(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      Image.asset(
        "images/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
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
                skip = false,
                backlink = true,
                '/',
                skiplink = false,
                '',
                headingtext = 'Question 1 of 20', isMsgActive =false,         isNotificationActive=false,                
                context),
                Container(
                  width: 500,
                  padding: const EdgeInsets.only(top:55,bottom: 13,left: 20,right: 20),                  
                  child: Text('What did you try this week to help your body feel better?',
                  textAlign:TextAlign.center,
                  style: AppCss.blue26semibold,
                  ),
                ),

                Container(
                  width: 500,
                  child: CustomRadioButton(
                      horizontal: true,
                      enableShape: true,
                      elevation: 0,
                      unSelectedColor: AppColors.PRIMARY_COLOR,
                      unSelectedBorderColor: AppColors.PRIMARY_COLOR,
                      buttonLables: [
                        'Yes',
                        'No'
                      ],
                      buttonValues: [
                        1,
                        2,
                      ],
                      buttonTextStyle: ButtonTextStyle(
                        selectedColor: AppColors.PRIMARY_COLOR,
                        unSelectedColor: AppColors.DEEP_BLUE,
                        textStyle: TextStyle(fontSize: 16,),
                        
                      ),
                      //child: Icon(Icons.radio_button_checked),
                      //defaultSelected: 1,
                      radioButtonValue: (value) {
                        //print(value);
                      },
                      selectedColor: AppColors.DEEP_BLUE,       
                      selectedBorderColor:AppColors.DEEP_BLUE,
                      height: 60,
                      width: 335,
                      padding: 0,
                      spacing: 0.0,
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 31,left: 34,right: 34),
                  child: Center(
                      child: Text('Please choose up to 3 items below',
                      textAlign:TextAlign.center,
                      style: AppCss.grey10light
                      ),
                  ),
                ), 
                Padding(
                  padding: const EdgeInsets.only(bottom:9.0,left: 20,right: 20),
                  child: buttion(
                    btnwidth = 335,
                    btnheight = 60,
                    btntext = 'Eat 3 fruits a day',
                    AppCss.blue16semibold,
                    AppColors.PRIMARY_COLOR,
                    btntypesubmit = false, () {
                      submit(context);
                    }, 19,18,20,81,context),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:9.0,left: 20,right: 20),
                  child: buttion(
                      btnwidth = 335,
                      btnheight = 60,
                      btntext = 'Eat 3 vegetables a day',
                      AppCss.white16semibold,
                      AppColors.DEEP_BLUE,
                      btntypesubmit = false, () {
                    submit(context);
                  }, 19,18,20,81,context),
                ),
               Padding(
                  padding: const EdgeInsets.only(bottom:9.0,left: 20,right: 20),
                  child: buttion(
                  btnwidth = 335,
                  btnheight = 60,
                  btntext = 'Adding more fiber',
                  AppCss.blue16semibold,
                  AppColors.PRIMARY_COLOR,
                  btntypesubmit = false, () {
                submit(context);
              }, 19,18,20,81,context),), 
              Padding(
                  padding: const EdgeInsets.only(bottom:9.0,left: 20,right: 20),
                  child: buttion(
                  btnwidth = 335,
                  btnheight = 60,
                  btntext = 'Vitamin D',
                  AppCss.blue16semibold,
                  AppColors.PRIMARY_COLOR,
                  btntypesubmit = false, () {
                    submit(context);
                  }, 19,18,20,81,context),
              ),   
              Padding(
                  padding: const EdgeInsets.only(bottom:9.0),
                  child: buttion(
                  btnwidth = 335,
                  btnheight = 60,
                  btntext = 'Acupuncture',
                  AppCss.blue16semibold,
                  AppColors.PRIMARY_COLOR,
                  btntypesubmit = false, () {
                submit(context);
              }, 19,18,20,81,context),), 
               Padding(
                  padding: const EdgeInsets.only(bottom:9.0),
                  child: buttion(
                  btnwidth = 335,
                  btnheight = 60,
                  btntext = 'Stretching',
                  AppCss.blue16semibold,
                  AppColors.PRIMARY_COLOR,
                  btntypesubmit = false, () {
                submit(context);
              }, 19,18,20,81,context),),  
               Padding(
                  padding: const EdgeInsets.only(bottom:9.0),
                  child: buttion(
                  btnwidth = 335,
                  btnheight = 60,
                  btntext = 'Meditation',
                  AppCss.blue16semibold,
                  AppColors.PRIMARY_COLOR,
                  btntypesubmit = false, () {
                submit(context);
              }, 19,18,20,81,context),),  
               Padding(
                  padding: const EdgeInsets.only(bottom:9.0),
                  child: buttion(
                  btnwidth = 335,
                  btnheight = 60,
                  btntext = 'Exercise',
                  AppCss.blue16semibold,
                  AppColors.PRIMARY_COLOR,
                  btntypesubmit = false, () {
                submit(context);
              }, 19,18,20,81,context),),  
               Padding(
                  padding: const EdgeInsets.only(bottom:9.0),
                  child: buttion(
                  btnwidth = 335,
                  btnheight = 60,
                  btntext = 'Other',
                  AppCss.blue16semibold,
                  AppColors.PRIMARY_COLOR,
                  btntypesubmit = false, () {
                submit(context);
              }, 19,18,20,81,context),), 
              
              ],
            ),
          ),
        ),
      ),
      ]
    );
  }
}