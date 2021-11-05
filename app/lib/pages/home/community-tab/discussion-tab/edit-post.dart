import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/post-details.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/post.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/home.dart';
import 'package:gemini/services/post.dart';

class EditPost extends StatefulWidget {
  final String postId;
  const EditPost({Key? key, required this.postId}) : super(key: key);
  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _key = new GlobalKey<FormState>();
   final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormFieldState> _titleFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _postTextFormKey = GlobalKey<FormFieldState>();

  bool _isSubmitButtonEnabled = false;
  var fileBytes;
  var fileName; 
  var title;
  var text; 
  var postTitle;
  var postText;
  var postId;
  var postsDetail;
  var firstName;
  var lastName;
  var createdAt;
  var profilePicture;
  var totalReply;
  var likes;
  var postImage;
  var indexpostId;
  var postTopicTitle;
  var postTopicId;

  @override
  void initState() {    
    postId = isVarEmpty(widget.postId);
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    postDetails();    
    _isSubmitButtonEnabled = _isFormFieldValidOnLoad();
    super.initState();
  }

  bool _isFormFieldValidOnLoad() {
    if (isVarEmpty(title) == '') {
      return true;
    } else {
      return false;
    }
  }
  
  bool _isFormFieldValid() {    
    if (_titleFormKey.currentState!.value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  chooseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        fileBytes = file.bytes;
        fileName = file.name;
      });
    }
  }

  Future<void> postDetails() async {
    try {
      final data = await getPostReply(<String, dynamic>{"post_id": postId,"reply_content " : 0});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          profilePicture = data['data']['post']['profile_picture'];
          postTitle = data['data']['post']['title'];
          postText = data['data']['post']['text'];         
          indexpostId = data['data']['post']['post_id']; 
          postImage = data['data']['post']['image'];
          postTopicTitle = data['data']['post_topic']['title'];  
          postTopicId = data['data']['post_topic']['id'];
        });
    } else {
        if (data['is_valid']) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          toast(data['msg']);
        } else {             
          var url="/post-details/$postId";                              
          Navigator.of(context).pushReplacement(
            new MaterialPageRoute( 
            settings: RouteSettings(name:url),
            builder: (context) => new PostDetails(postId:postId
              ) 
            )
          ); 
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }

  editPost() async {
    final data = await addPost(<String, dynamic>{
      "title": _titleFormKey.currentState!.value,
      "text": _postTextFormKey.currentState!.value,
      "type": "community",
      "post_topic_id": "",
      "replied_post_id": null,
      "post_id": postId,
      "image": {
        "filename": isVarEmpty(fileName),
        "filetype": "image/jpeg",
        "value": (fileName !=null) ? base64Encode(fileBytes) : postImage,
      }
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();  
      });
      var url = "/post/$postTopicId";
      Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
      settings: RouteSettings(name: url),
      builder: (context) => new Post(topicId: postTopicId)));
      toast(data['msg']);
    } else {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        });
        var url = "/edit-post/$postId";
        Navigator.of(context).pushReplacement(
        new MaterialPageRoute(
        settings: RouteSettings(name: url),
        builder: (context) => new EditPost(
        postId: postId)));
        errortoast(data['msg']);
        if (data['is_valid'] == false) {	
          setState(() {	
            Navigator.of(context, rootNavigator: true).pop();	
          });
        } else {
            setState(() {	
              Navigator.of(context, rootNavigator: true).pop();	
            });
            var url = "/edit-post/$postId";
            Navigator.of(context).pushReplacement(
            new MaterialPageRoute(
            settings: RouteSettings(name: url),
            builder: (context) => new EditPost(
            postId: postId)));
            errortoast(data['msg']);
        }
    }
  }  

  @override
  Widget build(BuildContext context) {
    if (postTitle =="" || postImage ==null || postImage =="") {
      return Container();
    }
    
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: header(
          logedin = false,
          back = true,
          logo = false,
          skip = false,
          backlink = true,
          (postTopicId !=null) ? '/post/$postTopicId' : '/home',
          skiplink = false,
          '/',
          headingtext = 'Edit your thoughts', 
          isMsgActive =false,
          isNotificationActive=false,
          context),
        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
              child: Column(
                children: [
                  (postTopicTitle !="") ? 
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 22, right: 22,top: 22,bottom: 35),                        
                    child: Text.rich(
                      TextSpan(
                        text:"You are posting to the  ",
                        style : AppCss.grey12regular,
                        children: <InlineSpan>[
                          TextSpan(
                            text: isVarEmpty(postTopicTitle),
                            style: AppCss.grey12bold,
                          ),
                          TextSpan(
                            text: " discussion.",
                            style: AppCss.grey12regular,
                          )
                        ]
                      )
                    ),
                  ):SizedBox(height: 30), 
                Form(
                  //autovalidateMode: AutovalidateMode.always,
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 500,
                        padding: EdgeInsets.only(top: 10, left: 18, bottom: 10, right: 18),
                        child: TextFormField(
                          maxLength: 85,
                          initialValue: isVarEmpty(postTitle),                            
                          cursorColor: AppColors.MEDIUM_GREY2,
                          key: _titleFormKey,
                          onChanged: (value) {
                            setState(() {
                              //_titleFormKey.currentState.validate();
                              _isSubmitButtonEnabled = _isFormFieldValid();
                            });
                          },
                          onSaved: (e) => title = e!,
                          style: AppCss.grey12regular,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.PRIMARY_COLOR,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.MEDIUM_GREY1, width: 0.0),
                            ),
                            contentPadding: EdgeInsets.all(8),
                            hintText: "Add a title to your post",
                            labelStyle: AppCss.mediumgrey12light,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.LIGHT_ORANGE, width: 0.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 500,
                        padding: EdgeInsets.only(left: 18, right: 18),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text("85 character limit",
                              style: AppCss.grey10light),
                        ),
                      ),
                      Scrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            width: 500,
                            padding: EdgeInsets.only(top: 10, left: 18, bottom: 10, right: 18),
                            child: TextFormField(
                              initialValue:isVarEmpty(postText),
                              keyboardType: TextInputType.multiline,
                              minLines: 8,
                              maxLines: null,
                              cursorColor: AppColors.MEDIUM_GREY2,
                              key: _postTextFormKey,
                              onChanged: (value) {
                                setState(() {
                                  _isSubmitButtonEnabled = _isFormFieldValid();
                                });
                              },
                              onSaved: (e) => text = e!,
                              style: AppCss.grey12regular,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.PRIMARY_COLOR,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColors.MEDIUM_GREY1,
                                  width: 0.0),
                                ),
                                contentPadding: EdgeInsets.all(8),
                                hintText: "Add your post text (optional).",
                                labelStyle: AppCss.mediumgrey12light,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.LIGHT_ORANGE,
                                      width: 0.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 500,
                        padding: EdgeInsets.only(top: 16, left: 20, right: 18),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Click the thumbnail below to change your image",style: AppCss.blue12semibold),
                        ),
                      ),
                      Container(
                      width: 500,	
                      padding: EdgeInsets.only(left: 18,top: 13),	
                      child: Align(
                        alignment: Alignment.topLeft,	
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          shadowColor: Color(0xFF3333331A),
                          elevation: 15,
                          child: ClipPath(
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                child: fileBytes != null ?  Image.memory(fileBytes,width: 70,height: 70,fit: BoxFit.cover)
                                : Image.network(postImage,width: 70,height: 70,fit: BoxFit.cover),
                                onTap: () {
                                  chooseImage();
                                },
                              ),
                            )),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 47,left: 41, right: 39),
                      child: buttion(
                        btnwidth = 295,
                        btnheight = 44,
                        btntext = 'Edit your thoughts'.toUpperCase(),
                        _isSubmitButtonEnabled ? AppCss.blue14bold : AppCss.white14bold,
                        _isSubmitButtonEnabled ? AppColors.LIGHT_ORANGE : AppColors.LIGHT_GREY,
                        btntypesubmit = true,
                        _isSubmitButtonEnabled
                        ? () {
                          editPost();
                        } : null,
                        13,11,53,52,context
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.fromLTRB(38, 24, 37, 144),
                        child: MaterialButton(
                          onPressed: () {              
                            var url="/post/$postTopicId";                              
                            Navigator.of(context).pushReplacement(
                              new MaterialPageRoute( 
                              settings:  RouteSettings(name:url),
                              builder: (context) => new Post(
                                topicId : postTopicId
                                ) 
                              )
                            ); 
                        	},
                          child: Text("Cancel",
                              style: AppCss.green12semibold,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
        ));
  }
}
