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

import '../../home.dart';

class PostDetails extends StatefulWidget {
 final String postId;
  const PostDetails({Key? key,required this.postId,}) : super(key: key);
  @override
  __PostDetailsState createState() => __PostDetailsState();
}

class __PostDetailsState extends State<PostDetails> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  var currentSelectedValue;
  var postsDetail;
  var firstName;
  var lastName;
  var createdAt;
  var profilePicture;
  var postTitle;
  var postText;
  var totalReply;
  var likes;
  var postImage;
  var postId;
  var indexpostId;
  var postActivity = {};
  var postTopicTitle;
  var postTopicId;
  bool isPostLiked = false;
  bool isFollow = false;
  bool isLiked = false; 
  bool selfPost =false;
  var listActivity = {};

  void initState() {   
    postId = isVarEmpty(this.widget.postId);    
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    postDetails();
    super.initState();
  }

  Future<void> postDetails() async {
    try {
      final data = await getPostReply(<String, dynamic>{"post_id": this.widget.postId,"reply_content " : 0});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          firstName = data['data']['post']['first_name'];
          lastName = data['data']['post']['last_name'];
          createdAt = data['data']['post']['created_at'];
          profilePicture = data['data']['post']['profile_picture'];
          postTitle = data['data']['post']['title'];
          indexpostId = data['data']['post']['post_id'];
          selfPost = data['data']['post']['is_self_post'];
          postText = data['data']['post']['text'];
          likes = data['data']['post']['likes'];
          totalReply = data['data']['post']['total_reply'];
          isFollow = data['data']['post']['is_follow'];
          isLiked = data['data']['post']['is_like'];
          postImage = data['data']['post']['image'];
          postTopicTitle = data['data']['post_topic']['title'];
          postTopicId = data['data']['post_topic']['id'];
          postActivity[indexpostId] = {
            'is_like': isLiked,
            'is_follow': isFollow,
            'likes': likes
          };
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

  likeUnlike(postID) async {
    final data = await likeUnlikePost(<String, dynamic>{"post_id": postID});
    if (data['status'] == "success") {

      if (postActivity.containsKey(postID)) {
        var isLike = !postActivity[postID]['is_like'];
        var likes = int.parse(postActivity[postID]['likes']);
        postActivity[postID]['is_like'] = isLike;
        postActivity[postID]['likes'] = (likes+(isLike?1:-1)).toString();
        setState(() {
          postActivity : postActivity;
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

  Future<void> followPost(postID) async {
    try {
      final data = await followPosts(<String, dynamic>{"post_id": postID});
      if (data['status'] == "success") {
        setState(() { 
          if (postActivity.containsKey(postID)) {
          postActivity[postID]['is_follow'] = !postActivity[postID]['is_follow'];
          setState(() {
            postActivity;
          });
        }
        });
      } else {
        if (data['is_valid']) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          toast(data['msg']);
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


  Future<void> deletepost(postID) async {
    try {
      final data = await deletePost(<String, dynamic>{"post_id": postID});
      if (data['status'] == "success") {
        setState(() { 
         Navigator.of(context, rootNavigator: true).pop();
        });
        var postId = isVarEmpty(data['data']['post_id']);                
        var url="/post-details/$postId"; 
        Navigator.pushNamed(context, url,arguments: {postId : postId});
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

  @override
  Widget build(BuildContext context) {
    if (postActivity.length <= 0) {
      return Container();
    }
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
          '/post/$postTopicId',
          skiplink = false,
          '/',
          headingtext = isVarEmpty(postTopicTitle).toString(),
          isMsgActive =false,  
          isNotificationActive=false,
          context),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[                  
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 20, left: 20, right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 500,
                        child: Container(
                          decoration: BoxDecoration(
                          color: AppColors.PRIMARY_COLOR,
                          borderRadius: new BorderRadius.circular(10.0),                           
                          boxShadow: [
                            BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 3,offset: Offset(0, 3))
                          ],
                          ),
                          child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Row(
                                children: <Widget>[
                                  Padding(
                                    padding:const EdgeInsets.only(right: 10.0, top: 20, bottom: 7),
                                    child: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    child: CircleAvatar(
                                      radius: 100.0,
                                      backgroundColor: AppColors.PRIMARY_COLOR,
                                       backgroundImage:(profilePicture !="") ?   NetworkImage(isImageCheck(profilePicture)) : NetworkImage("https://pub1.brightoutcome-dev.com/gemini/admin/assets/images/default-avatar.png")
                                    ),
                                  ), 	
                                  ),
                                  Padding(
                                    padding:const EdgeInsets.only(top: 22),
                                    child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        isVarEmpty(firstName) +' ' +
                                        isVarEmpty(lastName),style: AppCss.green12semibold,
                                        overflow:TextOverflow.ellipsis,
                                      ),
                                      Padding(
                                        padding:const EdgeInsets.only(top: 2.0),
                                        child: (createdAt !=null) ? Text(dateTimeFormate(createdAt),
                                        style: AppCss.mediumgrey8medium) : Container(),
                                      ),
                                    ],
                                    ),
                                  ),
                                 Divider(height: 35.0),                                  
                                ],
                              ), 
                              trailing: (postActivity[postId]['is_follow'] !=null) ?  
                              Container(
                              width: 66,
                              height: 20,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: AppColors.DEEP_BLUE,width: 1,style: BorderStyle.solid),borderRadius: BorderRadius.circular(50)
                                ),
                                color: AppColors.DEEP_BLUE,
                                child: MaterialButton(
                                   onPressed:() {
                                    followPost(postId);
                                  },
                                  textColor: AppColors.DEEP_BLUE,
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
                                ),),
                              ) : Container(
                              width: 66,
                              height: 20,
                              child: Material(
                              shape: RoundedRectangleBorder(side: BorderSide(color: AppColors
                              .DEEP_BLUE,width:1,style: BorderStyle.solid),
                              borderRadius:BorderRadius.circular(50)),
                              color: AppColors.PRIMARY_COLOR,
                                child: MaterialButton(
                                  padding:const EdgeInsets.fromLTRB(1,5,1,4),
                                  onPressed:() {
                                    followPost(postId);
                                  },
                                  textColor:AppColors.DEEP_BLUE,
                                  child: Text("Follow post",style: AppCss.blue8bold),
                                ),
                                ),),                                                  
                              onTap: () {}, 
                            ),
                            (postTitle !="") ?
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
                              child: Text(isVarEmpty(postTitle),style: AppCss.blue20semibold,textAlign: TextAlign.left),
                            ) : Container(),
                            (postText !="") ?
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
                              child: Text(isVarEmpty(postText),style: AppCss.grey12regular,textAlign: TextAlign.left),
                            ) : Container(),
                            Container(
                              padding: const EdgeInsets.only(left: 20.0, top: 14, right: 20.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.zero,
                              ),child: Image.network(isImageCheck(postImage),
                              width: 295.0,
                              height: 371.51,
                              fit: BoxFit.fill),
                            ), 
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, top: 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(GeminiIcon.like_grey,size: 11,color: AppColors.MEDIUM_GREY2),
                                  Padding(
                                    padding:const EdgeInsets.only(left: 5.0),
                                    child: Text(isVarEmpty(postActivity[postId]['likes']).toString(),style: AppCss.mediumgrey10regular),
                                  ),
                                  Padding(
                                    padding:const EdgeInsets.only(left: 13.0, top: 1),
                                    child: Icon(GeminiIcon.comment_grey,size: 11,color: AppColors.MEDIUM_GREY2),
                                  ),
                                  Padding(
                                    padding:const EdgeInsets.only(left: 5.0),
                                   child: Text(isVarEmpty(totalReply).toString(),
                                      style: AppCss.mediumgrey12regular),
                                  )
                                ],
                              ),
                          ),  
                          Divider(height: 10.0),
                          ListTile(
                            title: InkWell(
                              onTap: () {
                                likeUnlike(postId);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  postActivity[postId]['is_like'] ? Icon(GeminiIcon.like_green,size: 12,color: AppColors.EMERALD_GREEN): Icon(GeminiIcon.like_blue,size: 12,color: AppColors.DEEP_BLUE,),
                                  SizedBox(width: 4.0),
                                  Text('Like', style: AppCss.blue12semibold),
                                ],
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, bottom: 10.0, top: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              var url="/edit-post/$postId";                              
                                              Navigator.of(context).pushReplacement(
                                                new MaterialPageRoute( 
                                                settings:  RouteSettings(name:url),
                                                builder: (context) => new EditPost(
                                                  postId : isVarEmpty(postId)
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
                                             deletepost(postId);
                                            },
                                            child: Row(
                                            children: [
                                              SvgPicture.asset('assets/images/icons/trash/trash.svg',
                                              width: 10.8,height: 12),
                                              SizedBox(width: 5.0),
                                              Text('Delete',style: AppCss.blue12bold),
                                            ],
                                          ), 
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 295,
                            height: 36,
                            margin: EdgeInsets.only(bottom: 20),
                            child: Material(
                              shape: RoundedRectangleBorder(side: BorderSide(color:AppColors.PALE_BLUE,width: 1,
                              style:BorderStyle.solid),
                              borderRadius:BorderRadius.circular(50)),
                              color: AppColors.PALE_BLUE,
                              child: MaterialButton(
                                padding:const EdgeInsets.fromLTRB(1, 5, 1, 4),
                                onPressed: () {
                                  var postId = isVarEmpty(this.widget.postId);                   
                                  var url="reply-post/$postId";                              
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
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: MaterialButton(
                      onPressed: () {
                        var type = "community";                
                        var url="/home";                              
                        Navigator.of(context).pushReplacement(
                          new MaterialPageRoute( 
                          settings:  RouteSettings(name:url),
                          builder: (context) => new Home(
                            type : type,
                          ) 
                          )
                        );
                      },
                      child: Text("Go back to the community homepage",
                          style: AppCss.green12semibold,
                          textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
           ),	
          floatingActionButton: floatingactionbuttion(context),	
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,	
          bottomNavigationBar: footer(ishomepageactive = true,isclassespageactive = false,islibyrarypageactive = false,	ismorepageactive = false,context)
        ),	
    ]);	
  }	
}	
