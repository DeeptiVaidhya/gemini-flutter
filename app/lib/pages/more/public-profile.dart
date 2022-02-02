import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/reply-post.dart';
import 'package:gemini/pages/messages/create-message.dart';
import 'package:gemini/pages/widget/footer.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';
import 'package:gemini/services/post.dart';
import 'package:gemini/services/profile.dart';

class PublicProfile extends StatefulWidget {
  final String buddyUserId;
  final String type;
  final String postId;
  const PublicProfile(
      {Key? key,
      required this.buddyUserId,
      required this.type,
      required this.postId})
      : super(key: key);
  @override
  _PublicProfileState createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  var buddyUserId;
  var buddyId;
  var totalBuddies;
  var totalPosts;
  var fullName;
  var profilePicture;
  var buddiesList = [];
  var postsList = [];
  var aboutMe;
  var buddyStatus;
  var postID;
  var idIndex;
  var listActivity = {};

  void initState() {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => loader(context, _keyLoader));
    getPublicUserProfile();
    super.initState();
  }

  Future<void> getPublicUserProfile() async {
    try {
      buddyUserId = isVarEmpty(widget.buddyUserId);
      final data = await getPublicProfile(
          <String, dynamic>{"buddy_user_id": buddyUserId});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          totalBuddies = data['data']['total_buddies'];
          totalPosts = data['data']['total_posts'];
          fullName = data['data']['user_detail']['fullname'];
          buddyStatus = data['data']['user_detail']['buddy_status'];
          profilePicture = data['data']['user_detail']['profile_picture'];
          buddyId = data['data']['user_detail']['user_id'];
          buddiesList = data['data']['buddies'];
          aboutMe = data['data']['about_me'];
          postsList = data['data']['posts'];
          postsList.forEach((list) {
            idIndex = list['post_id'];
            listActivity[idIndex] = {
              'is_like': list['is_like'],
              'likes': list['likes'],
              'is_follow': list['is_follow'],
              "likeCount": list['likes'],
            };
          });
        });
      } else {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        });
        errortoast(data['msg']);
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
        listActivity[postID]['likes'] = (likes + (isLike ? 1 : -1)).toString();
        setState(() {
          listActivity:
          listActivity;
        });
      }
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
        Navigator.pushNamed(context, '/more');
        errortoast(data['msg']);
      }
    }
  }

  submitAcceptRequest(receiverUserId) async {
    final data = await acceptRequest(<String, dynamic>{
      "receiver_user_id": receiverUserId,
      "invite_status": "accepted"
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
      });
      var url = "/public-profile/$receiverUserId";
      Navigator.pushNamed(context, url,
          arguments: {receiverUserId: receiverUserId});
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
  }

  @override
  Widget build(BuildContext context) {
    postID = widget.postId;
    return Stack(children: <Widget>[
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
              (widget.type == "reply-post")
                  ? "/reply-post/$postID"
                  : '/account-details',
              skiplink = false,
              '/health-check-in',
              headingtext = (widget.buddyUserId == "")
                  ? 'My public profile'
                  : isVarEmpty(fullName),
              isMsgActive = false,
              isNotificationActive = false,
              context),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 375),
                margin: EdgeInsets.only(bottom: 57),
                child: Center(
                  child: Column(children: [
                    (profilePicture != null)
                        ? Container(
                            margin: EdgeInsets.only(
                                top: 18, right: 87, left: 88, bottom: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: (profilePicture != "")
                                  ? Image.network(profilePicture.toString(),
                                      height: 100.0,
                                      width: 100.0,
                                      fit: BoxFit.cover)
                                  : Container(
                                      height: 100.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.TRANSPARENT),
                                      child: Icon(GeminiIcon.profile,
                                          size: 60,
                                          color: AppColors.PRIMARY_COLOR)),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                                top: 18, right: 87, left: 88, bottom: 16),
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.TRANSPARENT),
                            child: Container(
                                alignment: Alignment.center,
                                child: new Icon(GeminiIcon.profile,
                                    size: 60, color: AppColors.PRIMARY_COLOR)),
                          ),
                    Text(isVarEmpty(fullName).toString(),
                        style: AppCss.blue18semibold),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: Text("Newbie",
                          style: AppCss.grey14regular,
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(isVarEmpty(totalBuddies).toString(),
                                  style: AppCss.blue16semibold),
                              Container(
                                width: 71,
                                height: 35,
                                child: Text("Buddies",
                                    style: TextStyle(
                                        height: 0,
                                        fontFamily: 'Poppins',
                                        color: AppColors.MEDIUM_GREY1,
                                        fontSize: 8.0,
                                        fontWeight: w500),
                                    textAlign: TextAlign.center),
                              )
                            ],
                          ),
                          VerticalDivider(
                            width: 15.0,
                            color: Colors.transparent,
                          ),
                          Column(
                            children: <Widget>[
                              Text(isVarEmpty(totalBuddies).toString(),
                                  style: AppCss.blue16semibold),
                              Container(
                                  width: 58,
                                  child: Text("Badges",
                                      style: TextStyle(
                                          height: 0,
                                          fontFamily: 'Poppins',
                                          color: AppColors.MEDIUM_GREY1,
                                          fontSize: 8.0,
                                          fontWeight: w500),
                                      textAlign: TextAlign.center))
                            ],
                          ),
                          VerticalDivider(
                            width: 15.0,
                            color: Colors.transparent,
                          ),
                          Column(
                            children: <Widget>[
                              Text(isVarEmpty(totalPosts).toString(),
                                  style: AppCss.blue16semibold),
                              Container(
                                  width: 58,
                                  height: 25,
                                  child: Text("Posts",
                                      style: TextStyle(
                                          height: 0,
                                          fontFamily: 'Poppins',
                                          color: AppColors.MEDIUM_GREY1,
                                          fontSize: 8.0,
                                          fontWeight: w500),
                                      textAlign: TextAlign.center)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    (buddyStatus == "me")
                        ? Container(
                            width: 175,
                            height: 36,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: AppColors.DEEP_BLUE,
                                      width: 2,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50)),
                              color: AppColors.PRIMARY_COLOR,
                              child: MaterialButton(
                                padding:
                                    const EdgeInsets.fromLTRB(35, 8, 35, 8),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed("/edit-profile");
                                },
                                textColor: AppColors.DEEP_BLUE,
                                child: Text("Edit my info".toUpperCase(),
                                    style: AppCss.blue13bold,
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.ideographic,
                            children: [
                                if (buddyStatus == "accepted")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 145,
                                        height: 36,
                                        child: Material(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: AppColors.DEEP_GREEN,
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 32),
                                              Icon(Icons.done,
                                                  size: 16,
                                                  color: AppColors.DEEP_GREEN),
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5.5, 9, 15.5, 7),
                                                child: Text(
                                                    "Buddies".toUpperCase(),
                                                    style: AppCss.green13bold,
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var userId = widget.buddyUserId;
                                          var url = "/create-message/$userId";
                                          Navigator.of(context).pushReplacement(
                                              new MaterialPageRoute(
                                                  settings:
                                                      RouteSettings(name: url),
                                                  builder: (context) =>
                                                      new CreateMessages(
                                                          userId: userId)));
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 14),
                                          child: Icon(GeminiIcon.envelope_green,
                                              size: 30,
                                              color: AppColors.DEEP_GREEN),
                                        ),
                                      )
                                    ],
                                  ),
                                if (buddyStatus == "requested")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buttion(
                                          btnwidth = 145,
                                          btnheight = 36,
                                          btntext = 'Requested'.toUpperCase(),
                                          AppCss.white13bold,
                                          AppColors.DEEP_GREEN,
                                          btntypesubmit = true,
                                          () {},
                                          9,
                                          8,
                                          15.5,
                                          15.5,
                                          context),
                                      GestureDetector(
                                        onTap: () {
                                          modalPopup(
                                              context,
                                              AppColors.DEEP_BLUE,
                                              Popupcontent(
                                                  type: '', profilePic: ''),
                                              335,
                                              426,
                                              1,
                                              "",
                                              () {});
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 14),
                                          child: Icon(GeminiIcon.envelope_green,
                                              size: 30,
                                              color: AppColors.DEEP_GREEN),
                                        ),
                                      )
                                    ],
                                  ),
                                if (buddyStatus == "accept")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buttion(
                                          btnwidth = 145,
                                          btnheight = 36,
                                          btntext = 'accept'.toUpperCase(),
                                          AppCss.white13bold,
                                          AppColors.DEEP_GREEN,
                                          btntypesubmit = true, () {
                                        submitAcceptRequest(widget.buddyUserId);
                                      }, 9, 8, 15.5, 15.5, context),
                                      GestureDetector(
                                        onTap: () {
                                          modalPopup(
                                              context,
                                              AppColors.DEEP_BLUE,
                                              Popupcontent(
                                                  type: '', profilePic: ''),
                                              335,
                                              426,
                                              1,
                                              "",
                                              () {});
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 14),
                                          child: Icon(GeminiIcon.envelope_green,
                                              size: 30,
                                              color: AppColors.DEEP_GREEN),
                                        ),
                                      )
                                    ],
                                  ),
                                if (buddyStatus == "")
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 145,
                                        height: 36,
                                        child: Material(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color: AppColors.DEEP_GREEN,
                                                  width: 1,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: MaterialButton(
                                            padding: const EdgeInsets.fromLTRB(
                                                15.5, 9, 15.5, 7),
                                            onPressed: () {
                                              modalPopup(
                                                  context,
                                                  AppColors.DEEP_BLUE,
                                                  Popupcontent(
                                                      receiverUserId:
                                                          buddyUserId,
                                                      profilePic:
                                                          profilePicture,
                                                      type: "buddy"),
                                                  335,
                                                  395,
                                                  1,
                                                  "",
                                                  () {});
                                            },
                                            textColor: AppColors.DEEP_BLUE,
                                            child: Text(
                                                "Add Buddy".toUpperCase(),
                                                style: AppCss.green13bold,
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 14),
                                        child: Icon(GeminiIcon.envelope_green,
                                            size: 30,
                                            color: AppColors.DEEP_GREEN),
                                      )
                                    ],
                                  ),
                              ]),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 500,
                          padding: const EdgeInsets.fromLTRB(20, 16, 13, 0),
                          child: Text("Buddies", style: AppCss.blue18semibold),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                        child: buddiesList.length <= 0
                            ? Container(
                                width: 500,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: AppColors.PRIMARY_COLOR,
                                  borderRadius: new BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.SHADOWCOLOR,
                                        spreadRadius: 0,
                                        blurRadius: 7,
                                        offset: Offset(0, 4))
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(
                                    "No buddies yet",
                                    style: AppCss.mediumgrey12regular,
                                    textAlign: TextAlign.left,
                                  ),
                                ))
                            : ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                            margin: EdgeInsets.only(right: 15)),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: buddiesList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Stack(
                                          alignment: Alignment.topLeft,
                                          children: <Widget>[
                                            //  Positioned(
                                            //   top: 10.0,
                                            //   left: 10.0,
                                            //   child: CircleAvatar(
                                            //     radius: 4.0,
                                            //     backgroundColor: Colors.green,
                                            //   ),
                                            // ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              child: (buddiesList[index]
                                                          ['profile_picture'] !=
                                                      "")
                                                  ? Image.network(
                                                      isImageCheck(buddiesList[
                                                              index]
                                                          ['profile_picture']),
                                                      height: 60.0,
                                                      width: 60.0,
                                                      fit: BoxFit.cover)
                                                  : Container(
                                                      height: 60.0,
                                                      width: 60.0,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: AppColors
                                                              .TRANSPARENT),
                                                      child: Icon(
                                                          GeminiIcon.profile,
                                                          size: 60,
                                                          color: AppColors
                                                              .PRIMARY_COLOR)),
                                            ),

                                            // CircleAvatar(
                                            //   radius: 30.0,
                                            //   backgroundImage: NetworkImage(isImageCheck(buddiesList[index]['profile_picture'])),
                                            //   backgroundColor: Colors.transparent,
                                            // ),
                                          ],
                                        )
                                      ]);
                                }),
                      ),
                    ),
                    (aboutMe != "")
                        ? Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 15, 13, 10),
                                    child: Text("About me",
                                        style: AppCss.blue18semibold),
                                  )),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, bottom: 24),
                                child: Container(
                                  width: 500,
                                  decoration: BoxDecoration(
                                    color: AppColors.PRIMARY_COLOR,
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.SHADOWCOLOR,
                                          spreadRadius: 0,
                                          blurRadius: 7,
                                          offset: Offset(0, 4))
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            top: 16,
                                            right: 20.0,
                                            bottom: 13),
                                        child: Text(
                                            isVarEmpty(aboutMe).toString(),
                                            style: AppCss.grey12regular,
                                            overflow: TextOverflow.visible)),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 13, 0),
                          child: Text("Recent community posts",
                              style: AppCss.blue18semibold),
                        )),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 15, bottom: 20, left: 15),
                      child: postsList.isEmpty
                          ? Container(
                              width: 500,
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColors.PRIMARY_COLOR,
                                borderRadius: new BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.SHADOWCOLOR,
                                      spreadRadius: 0,
                                      blurRadius: 7,
                                      offset: Offset(0, 2))
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                  "No post yet",
                                  style: AppCss.mediumgrey12regular,
                                  textAlign: TextAlign.left,
                                ),
                              ))
                          : Container(
                              height: 153,
                              child: ListView.separated(
                                  separatorBuilder: (BuildContext context,
                                          int index) =>
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 20.0),
                                      ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: postsList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.PRIMARY_COLOR,
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      15.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        AppColors.SHADOWCOLOR,
                                                    spreadRadius: 0,
                                                    blurRadius: 7,
                                                    offset: Offset(422, 2))
                                              ],
                                            ),
                                            child: ClipPath(
                                              clipper: ShapeBorderClipper(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15))),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                        width: 235,
                                                        child: Container(
                                                            margin:
                                                                const EdgeInsets.only(
                                                                    top: 18,
                                                                    bottom: 20),
                                                            child: Text(
                                                                (postsList[index][
                                                                            'text'] !=
                                                                        "")
                                                                    ? isVarEmpty(postsList[index]['text'])
                                                                        .toString()
                                                                    : isVarEmpty(postsList[index]
                                                                            [
                                                                            'title'])
                                                                        .toString(),
                                                                style: AppCss
                                                                    .grey12regular,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 3)),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20, right: 190),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              SvgPicture.asset(
                                                                  "assets/images/icons/like-grey/like-grey.svg",
                                                                  width: 11.96,
                                                                  height: 10),
                                                              SizedBox(
                                                                  width: 3.0),
                                                              Text(
                                                                  isVarEmpty(listActivity[postsList[index]
                                                                              [
                                                                              'post_id']]
                                                                          [
                                                                          'likes'])
                                                                      .toString(),
                                                                  style: AppCss
                                                                      .mediumgrey12regular),
                                                            ],
                                                          ),
                                                          SizedBox(width: 15.0),
                                                          Row(
                                                            children: <Widget>[
                                                              SvgPicture.asset(
                                                                  "assets/images/icons/comment/comment.svg",
                                                                  width: 11.96,
                                                                  height: 10),
                                                              SizedBox(
                                                                  width: 3.0),
                                                              Text(
                                                                  isVarEmpty(postsList[
                                                                              index]
                                                                          [
                                                                          'total_reply'])
                                                                      .toString(),
                                                                  style: AppCss
                                                                      .mediumgrey12regular),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                        height: 10.0,
                                                        color: AppColors
                                                            .LIGHT_GREY1),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () {
                                                            likeUnlike(
                                                                postsList[index]
                                                                    [
                                                                    'post_id']);
                                                          },
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              listActivity[postsList[
                                                                              index]
                                                                          [
                                                                          'post_id']]
                                                                      [
                                                                      'is_like']
                                                                  ? Icon(
                                                                      GeminiIcon
                                                                          .like_green,
                                                                      size: 12,
                                                                      color: AppColors
                                                                          .EMERALD_GREEN)
                                                                  : Icon(
                                                                      GeminiIcon
                                                                          .like_blue,
                                                                      size: 12,
                                                                      color: AppColors
                                                                          .DEEP_BLUE,
                                                                    ),
                                                              SizedBox(
                                                                  width: 4.0),
                                                              Text('Like',
                                                                  style: AppCss
                                                                      .blue12semibold),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 100.0),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20.0,
                                                                  top: 15.0,
                                                                  right: 20,
                                                                  bottom: 20),
                                                          child: InkWell(
                                                            onTap: () {
                                                              var postId = isVarEmpty(
                                                                  postsList[
                                                                          index]
                                                                      [
                                                                      'post_id']);
                                                              var url =
                                                                  "/reply-post/$postId";
                                                              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                                                                  settings:
                                                                      RouteSettings(
                                                                          name:
                                                                              url),
                                                                  builder: (context) =>
                                                                      new ReplyPost(
                                                                          postId:
                                                                              postId)));
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: <
                                                                  Widget>[
                                                                SvgPicture.asset(
                                                                    'assets/images/icons/reply.svg',
                                                                    width:
                                                                        14.67,
                                                                    height:
                                                                        11.5),
                                                                SizedBox(
                                                                    width: 5.0),
                                                                Text('Reply',
                                                                    style: AppCss
                                                                        .blue12bold),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ]);
                                  }),
                            ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          floatingActionButton: floatingactionbuttion(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: footer(
              ishomepageactive = false,
              isclassespageactive = false,
              islibyrarypageactive = false,
              ismorepageactive = true,
              context)),
    ]);
  }
}

