import 'package:flutter/material.dart';	
import 'dart:convert';	
import 'package:file_picker/file_picker.dart';
import 'package:gemini/pages/journal/view-journal-entry.dart';	
import 'package:gemini/pages/widget/header.dart';	
import 'package:gemini/pages/app-css.dart';	
import 'package:gemini/pages/widget/helper.dart';	
import 'package:localstorage/localstorage.dart';	
import 'package:page_transition/page_transition.dart';

class CreateJournalEntry extends StatefulWidget {
  final String postTopicId;
  const CreateJournalEntry({Key? key,required this.postTopicId}) : super(key: key);
  @override
  _CreateJournalEntryState createState() => new _CreateJournalEntryState();
}

class _CreateJournalEntryState extends State<CreateJournalEntry> {	
  
  final _key = new GlobalKey<FormState>();	
  final GlobalKey<FormFieldState> _titleFormKey = GlobalKey<FormFieldState>();	
  final GlobalKey<FormFieldState> _postTextFormKey =GlobalKey<FormFieldState>();	
  final LocalStorage storagejournal = new LocalStorage('gemini-journal');	
  late String title, posttext;	
  bool _shareCommunity = false;	
  bool _isSubmitButtonEnabled = false;	
  bool imageUpload = false;	
  var fileBytes;	
  var fileName;
  	
