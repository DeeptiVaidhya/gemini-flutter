import 'package:flutter/material.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/post.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';

class Discussion extends StatefulWidget {
 final dynamic controller;
  const Discussion({Key? key, required this.controller}) : super(key: key);
  @override
  _DiscussionState createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var currentSelectedValue;
  var discussionList = [];
  var totalPost;
  
  @override
  void initState() {    
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    getDiscussionTopicList();
    super.initState();
  }
  
  Future<void> getDiscussionTopicList() async {
    try {
      final data = await getDiscussionPost(<String, dynamic>{"user_id" : ""});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          discussionList = data['data']['discussion_topics'];
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
          Navigator.pushNamed(context, '/home');
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 375,
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:const EdgeInsets.only(left: 22, bottom: 10, top: 6),
                    child:Text("Discussion topics",style: AppCss.blue20semibold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 40,left: 20.0,right: 20.0),
                  child: discussionList.isEmpty ? 
                    Container(
                      margin: const EdgeInsets.only(top:150,bottom: 150,left: 40,right: 40),
                      child: Text("No topics list yet.",style: AppCss.grey12medium,textAlign: TextAlign.center,),
                    )
                    : ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                      Padding(padding: EdgeInsets.only(bottom: 16)),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: discussionList.length,
                      itemBuilder: (context, index) {
                        totalPost = discussionList[index]['total_posts'].toString();
                        var firstPost = (discussionList[index]['first_post'] !=null);
                        var lastPost = (discussionList[index]['last_post'] !=null);
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
                                border: Border(left: BorderSide(width: 6.0,color: AppColors.EMERALD_GREEN)),
                              ),
                              child: Column(
                                children: [
                                ListTile(                                  
                                  leading: Container(
                                    margin: EdgeInsets.only(top:18),
                                    child: 
                                    
                                    (firstPost && lastPost) ? 
                                    Stack(                                      
                                      children: <Widget>[
                                        (discussionList[index]['first_post']['profile_picture'] !="" ) ? 
                                        Container(
                                          height: 30.0,
                                          width: 30.0,
                                          child: CircleAvatar(
                                            radius: 100.0,
                                            backgroundColor: AppColors.PRIMARY_COLOR,
                                            backgroundImage: NetworkImage(discussionList[index]['first_post']['profile_picture']),
                                          ),
                                        ) 
                                        : 
                                        Container(
                                          height: 29.0,
                                          width: 29.0,
                                          decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.TRANSPARENT),
                                          child: Container(
                                          alignment: Alignment.center,
                                          child: new Icon(GeminiIcon.profile,size: 15, color: AppColors.PRIMARY_COLOR)),
                                        ),
                                        (discussionList[index]['last_post']['profile_picture'] !="" ) ? 
                                        Positioned(
                                          bottom: 0.0,
                                          right: 2.0,
                                          child: Container(
                                          height: 22.0,
                                          width: 22.0,
                                           decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:Border.all(color: Colors.white, width: 2)
                                          ),    
                                          child: CircleAvatar(
                                            radius: 100.0,
                                            backgroundColor: AppColors.PRIMARY_COLOR,
                                            backgroundImage: NetworkImage(discussionList[index]['last_post']['profile_picture']),
                                          ),
                                        ),
                                        ) :Container()                                    
                                      ],
                                    ) 
                                    : 
                                    
                                    Container(
                                      height: 29.0,
                                      width: 29.0,
                                      decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.TRANSPARENT),
                                      child: Container(
                                      alignment: Alignment.center,
                                      child: new Icon(GeminiIcon.profile,size: 15, color: AppColors.PRIMARY_COLOR)),
                                    ),
                                  ),
                                  title : (discussionList[index]['title'] !="") ? 
                                  Container(
                                    margin: EdgeInsets.only(left:0,top:14,right: 30),
                                    child: Text(isVarEmpty(discussionList[index]['title']).toString(),
                                      style: AppCss.blue16semibold,maxLines:1,overflow: TextOverflow.ellipsis,
                                    ),
                                  ) : Container(),                         
                                  trailing: Container(
                                    width: 56,
                                    height: 17.0,
                                    child: Material(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: AppColors.PALE_GREEN,width: 0.5,style: BorderStyle.solid),borderRadius: BorderRadius.circular(50)
                                      ),
                                      color: AppColors.PALE_GREEN,
                                      child: MaterialButton(
                                        padding: EdgeInsets.fromLTRB(1, 2, 1, 2),
                                        onPressed:() {
                                          var postTopicId = discussionList[index]['id'];                       
                                          var url="/post/$postTopicId";                              
                                          Navigator.of(context).pushReplacement(
                                            new MaterialPageRoute( 
                                            settings:  RouteSettings(name:url),
                                            builder: (context) => new Post(
                                              topicId : postTopicId!
                                              ) 
                                            )
                                          ); 
                                        },
                                        textColor: AppColors.DEEP_BLUE,
                                        child :Text.rich(
                                        TextSpan(
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text: totalPost,
                                              style: AppCss.grey8medium,
                                            ),                                                    
                                            TextSpan(
                                              text: " +posts",
                                              style: AppCss.grey8medium,
                                            )
                                          ]
                                        )
                                        ), 
                                      ),),
                                  ),
                                  onTap: () {
                                    var postTopicId =discussionList[index]['id'];                       
                                    var url="/post/$postTopicId";                              
                                    Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute( 
                                      settings:  RouteSettings(name:url),
                                      builder: (context) => new Post(topicId : postTopicId) 
                                      )
                                    ); 
                                  },
                                ),
                                SizedBox(height: 0),
                                ListTile(
                                   onTap: () {
                                    var postTopicId =discussionList[index]['id'];                       
                                    var url="/post/$postTopicId";                              
                                    Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute( 
                                      settings:  RouteSettings(name:url),
                                      builder: (context) => new Post(
                                        topicId : postTopicId!
                                        ) 
                                      )
                                    ); 
                                  },
                                  title: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children : [
                                      (discussionList[index]['instruction'] !="") ? 
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: const EdgeInsets.only(left: 50,right:20,bottom:2),
                                        child: Text(discussionList[index]['instruction'],
                                        style: AppCss.grey12regular,maxLines: 3,overflow: TextOverflow.ellipsis)
                                      ) : Container(),
                                      ((discussionList[index]['first_post'] !=null) && (discussionList[index]['last_post'] !=null)) ?
                                        Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(top:2.0,left:50,bottom: 27),
                                          child: Text.rich(
                                          TextSpan(
                                            text: "Last post" +' ' +(discussionList[index]['last_post']['created_at']) +" by",
                                            style : AppCss.mediumgrey8medium,
                                            children: <InlineSpan>[
                                              WidgetSpan(
                                                child: SizedBox(width: 3)
                                              ),                                              
                                              TextSpan(
                                                text:isVarEmpty(discussionList[index]['first_post']['first_name'])+' ' +isVarEmpty(discussionList[index]['first_post']['last_name']),
                                                style: AppCss.green8medium,
                                              )
                                            ]
                                          )
                                          ),
                                        ) : 
                                     SizedBox(height:25)
                                    ]
                                  ),                                  
                                  trailing: Container(
                                    child : Icon(GeminiIcon.icon_chevron_thin,size: 15, color: AppColors.DEEP_BLUE),
                                    // child: Image.asset("assets/images/icons/chevron-thin/chevron-thin.png",width: 9.0, height: 15.32)
                                    ),
                                 ),
                                ]
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
    );
  }
}
