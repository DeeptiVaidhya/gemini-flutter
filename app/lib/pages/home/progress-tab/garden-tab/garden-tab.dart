import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
class Garden extends StatefulWidget {
  @override
  _GardenState createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
        return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: height,
              width: width,
            constraints: BoxConstraints(
              maxWidth: 500,
            ), 
            child:Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 23),
                  child: Text('You’re almost there!!',style: AppCss.blue20semibold),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 11, left: 20, right: 29, bottom: 13),
                  child: Text('You are nearly half way to growing your garden! Be sure to finish you’re activities to earn more rewards.',style: AppCss.grey12regular,textAlign: TextAlign.center),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left:50,right: 50,top: 13),
                    child: GridView.count( 
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: constraints.maxWidth < 500 ? 5 : 8,
                      crossAxisSpacing: 3,
                      childAspectRatio: constraints.maxWidth < 500 ? height/900.0 : height /700,  
                      crossAxisCount: 3,
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,     
                                child: CircleAvatar(radius: (100),backgroundColor: Colors.white,)),
                              Container(
                                margin: const EdgeInsets.only(top:6),
                                child: Text("ClASS 8",style: AppCss.mediumgrey8extrabold),
                              ),
                              Text("PANSY",style: AppCss.green10bold,textAlign: TextAlign.center)
                            ]
                          ),
                        ),
                        Column(
                          children: [
                           Container(
                            width: 70,
                            height: 70,
                            child: CircleAvatar(radius: (50),
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left:22.0,right: 25.33,top:15.0,bottom: 15),
                                child: Image.asset('assets/images/garden/rose/rose.png'),
                              ),
                            ),
                          ),
                             Container(
                                margin: const EdgeInsets.only(top:6),
                              child: Text("ClASS 7",style: AppCss.mediumgrey8extrabold),
                            ),
                            Text("ROSE",style: AppCss.green10bold,textAlign: TextAlign.center,)
                          ]
                        ),
                        Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: CircleAvatar(radius: (50),
                                backgroundColor: Colors.white,
                                child: Image.asset('assets/images/garden/rose/rose.png'),
                              ),
                            ),
                             Container(
                                margin: const EdgeInsets.only(top:6),
                              child: Text("ClASS 6",style: AppCss.mediumgrey8extrabold),
                            ),
                            Text("Tulip".toUpperCase(),style: AppCss.green10bold,textAlign: TextAlign.center)
                          ]
                        ),
                        Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: CircleAvatar(
                                radius: (50),
                                backgroundColor: Colors.white,
                                child: Image.asset('assets/images/garden/blue-flower/blue-flower.png'),
                              ),
                            ), 
                             Container(
                                margin: const EdgeInsets.only(top:6),
                              child: Text("ClASS 5",style: AppCss.mediumgrey8extrabold),
                            ),
                            Text("blue FLOWER".toUpperCase(),style: AppCss.green10bold,textAlign: TextAlign.center)
                          ]
                        ), 
                        Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              child: CircleAvatar(
                                radius: (50),
                                backgroundColor: Colors.white,
                                child: CircularStepProgressIndicator(
                                totalSteps: 2,
                                currentStep: 1,
                                stepSize: 2,
                                selectedColor: Color(0xFF5FB852),
                                unselectedColor: AppColors.TRANSPARENT,
                                padding: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Image.asset('assets/images/garden/blur-sunflower/blur-sunflower.png'),
                                ),
                                selectedStepSize: 2,
                                roundedCap: (_, __) => true,
                              ),
                              ),
                          ),
                             Container(
                                margin: const EdgeInsets.only(top:6),
                              child: Text("ClASS 5",style: AppCss.mediumgrey8extrabold),
                            ),
                            Text("Pink FLOWER".toUpperCase(),style: AppCss.green10bold,textAlign: TextAlign.center)
                          ]
                        ),
                        Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,     
                              child: CircularStepProgressIndicator(
                                totalSteps: 2,
                                currentStep: 1,
                                stepSize: 5,
                                selectedColor: Color(0xFF5FB852),
                                unselectedColor: AppColors.TRANSPARENT,
                                padding: 0,
                                width: 60,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:26.0,right: 25.33,top:15.0,bottom: 15),
                                  child: Image.asset('assets/images/garden/flower/flower.png'),
                                ),
                                selectedStepSize: 2,
                                roundedCap: (_, __) => true,
                              ),
                            ), 
                             Container(
                                margin: const EdgeInsets.only(top:6),
                              child: Text("ClASS 4",style: AppCss.mediumgrey8extrabold),
                            ),
                            Text("PURPLE FLOWER",style: AppCss.green10bold,textAlign: TextAlign.center)
                          ]
                        ),
                        Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,     
                              child: CircularStepProgressIndicator(
                                totalSteps: 1,
                                currentStep: 1,
                                stepSize: 5,
                                selectedColor: Color(0xFF5FB852),
                                unselectedColor: AppColors.TRANSPARENT,
                                padding: 0,
                                width: 60,
                                height: 60,
                                child: Image.asset('assets/images/garden/sunflower/sunflower.png'),
                                selectedStepSize: 3,
                                roundedCap: (_, __) => true,
                            ),
                            ), 
                             Container(
                                margin: const EdgeInsets.only(top:6),
                              child: Text("ClASS 5",style: AppCss.mediumgrey8extrabold),
                            ),
                            Text("SUNFLOWER",style: AppCss.green10bold,textAlign: TextAlign.center)
                          ]
                        ),
                        Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,     
                              child: CircularStepProgressIndicator(
                                totalSteps: 1,
                                currentStep: 1,
                                stepSize: 5,
                                selectedColor: Color(0xFF5FB852),
                                unselectedColor: AppColors.TRANSPARENT,
                                padding: 0,
                                width: 60,
                                height: 60,
                                child: Image.asset('assets/images/garden/red-flower/red-flower.png'),
                                selectedStepSize: 3,
                                roundedCap: (_, __) => true,
                            ),
                            ), 
                             Container(
                                margin: const EdgeInsets.only(top:6),
                              child: Text("ClASS 5",style: AppCss.mediumgrey8extrabold),
                            ),
                            Text("ORANGE FLOWER",style: AppCss.green10bold,textAlign: TextAlign.center)
                          ]
                        ),
                        Column(
                          children: [
                            Container(
                              width: 70,
                              height: 70,     
                              child: CircularStepProgressIndicator(
                                totalSteps: 1,
                                currentStep: 1,
                                stepSize: 5,
                                selectedColor: Color(0xFF5FB852),
                                unselectedColor: AppColors.TRANSPARENT,
                                padding: 0,
                                width: 60,
                                height: 60,
                                child: Image.asset('assets/images/garden/plant/plant.png'),
                                selectedStepSize: 3,
                                roundedCap: (_, __) => true,
                            ),
                            ), 
                             Container(
                                margin: const EdgeInsets.only(top:6),
                              child: Text("ClASS 4",style: AppCss.mediumgrey8extrabold),
                            ),
                            Text("FERN",style: AppCss.green10bold,textAlign: TextAlign.center)
                          ]
                        ),
                      ],  
                    ),
                  ),
                )
              ],
            ),
            ),
          ),
        )
        );
        }
        )
    );
  }
}