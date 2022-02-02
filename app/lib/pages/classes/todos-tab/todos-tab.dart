import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/post.dart';
import 'package:gemini/pages/journal/journal.dart';
import 'package:gemini/pages/learning-topic/learning-topic.dart';
import 'package:gemini/pages/practice/body-practice/body-practice.dart';
import 'package:gemini/pages/practice/mind-practice/mind-practice.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/class.dart';

class ToDoTab extends StatefulWidget {
  final String classId;
  const ToDoTab({Key? key,required this.classId}) : super(key: key);
  @override
  ToDoTabState createState() => new ToDoTabState();
}

class ToDoTabState extends State<ToDoTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();	
  
  var practiceList = [];
  var classObject = [];
  var postTopicList = [];  
  var learningTopic;
  var classTitle;
  var postTopicId;
  var weekNumber;
  var postTopicTitle;  
  var postTopicInstruction;
  var description;
  var classDescription;
  var classIdS;
  var sum = 1;
  bool isDone = false;
	
  @override
  void initState() {
    checkLoginToken(context);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();	
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));	
    classDetail();	
  }	 

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<void> updateClass(objectId) async {
    try { 
    final data = await updateClassTask(<String, dynamic>{"class_objective_id": objectId});	
    if (data['status'] == "success") {	
      isDone = data['data']['class_objective_done'];
    } else {	
      Navigator.of(context, rootNavigator: true).pop();	
      errortoast(data['msg']);
    }	
   } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }
  
  Future<void> classDetail() async {
    try { 
    final data = await getClassDetails(<String, dynamic>{"class_id": this.widget.classId});	
    //if (data["data"]?.isEmpty ?? true) {  
    if (data['status'] == "success") {	
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();	
        classIdS = data['data']['class_id'];	
        classTitle = data['data']['title'];	
        classDescription = data['data']['description'];  
        classObject = data['data']['class_objective'];    
        weekNumber = data['data']['week_number'];	
        postTopicList = data['data']['post_topics'];        
        practiceList = data['data']['class_activity']['practices'];
        learningTopic = data['data']['class_activity']['topic'];
      });	
    } else {	
     if (data['is_valid'] == false) {	
        setState(() {	
          Navigator.of(context, rootNavigator: true).pop();	
        });
        Navigator.pushNamed(context, '/signin');
      } else {	
        setState(() {	
          Navigator.of(context, rootNavigator: true).pop();	
        });
        errortoast(data['msg']);	
      }	
    }	
    //}
   } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }  

  @override
  Widget build(BuildContext context) {
  return Stack(
      children: <Widget>[
      Image.asset(
        "assets/images/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 375,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  classObject.isNotEmpty ?                  
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.fromLTRB(20.0, 18.0, 10.0, 0.0),
                        child: Text("Class " +"$weekNumber"+" Objectives",style: AppCss.blue18semibold),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
                        child: Text("Below are this class’s objectives. Check the boxes below once you feel you’ve completed these objectives.",style: AppCss.grey12regular,
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 20.0),
                      child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                      Padding(padding: EdgeInsets.only(bottom: 8)),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: classObject.length,
                      itemBuilder: (context, index) {
                      return Container(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ListTile(    
                            contentPadding: EdgeInsets.only(top:14,bottom: 14,left: 20,right: 20),                             
                            leading : Container(
                              width: 40,
                              height: 40,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.DEEP_GREEN,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6,bottom: 6),
                                child: Text((sum + index).toString(),style: AppCss.white20bold,textAlign: TextAlign.center,),
                              ),                            
                            ),
                            title : Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: Text(classObject[index]['title'].toString(),style: AppCss.deepgrey12medium),
                            ),  
                            trailing : Container(                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(width: 2,
                                  color: classObject[index]['is_done'] == true ? AppColors.EMERALD_GREEN: AppColors.LIGHT_GREY,
                                ),
                              ),
                              width: 20,
                              height: 20,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.transparent,
                                ),
                                child: Checkbox(
                                  checkColor: AppColors.EMERALD_GREEN,
                                  activeColor: Colors.transparent,
                                  value: classObject[index]['is_done'],
                                  tristate: false,
                                  onChanged: (value) {
                                    setState(() => classObject[index]['is_done'] = value!);
                                  },
                                ),
                              ),
                          ), 
                          )                                
                        ]
                        ),
                      ),
                  );
                  }
                  ),
                  ),
                  //   Container(
                  //   padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 20.0),
                  //   child: ListView.separated(
                  //     separatorBuilder: (BuildContext context, int index) => Container(margin: EdgeInsets.only(bottom: 8)),
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: classObject.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return new Container(
                  //         padding: new EdgeInsets.all(10.0),
                  //         decoration: BoxDecoration(
                  //         color: AppColors.PRIMARY_COLOR,
                  //         borderRadius: new BorderRadius.circular(10.0),                           
                  //         boxShadow: [
                  //           BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                  //         ],
                  //         ),
                  //         child: ClipPath(
                  //           clipper: ShapeBorderClipper(
                  //             shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10))
                  //           ),  
                  //           child: Column(
                  //             children: <Widget>[
                  //             Theme(
                  //               data: ThemeData(
                  //                 unselectedWidgetColor: AppColors.LIGHT_GREY,
                  //               ),
                  //               child: new CheckboxListTile(
                  //                 activeColor: AppColors.DEEP_GREEN,                                  
                  //                 dense: true,
                  //                 title: new Text(classObject[index]['title'].toString(),style: AppCss.deepgrey12medium),
                  //               value: classObject[index]['is_done'],
                  //               secondary:Container(
                  //                 width: 40,
                  //                 height: 40,
                  //                 decoration: new BoxDecoration(
                  //                   shape: BoxShape.circle,
                  //                   color: AppColors.DEEP_GREEN,
                  //                 ),
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(top: 6,bottom: 6),
                  //                   child: Text((sum + index).toString(),style: AppCss.white20bold,textAlign: TextAlign.center,),
                  //                 ),                            
                  //               ),
                  //               onChanged: (bool?  val) {
                  //                 itemChange(val!, index);
                  //               },
                  //               ),
                  //             )
                  //           ],
                  //       ),
                  //         ),
                  //         );
                  // }),
                  // ),
                  ],
                  ) : Container(),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 18.0),
                    child: Text("Class " +"$weekNumber"+" Activites",style: AppCss.blue18semibold),
                  ),
                  (classTitle !="") ?  
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15,bottom: 16),
                    decoration: BoxDecoration(
                    color: AppColors.PRIMARY_COLOR,
                    borderRadius: new BorderRadius.circular(10.0),                            
                    boxShadow: [
                      BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 3,offset: Offset(0, 3))
                    ],
                    ),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(12.0),       
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                        ListTile( 
                          contentPadding:EdgeInsets.only(top:10.0,left: 20.0,right: 20),                                     
                          leading :SvgPicture.asset("assets/images/icons/learning/learning.svg",
                          width: 46,height: 46),
                          title : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin : EdgeInsets.only(top:10),
                                child: Text("Learning",style: AppCss.mediumgrey10bold)), 
                            ],
                          ), 
                          subtitle: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top:5,right: 10,bottom: 3),
                                child: Text(isVarEmpty(classTitle).toString(),style:AppCss.blue16semibold)),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(isVarEmpty(classDescription).toString(),style: AppCss.grey12regular),
                              ),
                            ],
                          ),  
                          trailing : CircularStepProgressIndicator(
                              totalSteps: 2,
                              currentStep: 1,
                              stepSize: 5,
                              selectedColor: Color(0xFF5FB852),
                              unselectedColor: AppColors.TRANSPARENT,
                              padding: 0,
                              width: 22,
                              height: 22,
                              selectedStepSize: 3,
                              roundedCap: (_, __) => true,
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
                          color: AppColors.PALE_BLUE,
                          child: MaterialButton(                                      
                          padding: const EdgeInsets.fromLTRB(1, 5, 1, 4),
                          onPressed: () {
                            var cId=isVarEmpty(classIdS);                              
                            var url="/learning-topics/$cId";                              
                            Navigator.of(context).pushReplacement(
                              new MaterialPageRoute( 
                              settings:  RouteSettings(name:url),
                              builder: (context) => new LearningTopic(
                                classId : cId,
                                type: "learning",
                                ) 
                              )
                            ); 
                          },
                          textColor: AppColors.DEEP_BLUE,
                          child: Text("Read learning topics".toUpperCase(),style: AppCss.blue13bold),
                          ),
                          ),
                      ),
                      ),                                  
                      ]
                      ),
                    ),
                  ) : Container(),
                  practiceList.isEmpty ? 
                  Container() :   
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                    Padding(padding: EdgeInsets.only(bottom: 8)),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: practiceList.length,
                    itemBuilder: (context, index) {
                    return Container(
                    margin: const EdgeInsets.only(top: 0, left: 15, right: 15,bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.PRIMARY_COLOR,
                    borderRadius: new BorderRadius.circular(10.0),                            
                    boxShadow: [
                      BoxShadow(
                      color: AppColors.SHADOWCOLOR,
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: Offset(0, 3)
                      )
                    ],
                    ),
                    child:  ClipRRect(
                      borderRadius: new BorderRadius.circular(10.0),    
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        (practiceList[index]['type']=="body") ? 
                        ListTile(   
                          contentPadding:EdgeInsets.only(top:10.0,left: 20.0,right: 20),                                        
                          leading : SvgPicture.asset("assets/images/icons/body-scan/body-scan.svg",
                          width: 37.5,height: 50,fit: BoxFit.fill),
                          title : Padding(
                            padding: const EdgeInsets.only(top:10),
                            child: Text("Body Practice",style: AppCss.mediumgrey10bold),
                          ), 
                          subtitle: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top:5,right: 10,bottom: 3),
                                child: Text(practiceList[index]['title'],style:AppCss.blue16semibold)),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(practiceList[index]['description'],style: AppCss.grey12regular),
                              ),
                            ],
                          ), 
                          trailing : CircularStepProgressIndicator(
                              totalSteps: 2,
                              currentStep: 1,
                              stepSize: 5,
                              selectedColor: Color(0xFF5FB852),
                              unselectedColor: AppColors.TRANSPARENT,
                              padding: 0,
                              width: 22,
                              height: 22,
                              selectedStepSize: 3,
                              roundedCap: (_, __) => true,
                            ), 
                        ):
                        ListTile(  
                          contentPadding:EdgeInsets.only(top:10.0,left: 20.0,right: 20),                                     
                          leading : SvgPicture.asset("assets/images/icons/meditation/meditation.svg",
                            width: 37.5,height: 50,fit: BoxFit.fill),
                          title : Padding(
                            padding: const EdgeInsets.only(top:10),
                            child: Text("Mind Practice",style: AppCss.mediumgrey10bold),
                          ), 
                          subtitle: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: const EdgeInsets.only(top:5,right: 10,bottom: 3),
                                child: Text(practiceList[index]['title'],style:AppCss.blue16semibold)),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(practiceList[index]['description'],style: AppCss.grey12regular),
                              ),
                            ],
                          ),  
                          trailing : CircularStepProgressIndicator(
                              totalSteps: 2,
                              currentStep: 1,
                              stepSize: 5,
                              selectedColor: Color(0xFF5FB852),
                              unselectedColor: AppColors.TRANSPARENT,
                              padding: 0,
                              width: 22,
                              height: 22,
                              selectedStepSize: 3,
                              roundedCap: (_, __) => true,
                            ), 
                        ),
                        (practiceList[index]['type']=="body") ?
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
                              onPressed: () {
                                var prId=isVarEmpty(practiceList[index]['id']);                              
                                var url="/body-practice/$prId";                              
                                Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute( 
                                  settings:  RouteSettings(name:url),
                                  builder: (context) => new BodyPractice(
                                    practiceId : practiceList[index]['id'], type: '/classes',
                                    ) 
                                  )
                                );   
                              },
                              textColor: AppColors.DEEP_BLUE,
                              child: Text("Do body practice".toUpperCase(),style: AppCss.blue13bold),
                              ),
                              ),
                          ),
                        ) :                      
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
                            onPressed: () {  
                              var prId= isVarEmpty(practiceList[index]['id']);                              
                              var url="/mind-practice/$prId";                              
                              Navigator.of(context).pushReplacement(
                                new MaterialPageRoute( 
                                settings:  RouteSettings(name:url),
                                builder: (context) => new MindPractice(
                                  practiceId : practiceList[index]['id']!, type: '/classes',
                                  ) 
                                )
                              );  
                            },
                            textColor: AppColors.DEEP_BLUE,
                            child: Text("Do mind practice".toUpperCase(),style: AppCss.blue13bold),
                            ),
                            ),
                        ),
                        ),                                  
                      ]
                      ),
                    ),
                  );
                  }
                  ),

                  //post community and journal
                  postTopicList.isEmpty ? 
                  Container() :                         
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                      Padding(padding: EdgeInsets.only(bottom: 8)),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: postTopicList.length,
                      itemBuilder: (context, index) {
                      return Container(
                      margin: const EdgeInsets.only(top: 0, left: 15, right: 15,bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.PRIMARY_COLOR,
                      borderRadius: new BorderRadius.circular(10.0),                            
                      boxShadow: [
                              BoxShadow(
                              color: AppColors.SHADOWCOLOR,
                              spreadRadius: 0,
                              blurRadius: 3,
                              offset: Offset(0, 3)
                              )
                            ],
                      ),
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(12.0),      
                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          (postTopicList[index]['type']=="community") ?                                  
                         ListTile( 
                            contentPadding:EdgeInsets.only(top:10.0,left: 20.0,right: 20),                    
                            leading :SvgPicture.asset("assets/images/icons/community/community.svg",
                            width: 37.5,height: 50,fit: BoxFit.fill),
                            title : Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Text("Community",style: AppCss.mediumgrey10bold),
                            ),
                            subtitle: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(top:1,right: 10,bottom: 3),
                                child: Text(isVarEmpty(postTopicList[index]['title']).toString(),style:AppCss.blue16semibold)),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(right: 10,),
                                child: Text(isVarEmpty(postTopicList[index]['instruction']).toString(),style: AppCss.grey12regular),
                              ),
                            ],
                          ), 
                          trailing : CircularStepProgressIndicator(
                              totalSteps: 2,
                              currentStep: 1,
                              stepSize: 5,
                              selectedColor: Color(0xFF5FB852),
                              unselectedColor: AppColors.TRANSPARENT,
                              padding: 0,
                              width: 22,
                              height: 22,
                              selectedStepSize: 3,
                              roundedCap: (_, __) => true,
                            ), 
                          ):
                          ListTile(
                            contentPadding:EdgeInsets.only(top:10.0,left: 20.0,right: 20),                                       
                            leading : SvgPicture.asset("assets/images/icons/journal/journal.svg",width: 37.5,height: 50,fit: BoxFit.fill),
                            title : Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Text("Journal",style: AppCss.mediumgrey10bold),
                            ), 
                            subtitle: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(top:1,right: 10,bottom: 3),
                                child: Text(isVarEmpty(postTopicList[index]['title']).toString(),style:AppCss.blue16semibold)),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(right: 10,),
                                child: Text(isVarEmpty(postTopicList[index]['instruction']).toString(),style: AppCss.grey12regular),
                              ),
                            ],
                          ),  
                          trailing : CircularStepProgressIndicator(
                              totalSteps: 2,
                              currentStep: 1,
                              stepSize: 5,
                              selectedColor: Color(0xFF5FB852),
                              unselectedColor: AppColors.TRANSPARENT,
                              padding: 0,
                              width: 22,
                              height: 22,
                              selectedStepSize: 3,
                              roundedCap: (_, __) => true,
                            ), 
                          ),
                          (postTopicList[index]['type']=="community") ?
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
                                onPressed: () { 
                                  var postTopicid = isVarEmpty(postTopicList[index]['id']);                       
                                  var url="/post/$postTopicid";                              
                                  Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute( 
                                    settings:  RouteSettings(name:url),
                                    builder: (context) => new Post(
                                      topicId : postTopicid!,
                                    ) 
                                    )
                                  ); 
                                },
                                textColor: AppColors.DEEP_BLUE,
                                child: Text("Post in the community".toUpperCase(),style: AppCss.blue13bold),
                                ),
                                ),
                            ),
                          ) :
                          Padding(
                          padding: EdgeInsets.only(top:16,left: 15,bottom: 20,right: 15),
                          child: Container(
                            width: 295,
                            height: 36,
                            child: Material(
                            shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.PALE_BLUE,
                            width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.circular(50)), 
                              color: AppColors.PALE_BLUE,
                              child: MaterialButton(                                      
                              padding: const EdgeInsets.fromLTRB(1, 5, 1, 4),
                              onPressed: () {
                                var postId = isVarEmpty(postTopicList[index]['id']);                       
                                var url="/journal/$postId";                              
                                Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute( 
                                  settings:  RouteSettings(name:url),
                                  builder: (context) => new Journal(
                                    postId : postId!,
                                  ) 
                                  )
                                ); 
                              },
                              textColor: AppColors.DEEP_BLUE,
                              child: Text("Do journal exercise".toUpperCase(),style: AppCss.blue13bold),
                            ),
                            ),
                          ),
                          ),                                 
                        ]
                        ),
                      ),
                    );
                    }
                ),
                  ),                      
                ],
              ),
            ),
          ),
        ),
      ),
      ]
    );
  }

  void itemChange(bool val, int index) {
    updateClass(classObject[index]['id']);
    setState(() {
      classObject[index]['is_done'] = val;
    });
  }
}