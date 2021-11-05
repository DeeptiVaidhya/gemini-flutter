import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:localstorage/localstorage.dart';
class VirtualVisits extends StatefulWidget {
  @override
  _VirtualVisitsState createState() => _VirtualVisitsState();
}

class _VirtualVisitsState extends State<VirtualVisits> {
final LocalStorage storage = new LocalStorage('gemini');

@override
  void initState() {
     checkLoginToken(context);
     super.initState();
  }

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
              child: Container(
                width: width,
                height: height,
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(                      
                      constraints: BoxConstraints(
                        maxWidth: 500,
                      ),
                      child: Column(
                        children: <Widget>[

                           Container(
                                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                                  decoration: BoxDecoration(
                                  color: AppColors.PRIMARY_COLOR,
                                  borderRadius: new BorderRadius.circular(10.0),                            
                                  boxShadow: [
                                    BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                                  ],
                                  ),
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))
                            ),                             
                            child: Column(
                            children: <Widget>[
                              ListTile(  
                                contentPadding: EdgeInsets.only(top:20.0,left: 20.0),
                                leading :SvgPicture.asset("assets/images/group-visit/group-visit.svg",
                                width: 50,height: 50,fit: BoxFit.fill),
                                title : Column(
                                  children: <Widget>[ 
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Virtual visit ",style: AppCss.mediumgrey10bold), 
                                    ],
                                  ), 
                                  SizedBox(height: 6),                                        
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 85,
                                        height: 19,
                                        child:Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(top:4,bottom: 3,left: 6,right: 6),
                                                child: Text("Visit in progress",style: AppCss.white9semibold),
                                              )
                                            ],
                                          ),
                                          color: AppColors.RED,
                                        ),
                                      SizedBox(width: 6),
                                      Text.rich(
                                        TextSpan(
                                          text: "Finishes in: ",
                                          style : AppCss.red9light,
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: "30 mins",
                                              style: AppCss.red9semibold,
                                            )
                                          ]
                                        )
                                      ),
                                    ]),
                                  ],
                                  ),   
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(left:79,right: 36,bottom: 5.0),                      
                                child: Text("Chronic Pain - Group A",style: AppCss.blue16semibold,)
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(left:79,right: 36),                      
                                child: Text.rich(
                                  TextSpan(
                                    text: "Date : ",
                                    style : AppCss.grey12semibold,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: "July 18",
                                        style: AppCss.grey12regular,
                                      )
                                    ]
                                  )
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(left:79,right: 36),                       
                                child: Text.rich(
                                  TextSpan(
                                    text: "Time : ",
                                    style : AppCss.grey12semibold,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: "7:30-8:30pm EST",
                                        style: AppCss.grey12regular,
                                      )
                                    ]
                                  )
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(left:79,right: 36),                    
                                child: Text.rich(
                                  TextSpan(
                                    text: "Host(s): ",
                                    style : AppCss.blue12semibold,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: "Monica Chavez (Nurse Practioner), Dr. C. Chang (Physician), Jessica Holmes (Social Worker)",
                                        style: AppCss.grey12regular,
                                      )
                                    ]
                                  )
                                ),
                              ), 
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(left:79,right: 36),                      
                                child: Text.rich(
                                  TextSpan(
                                    text: "Participants: ",
                                    style : AppCss.grey12semibold,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text:"6",
                                        style: AppCss.grey12regular,
                                      )
                                    ]
                                  )
                                ),
                              ), 
                              Padding(
                                padding: EdgeInsets.only(top:16,left: 15,bottom: 20,right: 15),
                                child: Container(
                                  width: 295,
                                  height: 36,
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: AppColors.PALE_BLUE,
                                          width: 1,
                                          style: BorderStyle.solid
                                        ),
                                      borderRadius: BorderRadius.circular(50)
                                      ), 
                                    color: AppColors.LIGHT_ORANGE,
                                    child: MaterialButton(                                      
                                    padding: const EdgeInsets.fromLTRB(1, 5, 1, 4),
                                    onPressed: () {
                                    },
                                    textColor: AppColors.DEEP_BLUE,
                                    child: Text("JOIN VISIT NOW".toUpperCase(),style: AppCss.blue13bold),
                                    ),
                                    ),
                                ),
                              )                                  
                              ]
                              ),
                              ),
                            ),

                          Container(
                            margin: const EdgeInsets.only(top: 20, left: 20, right: 20,bottom: 57),
                            decoration: BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            borderRadius: new BorderRadius.circular(10.0),                            
                            boxShadow: [
                             BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                            ],
                            ),
                            child: ClipPath(
                              clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),                             
                              child: Column(
                              children: <Widget>[
                                ListTile(  
                                contentPadding: EdgeInsets.only(top:20.0,left: 20.0),
                                leading :SvgPicture.asset("assets/images/group-visit/group-visit.svg",
                                width: 50,height: 50,fit: BoxFit.fill),
                                title : Column(
                                  children: <Widget>[ 
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Virtual visit ",style: AppCss.mediumgrey10bold), 
                                    ],
                                  ),                             
                                  Row(
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    children: [
                                        Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left:3, top:10,right:120.0),
                                            child: Text("Upcoming visit ",style: AppCss.green10semibold),
                                          ), 
                                        ],
                                      ),
                                    ]),
                                  ],
                                  ),   
                              ),
                               Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top:10,left:79,right: 36,bottom: 5.0),                      
                                child: Text("Hypertension - Group C",style: AppCss.blue16semibold,)
                              ),
                             Padding(
                               padding: const EdgeInsets.fromLTRB(79, 5, 36, 0),
                               child: Row(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Date: ",
                                        style: AppCss.grey12semibold),
                                    Text("July 18",
                                        style: AppCss.grey12regular),
                                  ]),
                             ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(79, 0, 36, 1),
                              child: Row(
                              mainAxisAlignment:MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Time: ",style: AppCss.grey12semibold),
                                Text("7:30-8:30pm EST",style: AppCss.grey12regular),
                              ]),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(left:79,right: 36),                    
                              child: Text.rich(
                                TextSpan(
                                  text: "Host(s): ",
                                  style : AppCss.blue12semibold,
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: "Monica Chavez (Nurse Practioner), Dr. C. Chang (Physician), Jessica Holmes (Social Worker)",
                                      style: AppCss.grey12regular,
                                    )
                                  ]
                                )
                              ),
                            ), 
                            Padding(
                              padding: const EdgeInsets.fromLTRB(79, 0, 36, 0),
                              child: Row(
                              mainAxisAlignment:MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Participants: ",
                                    style: AppCss.grey12semibold),
                                Text("6",
                                    style: AppCss.grey12regular),
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:16,left: 15,bottom: 20,right: 15),
                              child: Container(
                                width: 295,
                                height: 36,
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: AppColors.PALE_BLUE,
                                        width: 1,
                                        style: BorderStyle.solid
                                      ),
                                    borderRadius: BorderRadius.circular(50)
                                    ), 
                                  color: AppColors.PALE_BLUE,
                                  child: MaterialButton(                                      
                                  padding: const EdgeInsets.fromLTRB(1, 5, 1, 4),
                                  onPressed: () {Navigator.of(context).pushNamed("/privisitQ");},
                                  textColor: AppColors.PALE_BLUE,
                                  child: Text("Complete pre-visit questionnaire".toUpperCase(),style: AppCss.blue13bold),
                                  ),
                                  ),
                              ),
                            ),
                            Container(
                            width: 295,
                            height: 40,
                            margin: const EdgeInsets.only(bottom: 30,left: 20,right: 20),
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.DEEP_BLUE,
                                    width: 1,
                                    style: BorderStyle.solid
                                  ),
                                borderRadius: BorderRadius.circular(50)
                                ), 
                              color: AppColors.PRIMARY_COLOR,
                              child: MaterialButton(                                      
                              padding: const EdgeInsets.fromLTRB(57, 5, 56, 4),
                              onPressed: () {},
                              textColor: AppColors.DEEP_BLUE,
                              child: Text("See visit invite".toUpperCase(),style: AppCss.blue13bold),
                              ),
                            ),
                        )
                            ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
