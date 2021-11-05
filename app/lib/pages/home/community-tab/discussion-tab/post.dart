import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/edit-post.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/reply-post.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';
import 'package:gemini/services/post.dart';
import 'create-post.dart';

class Post extends StatefulWidget {
  final String topicId;
  const Post({Key? key,required this.topicId}) : super(key: key);
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var currentSelectedValue;
  var postsList = [];
  var topicId;
  var postId;
  var postids;
  var isFollow;
  var title;
  var postTopicTitle;
  bool isPostLiked = false;
  var idIndex;
  var listActivity = {};
  late int likeCount;
  int one =1 ;
  var likesCount;
  dynamic isSelfPost;

  void initState() {  
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    allPosts();
    super.initState();
  }

  Future<void> allPosts() async {
    try {
      final data = await getPostList(<String, dynamic>{"post_topic_id": widget.topicId});
      if (data['status'] == "success") {       
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          postTopicTitle = (data['data']['post_topic']['title']);
          postsList = data['data']['posts'];
          postsList.forEach((list) {
            idIndex = list['post_id'];
            listActivity[idIndex] = {
              'is_like': list['is_like'],
              'likes': list['likes'],
              'is_follow' : list['is_follow'],
              "likeCount": list['likes'],
            };
          });
        }); 
      } else {      
        if (data['is_valid']) {	
          setState(() {	
            Navigator.of(context, rootNavigator: true).pop();	
          });	
          Navigator.pushNamed(context, 'signin');
          errortoast(data['msg']);
        } else {	
          Navigator.pushNamed(context, 'home');
          errortoast(data['msg']);	
        }	
      }	
   } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }

  Future<void> deletepost(postID) async {
    try {
      final data = await deletePost(<String, dynamic>{"post_id": postID});
      if (data['status'] == "success") {
        setState(() { 
         Navigator.of(context, rootNavigator: true).pop();
        });
        var postTopicId = isVarEmpty(widget.topicId);                
        var url="/post/$postTopicId"; 
        Navigator.pushNamed(context, url,arguments: {postId : postTopicId});
        toast(data['msg']);
      } else {
        if (data['is_valid'] == false) {	
          setState(() {	
            Navigator.of(context, rootNavigator: true).pop();	
          });
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

  Future<void> followPost(postID) async {
    try {
      final data = await followPosts(<String, dynamic>{"post_id": postID});
      if (data['status'] == "success") {        
        setState(() {
          if (listActivity.containsKey(postID)) {
          listActivity[postID]['is_follow'] = !listActivity[postID]['is_follow'];
          setState(() {
            listActivity: listActivity;
          });
        }
        });
      } else {
        if (data['is_valid']) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.pushNamed(context, 'signin');
          errortoast(data['msg']);
        } else {
          Navigator.of(context, rootNavigator: true).pop();
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }	

  likeUnlike(postID) async {
    final data = await likeUnlikePost(<String, dynamic>{"post_id": postID});
    if (data['status'] == "success") {
      if (listActivity.containsKey(postID)) {
        var isLike = !listActivity[postID]['is_like'];
        var likes = int.parse(listActivity[postID]['likes']);
        listActivity[postID]['is_like'] = isLike;
        listActivity[postID]['likes'] = (likes+(isLike?1:-1)).toString();
        setState(() {
          listActivity: listActivity;
        });
      }
    } else {
      if (data['is_valid']) {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        });
        toast(data['msg']);
      } else {
        Navigator.pushNamed(context, '/');
        Navigator.of(context, rootNavigator: true).pop();
        errortoast(data['msg']);
      }
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
        appBar: header(
          logedin = true,
          back = true,
          logo = false,
          skip = false,
          backlink = true,
          '/home',
          skiplink = false,
          '/',
          headingtext = isVarEmpty(postTopicTitle).toString(),
          isMsgActive =false,
          isNotificationActive=false,
          context),
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ), 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, bottom: 10, top: 16),
                      //   child: Text("Buddies who are active in this discussion",style: AppCss.grey12regular,
                      //   textAlign: TextAlign.center),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20, right: 20),
                      //   child: Buddies(userId: ''),
                      // ),
                      Container(
                        padding: const EdgeInsets.only(top: 16,left: 22, right: 22),                        
                        child: Text.rich(
                          TextSpan(
                            text: "This week’s discussion topic is :  ",
                            style : AppCss.grey12regular,
                            children: <InlineSpan>[
                              TextSpan(
                                text: isVarEmpty(postTopicTitle).toString(),
                                style: AppCss.grey12bold,
                              )
                            ]
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40,bottom: 30,top: 19),
                        child: buttion(
                          btnwidth = 295,
                          btnheight = 44,
                          btntext = 'Add your thoughts'.toUpperCase(),
                          AppCss.blue14bold,
                          AppColors.LIGHT_ORANGE,
                          btntypesubmit = true, () {
                          var topicId = isVarEmpty(this.widget.topicId);                
                          var url="/create-post/$topicId";                              
                          Navigator.of(context).pushReplacement(
                            new MaterialPageRoute( 
                            settings:  RouteSettings(name:url),
                            builder: (context) => new CreatePost(
                              topicId : topicId,
                              postTitle : isVarEmpty(postTopicTitle).toString()
                              ) 
                            )
                          );
                        }, 13, 11, 43, 42, context),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: postsList.isEmpty ? 
                        Container(
                          margin: const EdgeInsets.only(top:150,bottom: 150,left: 40,right: 40),
                          child: Text("No posts yet.",style: AppCss.grey12medium,textAlign: TextAlign.center,),
                        ) 
                        : Container(
                          margin: EdgeInsets.only(left: 20,right: 20,bottom: 30),
                          child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>	
                          Container(margin: EdgeInsets.only(bottom: 16)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: postsList.length,
                          itemBuilder: (context, index) {
                          isPostLiked = postsList[index]['is_like'];
                          postId = postsList[index]['post_id'];
                          isFollow = postsList[index]['is_follow'];
                          likesCount = listActivity[postsList[index]['post_id']]['likeCount'].toString();
                          return Container(
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
                          child: Column(
                            children: [
                            ListTile(
                              title: Row(
                                children: <Widget>[                                  
                                  Container(
                                    margin: EdgeInsets.only(top:10),
                                    height: 30.0,
                                    width: 30.0,
                                    child: CircleAvatar(
                                      radius: 100.0,
                                      backgroundColor: AppColors.PRIMARY_COLOR,
                                      backgroundImage:(postsList[index]['profile_picture'] !=null) ?   NetworkImage(isImageCheck(postsList[index]['profile_picture'])) : NetworkImage("https://pub1.brightoutcome-dev.com/gemini/admin/assets/images/default-avatar.png")
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding:const EdgeInsets.only(top: 12,left: 10),
                                    child : Column(                                     crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text.rich(
                                          TextSpan(
                                            text: isVarEmpty(postsList[index]['first_name']),
                                            style : AppCss.green12semibold,
                                            children: <InlineSpan>[
                                              WidgetSpan(child: SizedBox(width: 3)),
                                              TextSpan(
                                                text: isVarEmpty(postsList[index]['last_name']),
                                                style: AppCss.green12semibold,
                                              )
                                            ]
                                          )
                                        ),
                                      (postsList[index]['created_at'] !=null)
                                      ? Text(dateTimeFormate(postsList[index]['created_at']),
                                      style: AppCss.mediumgrey8medium) : Container(),
                                      ],
                                    ),
                                  ),                              
                                ],
                              ),                             
                              trailing: listActivity[postsList[index]['post_id']]['is_follow'] ?
                              // InkWell(
                              //   onTap: () {
                              //     followPost(postsList[index]['post_id']);
                              //   },
                              //   child: Container(             
                              //     width: 66,
                              //     height: 20,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(50),
                              //       color:AppColors.DEEP_BLUE,
                              //     ),
                              //     child: Container(
                              //       width: 66,
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(50),
                              //         color: AppColors.DEEP_BLUE,
                              //       ),
                              //       child: Text.rich(
                              //         TextSpan(
                              //         children: <InlineSpan>[
                              //         WidgetSpan(
                              //           child: SizedBox(width: 6)
                              //         ),                  
                              //         WidgetSpan(
                              //           child: Image.asset('assets/images/icons/green-right-check/check@3x.png',width: 7.0,
                              //           height: 5),
                              //         ),
                              //           WidgetSpan(
                              //           child: SizedBox(width: 5)
                              //         ),
                              //         TextSpan(
                              //           text: "Following",
                              //           style: AppCss.white8medium,
                              //         ),                
                              //         ])
                              //       ),
                              //     ),
                              //   ),
                              // )
                              Container(
                              width: 66,
                              height: 20,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: AppColors.DEEP_BLUE,width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.circular(50)
                                ),
                                color: AppColors.DEEP_BLUE,
                                child: MaterialButton(
                                  padding: EdgeInsets.fromLTRB(1, 2, 1, 2),
                                  autofocus: false,
                                  elevation: 0,
                                  splashColor: Colors.transparent,
                                  hoverElevation: 0,
                                  onPressed:() {
                                    followPost(postsList[index]['post_id']);
                                  },
                                  child : Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      WidgetSpan(
                                        child:  Padding(
                                          padding: const EdgeInsets.only(left:0,right:5.0,bottom: 4),
                                          child: Image.asset('assets/images/icons/green-right-check/check@3x.png',width: 7.0,height: 5),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Following",
                                        style: AppCss.white8medium,
                                      )
                                    ]
                                  )
                                  ), 
                                ),
                              ),
                              )                              
                              :
                              // InkWell(
                              //   onTap: () {
                              //     followPost(postsList[index]['post_id']);
                              //   },
                              //   child: Container(
                              //     width: 66,
                              //     height: 21,
                              //     decoration: BoxDecoration(
                              //       border: Border.all(color:AppColors.DEEP_BLUE),
                              //       borderRadius: new BorderRadius.circular(50.0), 
                              //     ),
                              //     child: Container(
                              //       padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                              //       child: Text("Follow post",style: AppCss.blue8bold,textAlign: TextAlign.center)
                              //     ),
                              //   ),
                              // ) 
                              
                              Container(
                                width: 66,
                                height: 20,
                                child: Material(
                                shape: RoundedRectangleBorder(side: BorderSide(color: AppColors
                                .DEEP_BLUE,width:1,style: BorderStyle.solid),
                                borderRadius:BorderRadius.circular(50)),
                                color: AppColors.PRIMARY_COLOR,
                                  child: MaterialButton(
                                    padding: EdgeInsets.fromLTRB(1, 2, 1, 2),
                                    autofocus: false,
                                    elevation: 0,
                                    splashColor: Colors.transparent,
                                    hoverElevation: 0,
                                    onPressed:() {
                                      followPost(postsList[index]['post_id']);
                                    },
                                    child: Text("Follow post",style: AppCss.blue8bold),
                                  ),
                                ),
                              ),   
                            ),
                            (postsList[index]['title'] !="") ?  Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
                              child: Text(isVarEmpty(postsList[index]['title']),
                              style: AppCss.blue16semibold,textAlign: TextAlign.left),
                            ): Container(),
                            (postsList[index]['text'] !="") ? 
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
                              child: Text(postsList[index]['text'],
                              style: AppCss.grey12regular,textAlign: TextAlign.left,maxLines: 4,overflow: TextOverflow.ellipsis)) : Container(),
                            Container(
                            alignment: Alignment.topLeft,                              
                            padding: const EdgeInsets.only(left: 18.0, top: 5,bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(GeminiIcon.like_grey,size: 12,color: AppColors.MEDIUM_GREY2),
                                SizedBox(width: 5.0),
                                Text(isVarEmpty(listActivity[postsList[index]['post_id']]['likes']),style: AppCss.mediumgrey10regular),
                                SizedBox(width: 8.0),
                                Icon(GeminiIcon.comment_grey,size: 11.5,color: AppColors.MEDIUM_GREY2),
                                SizedBox(width: 5.0),
                                Text((postsList[index]['total_reply'] !=null)? postsList[index]
                                  ['total_reply']: '',style: AppCss.mediumgrey10regular)
                              ],
                            ),
                          ),
                          Container(
                          margin: EdgeInsets.only(left: 19.5, right: 19.5),
                          child: Divider(height: 5.0)),
                          ListTile(
                            title: InkWell(
                              onTap: () {
                                likeUnlike(postsList[index]['post_id']);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  listActivity[postsList[index]['post_id']]['is_like'] ? Icon(GeminiIcon.like_green,size: 12,color: AppColors.EMERALD_GREEN): Icon(GeminiIcon.like_blue,size: 12,color: AppColors.DEEP_BLUE,),
                                  SizedBox(width: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(top:3.0),
                                    child: Text('Like', style: AppCss.blue12semibold),
                                  ),
                                ],
                              ),
                            ),
                            trailing: 
                            (postsList[index]['is_self_post'] == true) ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        var postid = postsList[index]['post_id'];
                                        var url="/edit-post/$postid";                              
                                        Navigator.of(context).pushReplacement(
                                          new MaterialPageRoute( 
                                          settings:  RouteSettings(name:url),
                                          builder: (context) => new EditPost(
                                            postId : isVarEmpty(postid)
                                            ) 
                                          )
                                        );
                                      },
                                      child: Row(
                                      children: [
                                        Icon(GeminiIcon.edit,size: 12.5,color: AppColors.DEEP_BLUE),
                                        SizedBox(width:5.0),
                                        Text('Edit', style: AppCss.blue12bold),
                                      ],
                                    ), 
                                    ),
                                    SizedBox(width: 10.0),
                                    InkWell(
                                      onTap: (){
                                        deletepost(postsList[index]['post_id']);
                                      },
                                      child: Row(
                                      children: [
                                        Image.asset('assets/images/icons/trash/trash.png',
                                        width: 10.8,height: 12),
                                        SizedBox(width: 5.0),
                                        Text('Delete',style: AppCss.blue12bold),
                                      ],
                                    ), 
                                    )
                                  ],
                                ),
                              ],
                            ) :
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children : [
                               (postsList[index]['total_reply'] !="0")?
                               InkWell(
                                onTap: (){
                                  var postId = isVarEmpty(postsList[index]['post_id']);                   
                                  var url="/reply-post/$postId";                              
                                  Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute( 
                                    settings: RouteSettings(name:url),
                                    builder: (context) => new ReplyPost(
                                      postId : postId
                                      ) 
                                    )
                                  ); 
                                },
                                child: Row(
                                children: [
                                  Icon(GeminiIcon.comment_blue,size: 12,color: AppColors.DEEP_BLUE),
                                  SizedBox(width: 5.0),
                                  Padding(
                                    padding: const EdgeInsets.only(top:0.5),
                                    child: Text('See replies',style: AppCss.blue12bold),
                                  ),
                                ],
                                ),
                              )
                              : Container(
                                child: Text("No replies yet",style: AppCss.mediumgrey12italic,),
                              )
                               ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Container(
                              width: 295,
                              height: 36,
                              child: Material(
                                shape: RoundedRectangleBorder(side: BorderSide(color:AppColors.PALE_BLUE,width: 1,
                                style:BorderStyle.solid),
                                borderRadius:BorderRadius.circular(50)),
                                color: AppColors.PALE_BLUE,
                                child: MaterialButton(
                                  padding:const EdgeInsets.fromLTRB(1, 5, 1, 4),
                                  onPressed: () {
                                    var postId = isVarEmpty(postsList[index]['post_id']);                   
                                    var url="/reply-post/$postId";                              
                                    Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute( 
                                      settings:  RouteSettings(name:url),
                                      builder: (context) => new ReplyPost(
                                        postId : postId
                                        ) 
                                      )
                                    ); 
                                  },
                                  textColor:AppColors.DEEP_BLUE,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/images/icons/reply.svg',width: 18.0,height: 13.5),
                                      SizedBox(width: 5),
                                      Text("REPLY",style: AppCss.blue13bold),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ]
                          ),
                      );},
                      ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          floatingActionButton: floatingactionbuttion(context),
          floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: footer(
              ishomepageactive = false,
              isclassespageactive = true,
              islibyrarypageactive = false,
              ismorepageactive = false,
              context))
    ]);
  }
}
