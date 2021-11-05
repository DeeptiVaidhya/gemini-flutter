import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/rendering.dart'; 

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  
  final LocalStorage storageAccessCode = new LocalStorage('gemini-accesscode');
  @override	
  void initState() {	
    storageAccessCode.clear();	
    super.initState();	
  }	
  
  _signIN() {
    Navigator.of(context).pushNamed("/signin");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.DEEP_BLUE,
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 152),
                child: SvgPicture.asset("assets/images/welcome.svg",width: 93.89,height: 92.67,)
              ),
              Container(
                margin: const EdgeInsets.only(top: 52.33, bottom: 24,left: 30,right: 30),
                child: Text("Welcome to GEMINI",style: AppCss.white26semibold, textAlign: TextAlign.center),
              ),
              Container(
                margin:const EdgeInsets.only(bottom: 125,left: 30,right: 30),
                child: Text("Where you can take control of you health with the support of your peers and health care provider.",style: AppCss.white14light,textAlign: TextAlign.center)
              ),
              buttion(
                btnwidth = 275,
                btnheight = 44,
                btntext = 'SIGN IN',
                AppCss.blue14bold,
                AppColors.LIGHT_ORANGE,
                btntypesubmit = true, () {
                _signIN();
              }, 12,12,88,87,context),
                Padding(
                  padding: const EdgeInsets.only(left:20,right:20,top: 24, bottom: 34),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Don’t have an account?',style: AppCss.white14light),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: InkWell(
                          child: Text('Sign up', style: AppCss.white14medium),
                          onTap: () {
                            Navigator.of(context).pushNamed("/create-access-code");
                          }),
                    )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
