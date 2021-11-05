import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
class CircleProgressbar extends StatefulWidget {
  const CircleProgressbar({Key? key}) : super(key: key);
  @override
  _CircleProgressbarState createState() => _CircleProgressbarState();
}

class _CircleProgressbarState extends State<CircleProgressbar>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
          body: Center(
            child: Column(
              children: [
               ListView(
                 shrinkWrap: true,        
                 physics: ClampingScrollPhysics(),
                 scrollDirection: Axis.horizontal,
                 children: <Widget>[
                 Row(
                   children: [
                   Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       CircularStepProgressIndicator(
                         totalSteps: 1,
                         currentStep: 1,
                         stepSize: 5,
                         selectedColor: AppColors.ORANGE,
                         unselectedColor: AppColors.TRANSPARENT,
                         padding: 0,
                         width: 40,
                         height: 40,
                         child: SvgPicture.asset("assets/images/icons/classes-icon/learning-icon/learning.svg",width: 18,
                             height: 18),
                         selectedStepSize: 3,
                         roundedCap: (_, __) => true,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Container(
                           alignment: Alignment.bottomCenter,
                           child: Text("learning".toUpperCase(),
                               textAlign: TextAlign.center,
                               style: AppCss.mediumgrey10bold),
                         ),
                       ),
                     ],
                   ),
                   Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       CircularStepProgressIndicator(
                         totalSteps: 2,
                         currentStep: 1,
                         stepSize: 5,
                         selectedColor: AppColors.ORANGE,
                         unselectedColor: AppColors.TRANSPARENT,
                         padding: 0,
                         width: 40,
                         height: 40,
                         child: SvgPicture.asset(
                             "assets/images/icons/classes-icon/meditation_pose/meditation.svg",
                             width: 15,
                             height: 21),
                         selectedStepSize: 3,
                         roundedCap: (_, __) => true,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Container(
                           alignment: Alignment.bottomCenter,
                           child: Text("Mind Practice".toUpperCase(),
                               style: AppCss.mediumgrey10bold),
                         ),
                       ),
                     ],
                   ),
                   Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       CircularStepProgressIndicator(
                         totalSteps: 2,
                         currentStep: 1,
                         stepSize: 5,
                         selectedColor: AppColors.ORANGE,
                         unselectedColor: AppColors.TRANSPARENT,
                         padding: 0,
                         width: 40,
                         height: 40,
                         child: SvgPicture.asset("assets/images/icons/classes-icon/practice-icon/practice.svg",
                             width: 20,
                             height: 17),
                         selectedStepSize: 3,
                         roundedCap: (_, __) => true,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Container(
                           alignment: Alignment.bottomCenter,
                           child: Text("body Practice".toUpperCase(),
                               textAlign: TextAlign.center,
                               style: AppCss.mediumgrey10bold),
                         ),
                       ),
                     ],
                   ),
                   Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       CircularStepProgressIndicator(
                         totalSteps: 2,
                         currentStep: 1,
                         stepSize: 5,
                         selectedColor: AppColors.ORANGE,
                         unselectedColor: AppColors.TRANSPARENT,
                         padding: 0,
                         width: 40,
                         height: 40,
                         child: SvgPicture.asset("assets/images/icons/classes-icon/community-icon/community.svg",
                             width: 20,
                             height: 20),
                         selectedStepSize: 3,
                         roundedCap: (_, __) => true,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Container(
                           alignment: Alignment.bottomCenter,
                           child: Text("community".toUpperCase(),
                               textAlign: TextAlign.center,
                               style: AppCss.mediumgrey10bold),
                         ),
                       ),
                     ],
                   ),
                   Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       CircularStepProgressIndicator(
                         totalSteps: 2,
                         currentStep: 1,
                         stepSize: 5,
                         selectedColor: AppColors.ORANGE,
                         unselectedColor: AppColors.TRANSPARENT,
                         padding: 0,
                         width: 40,
                         height: 40,
                         child: Image.asset("assets/images/icons/classes-icon/journal-icon/journal-icon.png",width: 17,
                         height: 20),
                         selectedStepSize: 3,
                         roundedCap: (_, __) => true,
                       ),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Container(
                           alignment: Alignment.bottomCenter,
                           child: Text("Journal".toUpperCase(),
                               textAlign: TextAlign.center,
                               style: AppCss.mediumgrey10bold),
                         ),
                       ),
                     ],
                   ),
                   ]
                 )
                 ],
               ),
              ],
            ),
          ),),
    );
  }
}
