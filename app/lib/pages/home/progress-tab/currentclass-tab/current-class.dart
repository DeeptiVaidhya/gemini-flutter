import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';

class CurrentClass extends StatefulWidget {
  @override
  _CurrentClassState createState() => _CurrentClassState();
}

class _CurrentClassState extends State<CurrentClass> {

  void submit(BuildContext context) {

  }
  @override
  void initState() {
    super.initState();
  }
  
  @override
 Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
        builder: (context, constraints) {
        return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        child: Container(
          child: SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ), 
                  padding: const EdgeInsets.only(top:23,left:20,right:20),
                  child: Column(
                    children: [
                      Text("Below is your progress for this class so far.",style: AppCss.grey12regular,
                      textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:11,bottom: 19),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,          
                          children: <Widget>[
                            Text('',style: TextStyle(color: Colors.white)),
                            SvgPicture.asset("assets/images/icons/trowel.svg", width: 20, height: 20),
                            SvgPicture.asset("assets/images/icons/seeds.svg", width: 20, height: 20),
                            SvgPicture.asset("assets/images/icons/watering-can.svg", width: 20, height: 20),
                            SvgPicture.asset("assets/images/icons/sun.svg", width: 20, height: 20),
                            SvgPicture.asset("assets/images/icons/sprout.svg", width: 20, height: 20),
                        ]),
                      ),
                  //   Padding(
                  //   padding: EdgeInsets.all(15.0),
                  //   child: new LinearProgressIndicator(
                  //     width: MediaQuery.of(context).size.width - 50,
                  //     animation: true,
                  //     lineHeight: 20.0,
                  //     animationDuration: 2500,
                  //     percent: 0.8,
                  //     center: Text("80.0%"),
                  //     linearStrokeCap: LinearStrokeCap.roundAll,
                  //     progressColor: Colors.green,
                  //   ),
                  // ),
                  //
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 18,
                          decoration: new BoxDecoration(
                            color: Color(0xffCEF5CC),
                            borderRadius: BorderRadius.all(Radius.circular(30)), // round angle
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: Container(                        
                            width: 70,
                            height: 18,
                            decoration: new BoxDecoration(
                              color: AppColors.DEEP_GREEN,
                              borderRadius: BorderRadius.all(Radius.circular(30)), // round angle
                            ),
                          ),
                        )
                      ],
                    ),               
                    // Container(
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.all(Radius.circular(30)),
                    //       child: LinearProgressIndicator(
                    //         value: 0.2,
                    //         backgroundColor: Color(0xffCEF5CC),
                    //         valueColor: AlwaysStoppedAnimation<Color>(AppColors.DEEP_GREEN),
                    //         minHeight: 18,
                    //       ),
                    //     ),
                    //   ),

                      Padding(
                        padding: const EdgeInsets.only(top:8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("0",style: AppCss.grey12regular,),
                                Text("20",style: AppCss.grey12regular,),
                                Text("40",style: AppCss.grey12regular,),
                                Text("60",style: AppCss.grey12regular,),
                                Text("80",style: AppCss.grey12regular,),
                                Text("100",style: AppCss.grey12regular,),
                              ],
                          ),                     
                      ) ,
                      InkWell(
                       onTap: () => {},
                        child: new Container(
                          height: 62.0,
                          margin: EdgeInsets.only(top:19),
                          decoration: BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            borderRadius: new BorderRadius.circular(10.0),                            
                            boxShadow: [
                              BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                            ],
                          ),
                          child: new Center(
                            child: Align(
                            alignment:Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top:20.0,left: 20,right: 20.0,bottom: 19),
                              child: new Text('Health Check-in', style: AppCss.blue18semibold,textAlign: TextAlign.left),
                            ))),
                        ),
                      ),

                      InkWell(
                       onTap: () => {},
                        child: new Container(
                          margin: EdgeInsets.only(top:9),
                          height: 62.0,
                          decoration: BoxDecoration(
                             color: AppColors.PRIMARY_COLOR,
                            borderRadius: new BorderRadius.circular(10.0),                            
                            boxShadow: [
                              BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                            ],
                            ),
                         child: new Center(
                            child: Container(
                              alignment:Alignment.topLeft,
                              padding: const EdgeInsets.only(top:20.0,left: 20,right: 20.0,bottom: 16),
                              child: new Text('Learning', style: AppCss.blue18semibold,textAlign: TextAlign.left),
                            )),
                        ),
                      ),

                      InkWell(
                       onTap: () => {},
                        child: new Container(
                          margin: EdgeInsets.only(top:9),
                          height: 62.0,
                          decoration: BoxDecoration(
                             color: AppColors.PRIMARY_COLOR,
                            borderRadius: new BorderRadius.circular(10.0),                            
                            boxShadow: [
                              BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                            ],
                            ),
                         child: new Center(
                            child: Align(
                            alignment:Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top:20.0,left: 20,right: 20.0,bottom: 19),
                              child: new Text('Mind Practice', style: AppCss.blue18semibold,textAlign: TextAlign.left),
                            ))),
                        ),
                      ),

                      InkWell(
                        onTap: () => {},
                        child: new Container(
                          margin: EdgeInsets.only(top:9),
                          height: 62.0,
                          decoration: BoxDecoration(
                             color: AppColors.PRIMARY_COLOR,
                            borderRadius: new BorderRadius.circular(10.0),                            
                            boxShadow: [
                              BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                            ],
                            ),
                         child: new Center(
                            child: Align(
                            alignment:Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top:20.0,left: 20,right: 20.0,bottom: 19),
                              child: new Text('Body Practice', style: AppCss.blue18semibold,textAlign: TextAlign.left),
                            ))),
                        ),
                      ),

                      InkWell(
                        onTap: () => {},
                        child: new Container(
                          margin: EdgeInsets.only(top:9,bottom: 40),
                          height: 62.0,
                          decoration: BoxDecoration(
                             color: AppColors.PRIMARY_COLOR,
                            borderRadius: new BorderRadius.circular(10.0),                            
                            boxShadow: [
                              BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                            ],
                            ),
                          child: new Center(
                            child: Align(
                            alignment:Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top:20.0,left: 20,right: 20.0,bottom: 19),
                              child: new Text('Community', style: AppCss.blue18semibold,textAlign: TextAlign.left),
                            ))),
                        ),
                      ),
                      ],
                    ),
                ),
              ),
          ),
        ),
        );
          }
        ),                        
        ),
      ],
    );
  }
                    
                     
}