class Popupcontent extends StatefulWidget {
  final String receiverUserId;
  final String type;
  final String profilePic;
  const Popupcontent(
      {Key? key,
      this.receiverUserId = "",
      this.type = "",
      required this.profilePic})
      : super(key: key);
  @override
  _PopupcontentState createState() => _PopupcontentState();
}

class _PopupcontentState extends State<Popupcontent> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  submitRequest(receiverUserId, context) async {
    //loader(context, _keyLoader);
    final data = await buddyInvite(
        <String, dynamic>{"receiver_user_id": receiverUserId});
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
        var url = "/public-profile/$receiverUserId";
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            settings: RouteSettings(name: url),
            builder: (context) => new PublicProfile(
                buddyUserId: receiverUserId, type: "", postId: "")));
      });
      toast(data['msg']);
    } else {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
      });
      errortoast(data['msg']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: AppColors.PRIMARY_COLOR,
          child: Column(
            children: <Widget>[
              (widget.type == "buddy")
                  ? Column(
                      children: [
                        (widget.profilePic == "")
                            ? Container(
                                width: 125,
                                height: 125,
                                decoration: new BoxDecoration(
                                  color: Color(0xFFCEECFF),
                                  borderRadius: new BorderRadius.circular(100),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(right: 105, left: 105),
                                width: 125,
                                height: 125,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(
                                    isImageCheck(widget.profilePic),
                                    width: 125,
                                    height: 125,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 27.0),
                          child: Text("Buddy requested!",
                              textAlign: TextAlign.center,
                              style: AppCss.blue26semibold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 24.0, right: 24, bottom: 19),
                          child: Text(
                              "You have requested to add Olivia Miller as a buddy. Once she accepts, you will see her in your Buddy list.",
                              textAlign: TextAlign.center,
                              style: AppCss.grey12regular),
                        ),
                        buttion(
                            btnwidth = 295,
                            btnheight = 44,
                            btntext = 'Okay'.toUpperCase(),
                            AppCss.blue14bold,
                            AppColors.LIGHT_ORANGE,
                            btntypesubmit = true, () {
                          submitRequest(widget.receiverUserId, context);
                        }, 12, 11, 27, 47, context),
                        SizedBox(height: 30)
                      ],
                    )
                  : Column(children: [
                      Container(
                        height: 125.0,
                        width: 125.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFF4F9FD)),
                        child: new Icon(GeminiIcon.envelope_green,
                            size: 40, color: AppColors.DEEP_BLUE),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 27.0),
                        child: Text("Oops!",
                            textAlign: TextAlign.center,
                            style: AppCss.blue26semibold),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 16.0, left: 24.0, right: 24, bottom: 19),
                        child: Text(
                            "You cannot send messages to users who you are not buddies with. If you have already sent this user a buddy request, you will be able to send a message once they accept your buddy request.",
                            textAlign: TextAlign.center,
                            style: AppCss.grey12regular),
                      ),
                      buttion(
                          btnwidth = 295,
                          btnheight = 44,
                          btntext = 'Okay'.toUpperCase(),
                          AppCss.blue14bold,
                          AppColors.LIGHT_ORANGE,
                          btntypesubmit = true, () {
                        Navigator.pop(context, true);
                      }, 12, 11, 27, 47, context),
                      SizedBox(height: 30)
                    ])
            ],
          )),
    );
  }
}