  bool _isFormFieldValid() {	
    if (_titleFormKey.currentState!.value.length > 0 &&	
        _postTextFormKey.currentState!.value.length > 0 &&	
        imageUpload) {	
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
  _submitjournalEntry() {	
    storagejournal.setItem('title', _titleFormKey.currentState!.value);	
    storagejournal.setItem('postText', _postTextFormKey.currentState!.value);	
    storagejournal.setItem('shareCommunity', _shareCommunity);	
    storagejournal.setItem('fileName', fileName);	
    storagejournal.setItem('fileBytes', fileBytes);	
    Navigator.push(	
      context,	
      PageTransition(	
        type: PageTransitionType.fade,	
        child: ViewJournalEntry(	
          title: _titleFormKey.currentState!.value,	
          text: _postTextFormKey.currentState!.value,	
          postTopicId : widget.postTopicId,
          postId: '',
          shareCommunity: _shareCommunity,	
          fileName: fileName,	
          fileBytes: base64Encode(fileBytes), key: null, type: '',	
        ),	
      ),	
    );	
  }	
  @override	
  void initState() {	
    if (storagejournal.getItem('shareCommunity') != null) {	
      _shareCommunity = storagejournal.getItem('shareCommunity');	
    }	
    if (storagejournal.getItem('fileName') != null) {	
      fileName = storagejournal.getItem('fileName');	
    }	
    if (storagejournal.getItem('fileBytes') != null) {	
      imageUpload = true;	
      fileBytes = storagejournal.getItem('fileBytes');	
    }	
    if (storagejournal.getItem('fileName') != null) {	
      fileName = storagejournal.getItem('fileName');	
    }	
    if (storagejournal.getItem('title') != null &&	
        storagejournal.getItem('postText') != null &&	
        storagejournal.getItem('fileBytes') != null) {	
      _isSubmitButtonEnabled = true;	
    }	
    super.initState();	
  }	
  @override	
  // ignore: missing_return	
  Widget build(BuildContext context) {	
    double width = MediaQuery.of(context).size.width;	
    double height = MediaQuery.of(context).size.height;	
    return Stack(
      children: <Widget>[
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
            '/journal',	
            skiplink = false,	
            '/',	
            headingtext = 'Create a journal entry',	 isMsgActive =false,         isNotificationActive=false,
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
                      Padding(	
                        padding: EdgeInsets.only(top: 20, left: 20, bottom: 24, right: 20),	
                        child: Text("Take a moment to reflect on lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed At vero eos et accusam et justo dolores.",	style: AppCss.blue18semibold,textAlign: TextAlign.center,	
                        ),	
                      ),	
                      Form(
                        key: _key,	
                        child: Column(	
                          children: <Widget>[	
                            Container(
                              padding: EdgeInsets.only(top: 10, left: 18, bottom: 10, right: 18),	
                              child: TextFormField(	
                                maxLength: 87,
                                cursorColor: AppColors.MEDIUM_GREY2,	
                                initialValue:	
                                    (storagejournal.getItem('title') != null)	
                                        ? storagejournal.getItem('title')	
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
                                        color: AppColors.MEDIUM_GREY1, width: 0.0),	
                                  ),	
                                  contentPadding: EdgeInsets.all(8),	
                                  hintText: "Add a title to your post",	
                                  labelStyle: AppCss.mediumgrey12light,	
                                  focusedBorder: UnderlineInputBorder(	
                                    borderSide: BorderSide(	
                                        color: AppColors.MEDIUM_GREY1, width: 0.0),	
                                  ),	
                                ),	
                              ),	
                            ),	
                            Container(	
                              width: 500,	
                              padding: EdgeInsets.only(left: 18, right: 18),	
                              child: Align(	
                                alignment: Alignment.topRight,	
                                child: Text("87 character limit",	
                                    style: AppCss.grey10light),	
                              ),	
                            ),	
                            Scrollbar(	
                              child: SingleChildScrollView(	
                                scrollDirection: Axis.vertical,	
                                child: Container(	
                                  padding: EdgeInsets.only(top: 10, left: 18, right: 18),	
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
                                    onSaved: (e) => posttext = e!,	
                                    style: AppCss.grey12regular,	
                                    initialValue:	
                                    (storagejournal.getItem('postText') != null)	
                                        ? storagejournal.getItem('postText')	
                                        : null,	
                                    decoration: InputDecoration(	
                                      filled: true,	
                                      fillColor: AppColors.PRIMARY_COLOR,	
                                      enabledBorder: UnderlineInputBorder(	
                                        borderSide: BorderSide(	
                                            color: AppColors.MEDIUM_GREY1,	
                                            width: 0.0),	
                                      ),	
                                      contentPadding: EdgeInsets.all(8),	
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
                              padding: EdgeInsets.only(top:16,left: 20, right: 18),	
                              child: Align(	
                                alignment: Alignment.topLeft,	
                                child: imageUpload ? Text(	
                                    "Click the thumbnail below to change your image",	
                                    style: AppCss.blue12semibold) : Text(	
                                    "Click the icon below to add an image to your post",	
                                    style: AppCss.blue12semibold),	
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
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
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
                          //   Container(	
                          //   width: 500,	
                          //   padding: const EdgeInsets.only(left: 18,top:20),	
                          //   child: Row(	
                          //     children: [	
                          //       Container(  	
                          //         width:20,	
                          //         height:20,                             	
                          //         decoration: BoxDecoration(	
                          //           borderRadius: BorderRadius.circular(4),	
                          //           border: Border.all(width: 2,style: BorderStyle.solid,	
                          //             color: _shareCommunity == true ? AppColors.EMERALD_GREEN: AppColors.LIGHT_GREY,	
                          //           ),	
                          //         ),	
                          //         child: Theme(	
                          //           data: Theme.of(context).copyWith(	
                          //             unselectedWidgetColor: Colors.transparent,	
                          //           ),	
                          //           child: Checkbox(	
                          //             checkColor: AppColors.EMERALD_GREEN,	
                          //             activeColor: Colors.transparent,	
                          //             value: _shareCommunity,	
                          //             tristate: false,	
                          //             onChanged: (value) {	
                          //               setState(() => _shareCommunity = value);	
                          //             },	
                          //           ),	
                          //         ),	
                          //     ),	
                          //     SizedBox(width: 10.0), 	
                          //     Text('Share this in the community discussion',style: AppCss.grey12regular)	
                          //     ],	
                          //   ),	
                          // ),	
                          Padding(	
                            padding: const EdgeInsets.only(top: 36, bottom: 12, left: 41, right: 39),	
                            child: buttion(	
                                btnwidth = 295,	
                                btnheight = 44,	
                                btntext = 'submit my entry'.toUpperCase(),	
                                _isSubmitButtonEnabled	
                                    ? AppCss.blue14bold	
                                    : AppCss.white14bold,	
                                _isSubmitButtonEnabled	
                                    ? AppColors.LIGHT_ORANGE	
                                    : AppColors.LIGHT_GREY,	
                                btntypesubmit = true,	
                                _isSubmitButtonEnabled	
                                ? () {	
                                    _submitjournalEntry();	
                                }	: null,	
                                13,	11,	73,	72,	context),	
                          ),	
                          ],	
                        ),	
                      ),	
                    ]),
                  ),
                )),	
          )),
      ]
    );	
  }	
}	
