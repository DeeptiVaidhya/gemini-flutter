import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/post.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/post.dart';
import 'package:localstorage/localstorage.dart';

class CreatePost extends StatefulWidget {
  final String topicId;
  final String postTitle;
  const CreatePost({Key? key, this.topicId="", this.postTitle="",}) : super(key: key);
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _key = new GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormFieldState> _titleFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _postTextFormKey =GlobalKey<FormFieldState>();
  final LocalStorage storagepost = new LocalStorage('gemini-post');
  late String title, text;
  bool _isSubmitButtonEnabled = false;
  bool imageUpload = false;
  var fileBytes;
  var fileName;
  var postId;
  var posttopicId;

  @override
  void initState() {
    posttopicId = isVarEmpty(widget.topicId);
    if (storagepost.getItem('fileName') != null) {
      fileName = storagepost.getItem('fileName');
    }
    if (storagepost.getItem('fileBytes') != null) {
      imageUpload = true;
      fileBytes = storagepost.getItem('fileBytes');
    }
    if (storagepost.getItem('fileName') != null) {
      fileName = storagepost.getItem('fileName');
    }
    if (storagepost.getItem('title') != null &&
        storagepost.getItem('postText') != null &&
        storagepost.getItem('fileBytes') != null) {
      _isSubmitButtonEnabled = true;
    }
    super.initState();
  }
  
  bool _isFormFieldValid() {    
    if (_titleFormKey.currentState!.value.length > 0 && imageUpload) {
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
        imageUpload = true;
        fileBytes = file.bytes;
        fileName = file.name;
        _isSubmitButtonEnabled = _isFormFieldValid();
      });
    }
  }

  submitPost() async {
    loader(context, _keyLoader); //invoking login
    final data = await addPost(<String, dynamic>{
      "title": _titleFormKey.currentState!.value,
      "text": _postTextFormKey.currentState!.value,
      "class_id": "39",
      "type": "community",
      "post_topic_id": posttopicId,
      "replied_post_id": null,
      "post_id": null,
      "current_image_name": fileName,
      "image": {
        "filename": fileName,
        "filetype": "image/jpeg",
        "value": base64Encode(fileBytes),
      }
    });
    if (data['status'] == "success") {
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();
        var postId = isVarEmpty(data['data']['post_id']);                
        var url="post-details/$postId"; 
        Navigator.pushNamed(context, url,arguments: {postId : postId});
      });
      toast(data['msg']);
    } else {      
      if (data['is_valid'] == false) {	
        setState(() {	
          Navigator.of(context, rootNavigator: true).pop();	
        });
      } else {
        Navigator.pushNamed(context, '/home');
        errortoast(data['msg']);
      }
    }
  }  

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/bg.png",
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: header(
          logedin = false,
          back = true,
          logo = false,
          skip = false,
          backlink = true,
          '/post/$posttopicId',
          skiplink = false,
          '/',
          headingtext = 'Add your thoughts', isMsgActive =false,isNotificationActive=false,
          context),
          body: Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: Column(
                      children: <Widget>[
                        (this.widget.postTitle == "") ? SizedBox(height: 30) :
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 22, right: 22,top: 22,bottom: 35),                        
                          child: Text.rich(
                            TextSpan(
                              text:"You are posting to the  ",
                              style : AppCss.grey12regular,
                              children: <InlineSpan>[
                                TextSpan(
                                  text: isVarEmpty(this.widget.postTitle),
                                  style: AppCss.grey12bold,
                                ),
                                TextSpan(
                                  text: " discussion.",
                                  style: AppCss.grey12regular,
                                )
                              ]
                            )
                          ),
                        ),                        
                        Form(
                        key: _key,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 10, left: 18, bottom: 10, right: 18),
                              child: TextFormField(
                                maxLength: 85,
                                cursorColor: AppColors.MEDIUM_GREY2,
                                initialValue:
                                    (storagepost.getItem('title') != null)
                                        ? storagepost.getItem('title')
                                        : null,
                                key: _titleFormKey,
                                onChanged: (value) {
                                  setState(() {
                                    _isSubmitButtonEnabled = _isFormFieldValid();
                                  });
                                },
                                onSaved: (e) => title = e!,
                                style: AppCss.grey12regular,
                                decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  fillColor: AppColors.PRIMARY_COLOR,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1,
                                        width: 0.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: "Add a post title (required)",
                                  labelStyle: AppCss.mediumgrey12light,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.MEDIUM_GREY1,
                                        width: 0.0),
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
                                  padding:EdgeInsets.only(top: 10, left: 18, right: 18),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    minLines: 8,
                                    maxLines: null,
                                    cursorColor: AppColors.MEDIUM_GREY2,
                                    key: _postTextFormKey,
                                    onChanged: (value) {
                                      setState(() {
                                        //  _postTextFormKey.currentState.validate();
                                        _isSubmitButtonEnabled = _isFormFieldValid();
                                      });
                                    },
                                    onSaved: (e) => text = e!,
                                    style: AppCss.grey12regular,
                                    initialValue: (storagepost.getItem('postText') != null)
                                    ? storagepost.getItem('postText') : null,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: AppColors.PRIMARY_COLOR,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.MEDIUM_GREY1,
                                            width: 0.0),
                                      ),
                                      contentPadding: EdgeInsets.only(top:12.0,left: 8.0,right: 8.0,bottom: 12),
                                      hintText: "Add your post text (optional).",
                                      labelStyle: AppCss.mediumgrey12light,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.MEDIUM_GREY1,
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
                                child: Text("Add an image to your post",style: AppCss.blue12semibold),
                              ),
                            ),
                            Container(
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
                                        height: 70,
                                        width: 70,
                                        child: Container(
                                          child: Padding(	
                                          padding: imageUpload ? EdgeInsets.all(0):EdgeInsets.fromLTRB(20, 24, 20, 23.5),	
                                          child: InkWell(	
                                            child: imageUpload? Image.memory(fileBytes,width: 70, height: 70,fit: BoxFit.cover)	
                                            : Image.asset('assets/images/icons/photo/camera.png',
                                                    width: 30.0,height: 22.55),	
                                            onTap: () {	
                                              chooseImage();	
                                            },	
                                          ),	
                                        ),	)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 47,left: 41, right: 39),
                              child: buttion(
                                btnwidth = 295,
                                btnheight = 44,
                                btntext = 'add your thoughts'.toUpperCase(),
                                _isSubmitButtonEnabled ? AppCss.blue14bold : AppCss.white14bold,
                                _isSubmitButtonEnabled ? AppColors.LIGHT_ORANGE : AppColors.LIGHT_GREY,
                                btntypesubmit = true,
                                _isSubmitButtonEnabled
                                ? () {submitPost();} : null,
                                13,11,53,52,context
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(38, 24, 37, 144),
                        child: MaterialButton(
                          onPressed: () {              
                            var url="/post/$posttopicId";                              
                            Navigator.of(context).pushReplacement(
                              new MaterialPageRoute( 
                              settings:  RouteSettings(name:url),
                              builder: (context) => new Post(
                                topicId : posttopicId
                                ) 
                              )
                            ); 
                        	},
                          child: Text("Cancel",
                              style: AppCss.green12semibold,
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ]),
                  ),
                )),
          )),
    ]);
  }
}
