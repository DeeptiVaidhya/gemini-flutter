import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/more/public-profile.dart';
import 'package:gemini/pages/widget/helper.dart';

postView({post,replyPostActivity,bool isMainPost = false,onPostChange,onReply,onReplyChange,replyData,context,
onFollow = ''}) {
  if (post?.isEmpty ?? true) {
    return Container();
  }

  dynamic postId = isVarEmpty(post['post_id']);
  dynamic firstname = isVarEmpty(post['first_name']);
  dynamic userId = isVarEmpty(post['user_id']);
  dynamic lastname = isVarEmpty(post['last_name']);  
  dynamic profilePicture = post['profile_picture'];
  dynamic text = isVarEmpty(post['text']);
  dynamic title = isVarEmpty(post['title']);
  dynamic createdAt = post['created_at'];
  dynamic totalReply = isVarEmpty(post['total_reply']);
  dynamic replyList = post['reply'];  
  dynamic level = isVarEmpty(post['level']);
  dynamic isSelfPost = post['is_self_post']; 
  bool isLiked = false;
  bool isFollow = false;
  bool replyShow = false;
  bool showInputReply = false;
  dynamic likes = 0;

  if (replyPostActivity.containsKey(postId)) {
    isLiked = replyPostActivity[postId]['like'];
    isFollow = replyPostActivity[postId]['follow'];
    likes = replyPostActivity[postId]['likes'];
    replyShow = replyPostActivity[postId]['replyShow'];
    showInputReply = replyPostActivity[postId]['showInputReply'];
  }

  return isVarEmpty(postId) != '' ? 
    Container(
      child: Column(
      children: <Widget>[
      ListTile(
        title: Row(
          children: <Widget>[            
            Padding(
              padding:const EdgeInsets.only(right: 10.0, top: 20),
              child: Container(
                height: 30.0,
                width: 30.0,
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundColor: AppColors.PRIMARY_COLOR,
                  backgroundImage:(profilePicture !="") ? NetworkImage(profilePicture) : NetworkImage("https://pub1.brightoutcome-dev.com/gemini/admin/assets/images/default-avatar.png") ,
                ),
              ), 
            ),
            Padding(
              padding: EdgeInsets.only(top: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  isSelfPost ? 
                  Text(
                    isVarEmpty(firstname) + ' ' + isVarEmpty(lastname),style: AppCss.green12semibold,
                    overflow: TextOverflow.ellipsis,
                  ) :
                  InkWell(
                    onTap: () {
                      var url = "/public-profile/$userId";
                      Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(
                      settings: RouteSettings(name: url),
                      builder: (context) => new PublicProfile(
                      buddyUserId: userId,
                      postId: postId,
                      type: "reply-post")));
                    },
                    child: Text(
                      isVarEmpty(firstname) + ' ' + isVarEmpty(lastname),style: AppCss.green12semibold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  (createdAt != null)
                  ? Text(dateTimeFormate(createdAt),style: AppCss.mediumgrey8medium)
                  : Container(),
                ],
              ),
            ),
          ],
        ),
        trailing: (level <= 1) ? 
        (isFollow == false) ? 
        InkWell(
          onTap: () {
            if (onFollow != '') {
              onFollow(!isFollow);
            }
          },
          child: Container(
            width: 66,
            height: 21,
            decoration: BoxDecoration(
              border: Border.all(color:AppColors.DEEP_BLUE),
              borderRadius: new BorderRadius.circular(50.0), 
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
              child: Text("Follow post",style: AppCss.blue8bold,textAlign: TextAlign.center)
            ),
          ),
        ) : 
        InkWell(
          onTap: () {
            if (onFollow != '') {
              onFollow(!isFollow);
            }
          },
          child: Container(             
            width: 66,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color:AppColors.DEEP_BLUE,
            ),
            child: Container(
              width: 66,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.DEEP_BLUE,
              ),
              child: Text.rich(
                TextSpan(
                children: <InlineSpan>[
                WidgetSpan(
                  child: SizedBox(width: 6)
                ),                  
                WidgetSpan(
                  child: Image.asset('assets/images/icons/green-right-check/check@3x.png',width: 7.0,
                  height: 5),
                ),
                  WidgetSpan(
                  child: SizedBox(width: 5)
                ),
                TextSpan(
                  text: "Following",
                  style: AppCss.white8medium,
                ),                
                ])
              ),
            ),
          ),
        )
        : Text(""),
        onTap: () {},
      ),
      isMainPost ?  Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
        child: Text(isVarEmpty(title).toString(),style: AppCss.blue16semibold,textAlign: TextAlign.left),
      ): Container(),
      (text !="") ?  Container(
        alignment: Alignment.topLeft,
         padding: EdgeInsets.only(top:7,left: 20, right: 20),
         child: Text(isVarEmpty(text).toString(),style: AppCss.grey12regular, textAlign: TextAlign.left,maxLines: 4,overflow: TextOverflow.ellipsis),
      ): Container(),
      Padding(
        padding: EdgeInsets.only(left: 20.0, top: 5),
        child: Row(
          children: <Widget>[
            Icon(GeminiIcon.like_grey,size: 12, color: AppColors.MEDIUM_GREY2),
            SizedBox(width: 4.0),
            Text(isVarEmpty(likes),style: AppCss.mediumgrey10regular),
            SizedBox(width: 8.0),
            Icon(GeminiIcon.comment_grey,size: 11.5, color: AppColors.MEDIUM_GREY2),
            SizedBox(width: 5.0),
            Text(isVarEmpty(totalReply),style: AppCss.mediumgrey10regular)
          ],
        ),
      ),
       Container(
          margin: EdgeInsets.only(top:5,left: 19.5, right: 19.5),
          child: Divider(height: 5.0)),
      showInputReply && !isMainPost ? Container() : 
      ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                onPostChange(postId, 'like');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                isLiked == true
                ? Icon(GeminiIcon.like_green,size: 13, color: AppColors.EMERALD_GREEN)
                : Icon(GeminiIcon.like_blue,size: 13, color: AppColors.DEEP_BLUE),
                  SizedBox(width: 5.0),
                  Padding(
                    padding: const EdgeInsets.only(top:1.0),
                    child: Text('Like', style: AppCss.blue12semibold),
                  ),
                ])),
            Container(
              child: Row(
                children: [
                  Wrap(
                    children: <Widget>[
                      level < 3
                      ? level < 2 ? 
                       InkWell(
                        onTap: (){},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[ 
                            Container(
                            margin: const EdgeInsets.only(top: 4.0, right: 3.0, left: 5.0),
                            child: Icon(GeminiIcon.comment_blue,size: 13,color: AppColors.DEEP_BLUE)
                            ),  
                            SizedBox(width: 5.0),                   
                            Padding(
                              padding: const EdgeInsets.only(top:1.0),
                              child: Text('See replies',style: AppCss.blue12bold),
                            ) 
                          ]
                        ),
                      )
                      : (isSelfPost ?
                      Row(
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
                                    onTap: (){},
                                    child: Row(
                                    children: [
                                      SvgPicture.asset('assets/images/icons/edit/edit.svg',width: 12.0,height: 12),
                                      SizedBox(width:5.0),
                                      Text('Edit', style: AppCss.blue12bold),
                                    ],
                                  ), 
                                  ),
                                  SizedBox(width: 10.0),
                                  InkWell(
                                    onTap: (){},
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
                    ) : 
                    InkWell(
                      onTap: () {
                        onPostChange(postId, 'showInputReply');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[ 
                          //Icon(GeminiIcon.reply,color: AppColors.DEEP_BLUE,size:12),
                          SvgPicture.asset('assets/images/icons/reply.svg',width: 14.67,height: 11.0),
                          SizedBox(width: 5),
                          Text('Reply',style: AppCss.blue12bold) 
                        ]
                      ),
                     )
                    )
                    : Container()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      replyInput(showInputReply, onReply, replyData, onReplyChange,onPostChange,isMainPost),  
          (!isMainPost && level < 4 && replyShow)
          ? Container(
            margin: const EdgeInsets.only(right: 19.5, left: 19.5),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                Padding(padding: EdgeInsets.only(bottom: 16)),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: replyList.length,
                itemBuilder: (context, index) {
                  var fn = replyList[index]['first_name'];
                  var ln = replyList[index]['last_name'];
                  var rpostId = replyList[index]['post_id'];
                  return Container(
                    width: 500,
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: AppColors.LIGHT_GREY)),
                    ),
                    child: postView(
                      post: replyList[index],
                      replyPostActivity: replyPostActivity,
                      onPostChange: (id, key) {
                        onPostChange(id, key);
                      },
                      onReplyChange: (replyOnPostId, replyText, isValid) {
                        onReplyChange( replyOnPostId, replyText, isValid);
                      },
                      onReply: (replyOnPostId, replyText) {
                        onReply(replyOnPostId, replyText);
                      },
                      replyData: {
                        'firstname': fn,
                        'lastname': ln,
                        'replyOnPostId': rpostId,
                        'isValidReply': false,
                        'replyText': '',
                      })
                  ) ;
                }),
            ),
          )
          : Container(),
          (replyList.isNotEmpty && level < 4 && !isMainPost && (replyShow ||!showInputReply))
          ? Container(
            width: 295,
            height: 36,
            margin:const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Material(
            shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.DEEP_BLUE,width: 1,
            style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(50)),
              color: AppColors.PRIMARY_COLOR,
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(57, 5, 56, 4),
                onPressed: () => {},
                textColor: AppColors.DEEP_BLUE,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/icons/blue-icon-comment/comment.svg',width: 14.35,
                    height: 12),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        onPostChange(postId, 'replyShow');
                      },
                      child: Wrap(
                        children: <Widget>[
                        Text((replyShow? "See less replies": "View more replies").toUpperCase(),style: AppCss.blue13bold),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    Text("($totalReply)".toString(),
                        style: AppCss.mediumgrey10regular)
                  ],
                ),
              ),
            ),
          )
          : Container(),
        ]))
      : Container();
}

