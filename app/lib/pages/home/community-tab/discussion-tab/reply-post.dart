import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';
import 'package:gemini/services/post.dart';
import '../../home.dart';
import './post-view.dart';

class ReplyPost extends StatefulWidget {
  final String postId;
  final param;
  const ReplyPost({Key? key, required this.postId, this.param})
      : super(key: key);
  @override
  _ReplyPostState createState() => _ReplyPostState();
}

class _ReplyPostState extends State<ReplyPost> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var replyList = [];
  bool visibleReply = false;
  bool ishide = true;
  bool isReply = false;
  bool isFollow = true;
  var repliesList;
  var totalReply;
  var postId;
  var replyPostActivity = {};
  var mainPost = {};
  var firstname;
  var lastname;
  var postID;
  var param;
  var userId;
  var postTopicId;
  var postTopicTitle;

  void initState() {
    postID = isVarEmpty(widget.postId);
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    allReplyPosts();
    super.initState();
  }

  Future<void> allReplyPosts() async {
    try {
      final data = await getPostReply(<String, dynamic>{"post_id": postID});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          postId = data['data']['post']['post_id'];
          replyList = data['data']['post']['reply'];
          bool isLiked = data['data']['post']['is_like'];
          bool isFollow = data['data']['post']['is_follow'];
          var likes = data['data']['post']['likes'];
          mainPost = data['data']['post'];
          firstname = data['data']['post']['first_name'];
          lastname = data['data']['post']['last_name'];
          userId = data['data']['post']['user_id'];
          postTopicTitle = data['data']['post_topic']['title'];
          postTopicId = data['data']['post_topic']['id'];

          replyPostActivity[postId] = {
            'like': isLiked,
            'likes': likes,
            'follow': isFollow,
            'replyShow': false,
            'showInputReply': true,
            'isValidReply': false,
            'replyText': ''
          };
          replyList.forEach((post) {
            replyPostActivity[post['post_id']] = {
              'like': post['is_like'],
              'follow': post['is_follow'],
              'likes': post['likes'],
              'replyShow': false,
              'showInputReply': false,
              'isValidReply': false,
              'replyText': ''
            };
            post['reply'].forEach((post) {
              replyPostActivity[post['post_id']] = {
                'like': post['is_like'],
                'follow': post['is_follow'],
                'likes': post['likes'],
                'replyShow': false,
                'showInputReply': false,
                'isValidReply': false,
                'replyText': ''
              };
            });
          });
        });
      } else {
        if (data['is_valid'] == false) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
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

  Future<void> followPost(postID) async {
    try {
      final data = await followPosts(<String, dynamic>{"post_id": postID});
      if (data['status'] == "success") {
        setState(() {
          if (replyPostActivity.containsKey(postID)) {
            replyPostActivity[postID]['follow'] = !replyPostActivity[postID]['follow'];
            setState(() {
              replyPostActivity;
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
      if (replyPostActivity.containsKey(postID)) {
        var isLike = !replyPostActivity[postID]['like'];
        var likes = int.parse(replyPostActivity[postID]['likes']);
        replyPostActivity[postID]['like'] = isLike;
        replyPostActivity[postID]['likes'] = (likes + (isLike ? 1 : -1)).toString();
        setState(() {
          replyPostActivity: replyPostActivity;
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

  Future<void> submitReply(replyOnPostId, replyText) async {
    try {
      final data = await addPost(<String, dynamic>{
        "title": "reply title",
        "text": replyText!,
        "type": "community",
        "post_topic_id": "",
        "replied_post_id": replyOnPostId,
        "post_id": "",
        "current_image_name": "",
        "image": {
          "filename": "",
          "filetype": "",
          "value": "",
        }
      });
      if (data['status'] == "error") {
      } else {
        if (data['status'] == "success") {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          var prId = isVarEmpty(widget.postId);
          var url = "/reply-post/$prId";
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              settings: RouteSettings(name: url),
              builder: (context) => new ReplyPost(postId: prId)));
          toast(data['msg']);
        } else {
          if (data['status'] == "error" && data['text']) {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
            var prId = isVarEmpty(widget.postId);
            var url = "/reply-post/$prId";
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                settings: RouteSettings(name: url),
                builder: (context) => new ReplyPost(postId: prId)));
            errortoast(data['msg']);
          } else {
            setState(() {
              Navigator.of(context, rootNavigator: true).pop();
            });
            errortoast(data['msg']);
          }
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
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
              (postTopicId != null) ? '/post/$postTopicId' : '/home',
              skiplink = false,
              '/',
              headingtext = isVarEmpty(postTopicTitle).toString(),
              isMsgActive = false,
              isNotificationActive = false,
              context),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 500),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 20, right: 20, top: 30),
                        decoration: BoxDecoration(
                          color: AppColors.PRIMARY_COLOR,
                          borderRadius: new BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.SHADOWCOLOR,
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset: Offset(0, 3))
                          ],
                        ),
                        child: Column(
                          children: [
                            postView(
                                post: mainPost,
                                replyPostActivity: replyPostActivity,
                                isMainPost: true,
                                onPostChange: (id, key) {
                                  if (key == 'like') {
                                    likeUnlike(id);
                                  } else {
                                    replyPostActivity[postId][key] = !replyPostActivity[postId][key];
                                    setState(() {
                                      replyPostActivity: replyPostActivity;
                                    });
                                  }
                                },
                                onReplyChange: (replyOnPostId, replyText, isValid) {
                                  setState(() {
                                    replyPostActivity[replyOnPostId]
                                        ['isValidReply'] = isValid;
                                    replyPostActivity[replyOnPostId]['replyText'] =
                                        replyText;
                                  });
                                },
                                onReply: (replyOnPostId, replyText) {
                                  WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
                                  submitReply(replyOnPostId, replyText);
                                },
                                replyData: {
                                  'firstname': firstname,
                                  'lastname': lastname,
                                  'replyOnPostId': mainPost['post_id'],
                                  'isValidReply': replyPostActivity.containsKey(postId) ? replyPostActivity[postId]['isValidReply']
                                  : false,
                                  'replyText': replyPostActivity.containsKey(postId) ? replyPostActivity[postId]['replyText']
                                  : ''
                                },
                                context: context,
                                onFollow: (value) {
                                  followPost(postId);
                                }),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20, right: 20),
                          child:Text("Replies", style: AppCss.blue16semibold),
                        )),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: replyList.isEmpty
                      ? Container(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 30.0,
                                left: 20,
                                right: 20),
                            child: Text("No replies yet",
                                style: AppCss.grey12medium),
                          )),
                        )
                      : Container(
                      margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                      child: ListView.separated(separatorBuilder: (BuildContext context,int index) =>
                      Container(
                        margin:EdgeInsets.only(bottom: 16)),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: replyList.length,
                        itemBuilder: (context, index) {
                        var fn = replyList[index]['first_name'];
                        var ln = replyList[index]['first_name'];
                        var rpostId = replyList[index]['post_id'];
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.PRIMARY_COLOR,
                            borderRadius: new BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                            ],
                          ),
                          child: Column(
                            children: [
                              postView(
                                post: replyList[index],
                                replyPostActivity: replyPostActivity,
                                isMainPost: false,
                                onPostChange: (postId, key) {
                                  if (key == 'like') {
                                    likeUnlike(postId);
                                  } else {
                                    replyPostActivity[postId][key] = !replyPostActivity[postId][key];
                                    setState(() {
                                      replyPostActivity: replyPostActivity;
                                    });
                                  }
                                },
                                onReplyChange:(replyOnPostId,replyText, isValid) {
                                  setState(() {
                                    replyPostActivity[replyOnPostId]['isValidReply'] = isValid;
                                    replyPostActivity[replyOnPostId]['replyText'] = replyText;
                                  });
                                },
                                onReply:(replyOnPostId, replyText) {
                                  loader(context, _keyLoader);
                                  submitReply(replyOnPostId, replyText);
                                },
                                replyData: {
                                  'firstname': fn,
                                  'lastname': ln,
                                  'replyOnPostId': rpostId,
                                  'isValidReply': replyPostActivity.containsKey(rpostId) ? replyPostActivity[rpostId]['isValidReply']
                                  : false,
                                  'replyText': replyPostActivity.containsKey(rpostId) ? replyPostActivity[rpostId]
                                  ['replyText'] : '',
                                },
                                context: context
                              ),
                            ],
                          ),
                        );
                      }),
                    )),
                    Container(
                      padding: const EdgeInsets.fromLTRB(38, 0, 37, 50),
                      child: MaterialButton(
                        autofocus: false,
                        elevation: 0,
                        splashColor: Colors.transparent,
                        hoverElevation: 0,
                        onPressed: () {
                          var type = "community";
                          var url = "/home";
                          Navigator.of(context).pushReplacement(new MaterialPageRoute(
                          settings: RouteSettings(name: url),
                          builder: (context) => new Home(type: type)));
                        },
                        textColor: AppColors.DEEP_BLUE,
                        child: Text('Go back to the community homepage',style: AppCss.green12semibold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: floatingactionbuttion(context),
          floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: footer(
              ishomepageactive = true,
              isclassespageactive = false,
              islibyrarypageactive = false,
              ismorepageactive = false,
              context)),
    ]);
  }
}
