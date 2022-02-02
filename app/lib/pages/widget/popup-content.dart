import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/widget/helper.dart';
import '../app-css.dart';

class PracticePopupcontent extends StatefulWidget {
  String type;
  PracticePopupcontent(this.type);
  @override
  State<StatefulWidget> createState() {
    return _PracticePopupcontentState(this.type);
  }
}

class _PracticePopupcontentState extends State<PracticePopupcontent> {
  String type;
  _PracticePopupcontentState(this.type);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        color: AppColors.PRIMARY_COLOR,
        child: Column(
          children: <Widget>[              
            (widget.type == "body") ? 
            Container(
              padding: const EdgeInsets.only(top: 30,bottom: 27),
              child: Stack(
                children: <Widget>[
                  Container(                                    
                    width: 125,
                    height: 125,
                    decoration: new BoxDecoration(
                      color: Color(0xFFCEECFF),
                      borderRadius: new BorderRadius.circular(100),
                    ),
                  ),
                  Positioned(
                    top: 22,
                    left: 3,
                    right: 3,
                    child: SvgPicture.asset('assets/images/icons/body-scan/body-scan.svg',width: 82.5,height: 110.0,),
                  ),
                ],
              ),
            ) : 
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 27),
              child: Container(
                width: 125,
                height: 125,
                decoration: new BoxDecoration(
                  color: AppColors.PALE_BLUE,
                  borderRadius: new BorderRadius.circular(100),
                ),
              )
            ),              
            Text("Are you sure?",textAlign: TextAlign.center, style: AppCss.blue26semibold),
            Padding(
              padding: const EdgeInsets.only(top: 16.0,left: 24.0,right: 24,bottom: 46),
              child: Text("You haven’t finished the practice for this activity yet.",textAlign: TextAlign.center,style: AppCss.grey12regular),
            ),
            buttion(
              btnwidth = 295,
              btnheight = 44,
              btntext = 'okay, I’ll finish the practices'.toUpperCase(),
              AppCss.blue14bold,
              AppColors.LIGHT_ORANGE,
              btntypesubmit = true, () { Navigator.pop(context, true); }, 12, 11, 24, 23, context)              
          ],
        )),
    );
  }
}