replyInput(showInputReply, onReply, replyData, onReplyChange,onPostChange,isMainPost) {
  var firstname = replyData.containsKey('firstname') ? replyData['firstname'] : '';
  var lastname = replyData.containsKey('lastname') ? replyData['lastname'] : '';
  var replyOnPostId = replyData.containsKey('replyOnPostId') ? replyData['replyOnPostId'] : '';
  var isValidReply = replyData.containsKey('isValidReply') ? replyData['isValidReply'] : false;
  var replyText = replyData.containsKey('replyText') ? replyData['replyText'] : '';
  return showInputReply
      ? Column(
        children: [
         Form(
            child: Container(
              width: 295,
              height: isValidReply! ? 76 : 36,
              margin: EdgeInsets.only(top:0,bottom:19),
              child: TextFormField(
                  maxLines: 4,
                  style: AppCss.grey12regular,
                  onChanged: (value) {
                    var isValid = value.length > 0;
                    replyText = value;
                    onReplyChange(replyOnPostId, replyText, isValid); 
                  },
                  onSaved: (e) => replyText = e!,
                  decoration: InputDecoration(
                    contentPadding:EdgeInsets.only(left: 11.57, top: 16, bottom: 9),
                    hintText: '@' +isVarEmpty(firstname) +' ' +isVarEmpty(lastname) +' Type your reply',
                    hintStyle: AppCss.mediumgrey12light,
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(color: AppColors.LIGHT_GREY),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: AppColors.LIGHT_GREY),
                    ),
                    suffixIcon: Container(
                      margin: isValidReply! ? EdgeInsets.only(top:35,bottom: 10) : EdgeInsets.fromLTRB(0, 6.46, 6.0, 5.98),
                      child: Container(
                        //padding: EdgeInsets.fromLTRB(0, 6.46, 6.0, 5.98),
                        width: 24,
                        height: 24,
                        child: MaterialButton(
                          shape: CircleBorder(),
                          color: isValidReply! ? AppColors.LIGHT_ORANGE : AppColors.LIGHT_GREY,
                          onPressed: () {
                            isValidReply! ? onReply(replyOnPostId, replyText): print('');
                          },
                          child: Image.asset('assets/images/icons/send/send.png',width: 11.84,height: 11.34,
                          color: AppColors.PRIMARY_COLOR),
                        )),
                    ))),
            ),
          ),
          isMainPost? Container():
          Container( 
            alignment: Alignment.centerRight,           
            padding: const EdgeInsets.only(left:20.0,bottom: 20.0,right: 20),
            child: Container(
              width: 100,
              child: MaterialButton( 
              onPressed: () {
                onPostChange(replyOnPostId, 'showInputReply');             
              },
              textColor: AppColors.DEEP_BLUE,
              child: Align( alignment: Alignment.topRight,child: Text('Cancel Reply', style: AppCss.blue12bold)),
              ),
            ),
          ),
        ]
      )
      : Container();
}

//_animateToIndex(i) => animateTo(duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
