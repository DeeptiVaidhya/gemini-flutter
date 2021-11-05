import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/journal/journal-complete.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/post.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:convert';

import 'package:page_transition/page_transition.dart';

class ViewJournalEntry extends StatefulWidget {
  final String title;
  final String text;
  final bool shareCommunity;
  final String postId;
  final String fileName;
  final String fileBytes;
  final String postTopicId;
  final String type;

  const ViewJournalEntry({
    Key? key,
    required this.title,
    required this.text,
    required this.shareCommunity,
    required this.postId,
    required this.fileName,
    required this.fileBytes, 
    required this.postTopicId,
    required this.type,
  }) : super(key: key);
  @override
  __ViewJournalEntryState createState() => __ViewJournalEntryState();
}

class __ViewJournalEntryState extends State<ViewJournalEntry> { 

  //final GlobalKey<State> _keyPopup = new GlobalKey<State>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final LocalStorage storagejournal = new LocalStorage('gemini-journal');

  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) => loader(context, _keyLoader));
  // }

  Future<void> submitJournalPost() async {
    try {
    loader(context, _keyLoader);
    final data = await addPost(<String, dynamic>{
      "title": widget.title,
      "text": widget.text,
      "class_id": "",
      "type": "journal_private",//widget.shareCommunity,
      "post_topic_id": widget.postTopicId,
      "replied_post_id": null,
      "post_id": widget.postId,
      "current_image_name": widget.fileName,
      "image": {
        "filename": widget.fileName,
        "filetype": "image/jpeg",
        "value": widget.fileBytes,
      }
    });
    if (data['status'] == "success") {
      setState(() {
        storagejournal.clear();
        Navigator.of(context, rootNavigator: true).pop();
      });
      Navigator.push(	
        context,	
        PageTransition(	
          type: PageTransitionType.fade,	
          child: JournalComplete(
            postId : widget.postTopicId,	
          ),	
        ),	
      );
      toast(data['msg']);
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
            headingtext = widget.type == "edit" ? 'Edit a journal entry' : 'Create a journal entry', isMsgActive =false,         isNotificationActive=false,
            context),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text("Are you happy with this entry?",
                              style: AppCss.blue18semibold)),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
                      child: Text(widget.text, style: AppCss.grey12regular),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 64.95),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: widget.fileName != '' ? Image.memory(base64Decode(widget.fileBytes),
                          width: 335.0, height: 221.95, fit: BoxFit.fill) : Image.network(widget.fileBytes,
                          width: 335.0, height: 221.95, fit: BoxFit.fill),
                    ),
                    Padding(
                      padding:const EdgeInsets.only(bottom: 40, left: 40, right: 40),
                      child: buttion(
                        btnwidth = 295,
                        btnheight = 44,
                        btntext = 'Yes, I’m happy with it'.toUpperCase(),
                        AppCss.blue14bold,
                        AppColors.LIGHT_ORANGE,
                        btntypesubmit = true, () {
                          submitJournalPost();
                        // modalPopup(
                        //   context,
                        //   _keyPopup,
                        //   AppColors.DEEP_BLUE,
                        //   Popupcontent(
                        //       title: widget.title,
                        //       text: widget.text,
                        //       shareCommunity: widget.shareCommunity,
                        //       postId: widget.postId,
                        //       fileName: widget.fileName,
                        //       fileBytes: widget.fileBytes),
                        //   335,
                        //   627);
                      }, 13, 13, 38, 57, context),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    ]);
  }
}

class Popupcontent extends StatefulWidget {
  final String title;
  final String text;
  final bool shareCommunity;
  final String postId;
  final String fileName;
  final String fileBytes;
  const Popupcontent({
    Key? key,
    required this.title,
    required this.text,
    required this.shareCommunity,
    required this.postId,
    required this.fileName,
    required this.fileBytes,
  }) : super(key: key);
  @override
  _PopupcontentState createState() => _PopupcontentState();
}

class _PopupcontentState extends State<Popupcontent> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final LocalStorage storagejournal = new LocalStorage('gemini-journal');

  submitJournalPost(title, text, shareCommunity, postId, fileName, fileBytes, context) async {
    loader(context, _keyLoader); //invoking login
    final data = await addPost(<String, dynamic>{
      "title": title,
      "text": text,
      "class_id": "39",
      "type": shareCommunity,
      "post_topic_id": "1",
      "replied_post_id": null,
      "post_id": postId,
      "current_image_name": fileName,
      "image": {
        "filename": fileName,
        "filetype": "image/jpeg",
        "value": fileBytes,
      }
    });
    if (data['status'] == "success") {
      setState(() {
        storagejournal.clear();
        Navigator.of(context, rootNavigator: true).pop();
      });
      Navigator.pushNamed(context, '/journal-complete');
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
          padding: const EdgeInsets.only(top: 60, bottom: 30),
          color: AppColors.PRIMARY_COLOR,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Container(
                    width: 125,
                    height: 125,
                    decoration: new BoxDecoration(
                      color: Color(0xFFCEECFF),
                      borderRadius: new BorderRadius.circular(100),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text("Are you sure?",
                    textAlign: TextAlign.center, style: AppCss.blue26semibold),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 24, 23, 72),
                child: Text(
                    "We encourage you to share your experience with your group. No one outside of your group can see your shared entries.. However, you can keep this entry private if you prefer.",
                    textAlign: TextAlign.center,
                    style: AppCss.grey12regular),
              ),
              buttion(
                  btnwidth = 295,
                  btnheight = 44,
                  btntext = 'That’s ok, share away!'.toUpperCase(),
                  AppCss.blue14bold,
                  AppColors.LIGHT_ORANGE,
                  btntypesubmit = true, () {
                submitJournalPost(widget.title, widget.text, 'journal_shared',
                    widget.postId, widget.fileName, widget.fileBytes, context);
              }, 12, 11, 27, 47, context),
              Container(
                padding: const EdgeInsets.only(top:29),
                child: MaterialButton(
                  onPressed: () {
                    submitJournalPost(
                        widget.title,
                        widget.text,
                        'journal_private',
                        widget.postId,
                        widget.fileName,
                        widget.fileBytes,
                        context);
                  },
                  child: Text("Nevermind, I’d rather keep it to private.",
                      style: AppCss.green12semibold,
                      textAlign: TextAlign.center),
                ),
              ),
            ],
          )),
    );
  }
}
