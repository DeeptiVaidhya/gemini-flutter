import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/learning-topic/learning-topic-details.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/learning.dart';

class LearningTopic extends StatefulWidget {
  final String classId;
  final String type;
  const LearningTopic({Key? key, required this.classId,required this.type}) : super(key: key);
  @override
  _LearningTopicState createState() => _LearningTopicState();
}

class _LearningTopicState extends State<LearningTopic> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var currentSelectedValue;
  var learningTopicList = [];
  var sum = 1;
  late String? classId;

  @override
  void initState() {
    classId = isVarEmpty(widget.classId);
    //var urlParam =getUrl("map"); 
    //classId=isVarEmpty(urlParam['id'])!=''?urlParam['id']:widget.classId;
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    allLearningTopicsPost();
    
    super.initState();
  }

  Future<void> allLearningTopicsPost() async {
    try {
      final data = await getLearningTopicsPost(<String, dynamic>{"class_id": classId});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          learningTopicList = data['data']['topics'];
        });
      } else {
        if (data['is_valid']) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          toast(data['msg']);
        } else {
          Navigator.pushNamed(context, '/');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      Image.asset(
        "assets/images/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: header(
          logedin = true,
          back = true,
          logo = false,
          skip = false,
          backlink = true,
         (widget.type =="learning") ? "/class-details/$classId" : '/home',     
          //'/home',
          skiplink = false,
          '/',
          headingtext = 'Learning',
          isMsgActive =false,        
          isNotificationActive=false,
          context
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 375,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:const EdgeInsets.only(top: 28, left: 20),
                    child: Text("Learn About Inflammation",style: AppCss.blue18semibold,textAlign: TextAlign.center
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 32),
                    child: Text("Please read all of the topics below to complete the activity",
                    style: AppCss.grey14regular,textAlign: TextAlign.center),
                  ),
                  Container( 
                    margin: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                    child: learningTopicList.isEmpty ? 
                      Container(
                        margin: const EdgeInsets.only(top:150,bottom: 150,left: 40,right: 40),
                        child: Text("No learning topic list yet.",style: AppCss.grey12medium,textAlign: TextAlign.center),
                      ) : ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                      Container(margin: EdgeInsets.only(bottom: 8)),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: learningTopicList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                          color: AppColors.PRIMARY_COLOR,
                          borderRadius: new BorderRadius.circular(8.0),                            
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
                              borderRadius: new BorderRadius.circular(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(left: BorderSide(width: 7, color: AppColors.DEEP_BLUE)),
                                ),
                                child: ListTile(
                                  minLeadingWidth: 0,
                                  horizontalTitleGap: 0.0,                        
                                  isThreeLine: true,
                                  dense: true,
                                  title: Padding(
                                    padding: const EdgeInsets.only(top:10,left:5.0,right: 105.0),
                                    child: Text("Learning Topic " +(sum + index).toString(),
                                    style: AppCss.mediumgrey10bold
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top:4,left:5.0,right: 105.0,bottom: 21),
                                    child: Text(learningTopicList[index]['title'],style: AppCss.blue16semibold,textAlign: TextAlign.left,
                                    ),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top:6.0),
                                    child: Wrap(
                                      spacing: 10, 
                                      children: <Widget>[
                                        (learningTopicList[index]['is_completed']==true) ? 
                                        Container(
                                        width: 27,
                                        height: 27,
                                        margin: EdgeInsets.only(top:5,),
                                        child: CircleAvatar(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:0,right: 0),
                                            child: Icon(
                                              Icons.done,
                                              color: AppColors.PRIMARY_COLOR,
                                              size: 20,
                                            ),
                                          ),
                                          backgroundColor: AppColors.DEEP_BLUE,
                                        ),
                                      )
                                      :
                                      Container(
                                        width: 27,
                                        height: 27,
                                        margin: EdgeInsets.only(top:5,),
                                        child: CircleAvatar(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:0,right: 0),
                                            child: Icon(
                                              Icons.done,
                                              color: AppColors.PRIMARY_COLOR,
                                              size: 20,
                                            ),
                                          ),
                                          backgroundColor: Color(0xFFEBEBEB),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top:5),child: Icon(Icons.keyboard_arrow_right,color: AppColors.DEEP_BLUE, size: 30)) 
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    var topicId = isVarEmpty(learningTopicList[index]['id']);
                                    var url="/learning-topic-details/$topicId";                              
                                      Navigator.of(context).pushReplacement(
                                        new MaterialPageRoute( 
                                        settings:  RouteSettings(name:url),
                                        builder: (context) => new LearningTopicDetails(
                                          classId:isVarEmpty(widget.classId),
                                          topicId: isVarEmpty(topicId),
                                          title: isVarEmpty(learningTopicList[index]['title']),
                                        ) 
                                      )
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: floatingactionbuttion(context),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: footer(
            ishomepageactive = false,
            isclassespageactive = true,
            islibyrarypageactive = false,
            ismorepageactive = false,
            context)),
    ]);
  }
}
