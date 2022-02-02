import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:gemini/pages/journal/view-journal-entry.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:localstorage/localstorage.dart';

class EditJournalEntry extends StatefulWidget {
  final String id;
  final String title;
  final String text;
  final String imagepath;
  final String type;
  final String postTopicId;
  const EditJournalEntry({
    Key? key,
    required this.id,
    required this.title,
    required this.text,
    required this.imagepath,
    required this.type,
    required this.postTopicId,
  }) : super(key: key);
  @override
  _EditJournalEntryState createState() => _EditJournalEntryState();
}

class _EditJournalEntryState extends State<EditJournalEntry> {
  final _key = new GlobalKey<FormState>();
  final LocalStorage storageEditJournal = new LocalStorage('gemini-edit-journal');	
  final GlobalKey<FormFieldState> _titleFormKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _postTextFormKey = GlobalKey<FormFieldState>();
  late String title, posttext;
  bool _shareCommunity = false;
  bool _isSubmitButtonEnabled = false;
  var fileBytes;
  var fileName;  

  @override
  void initState() {
    super.initState();
    _shareCommunity = (widget.type == 'journal_shared') ? true : false;
    _isSubmitButtonEnabled = _isFormFieldValidOnLoad();
  }

  bool _isFormFieldValidOnLoad() {
    if (widget.title.isNotEmpty && widget.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool _isFormFieldValid() {
    if (_titleFormKey.currentState!.value.length > 0 && _postTextFormKey.currentState!.value.length > 0) {
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

  _submitjournalEntry() {
    storageEditJournal.setItem('title', _titleFormKey.currentState!.value);	
    storageEditJournal.setItem('postText', _postTextFormKey.currentState!.value);	
    storageEditJournal.setItem('shareCommunity', _shareCommunity);	
    storageEditJournal.setItem('fileName', fileName);	
    storageEditJournal.setItem('fileBytes', widget.imagepath);	
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: ViewJournalEntry(
          title: _titleFormKey.currentState!.value,
          text: _postTextFormKey.currentState!.value,
          shareCommunity: _shareCommunity,
          postId: widget.id,          
          fileName: fileName != null ? fileName : '',
          fileBytes: fileName != null ? base64Encode(fileBytes) : widget.imagepath, key: null,
          postTopicId : widget.postTopicId,
          type : "edit",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: header(
          logedin = false,
          back = true,
          logo = false,
          skip = false,
          backlink = true,
          '/journal',
          skiplink = false,
          '/',
          headingtext = 'Edit a journal entry', isMsgActive =false,         isNotificationActive=false,
          context),
        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                Container(	
                  width: 375,
                  padding: EdgeInsets.only(top: 20, left: 20, bottom: 24, right: 20),	
                  child: Text("Take a moment to reflect on lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed At vero eos et accusam et justo dolores.",	style: AppCss.blue18semibold,textAlign: TextAlign.center,	
                  ),	
                ),
                Form(
                  //autovalidateMode: AutovalidateMode.always,
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 375,
                        padding: EdgeInsets.only(
                            top: 10, left: 18, bottom: 10, right: 18),
                        child: TextFormField(
                          initialValue:widget.title,                                
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
                        width: 375,
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
                            width: 375,
                            padding: EdgeInsets.only(
                                top: 10, left: 18, bottom: 10, right: 18),
                            child: TextFormField(
                            initialValue: widget.text,	
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
                                      color: AppColors.LIGHT_ORANGE,
                                      width: 0.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 375,
                        padding: EdgeInsets.only(left: 20, right: 20,top: 16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              "Click the thumbnail below to change your image",
                              style: AppCss.blue12semibold),
                        ),
                      ),

                      Container(
                      width: 375,	
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
                                child: fileBytes != null
                                    ? Image.memory(fileBytes,
                                        width: 70,height: 70,fit: BoxFit.cover,)
                                    : Image.network(widget.imagepath,
                                        width: 70,height: 70,fit: BoxFit.cover,),
                                onTap: () {
                                  chooseImage();
                                },
                              ),
                            )),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: 500,
                      //   padding: const EdgeInsets.only(left: 18,top:20),
                      //   child: Row(
                      //     children: [
                      //       Container(  
                      //         width: 20,
                      //         height: 20,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(4),                            
                      //           border: _shareCommunity ? Border.all(width: 2,style: BorderStyle.solid,
                      //             color: AppColors.EMERALD_GREEN) : Border.all(width: 3,style: BorderStyle.solid,
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
                      //             tristate: false,
                      //             value:_shareCommunity,
                      //             onChanged: (value) {	
                      //               setState(() => _shareCommunity = value!);	
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
                        padding: const EdgeInsets.only(
                            top: 43, bottom: 12, left: 41, right: 39),
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
                                  }
                                : null,13,11,53,52,context),
                      ),
                    ],
                  ),
                ),
              ])),
        ));
  }
}
