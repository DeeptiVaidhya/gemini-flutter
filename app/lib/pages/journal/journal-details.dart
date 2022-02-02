import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/journal/edit-journal-entry.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:page_transition/page_transition.dart';

class JournalDetails extends StatefulWidget {
  final String id;
  final String title;
  final String text;
  final String imagepath;
  final String type;
  final String postdate;
  final String postTopicId;
  const JournalDetails({
    Key? key,
    required this.id,
    required this.title,
    required this.text,
    required this.imagepath,
    required this.type,
    required this.postdate,
    required this.postTopicId,
  }) : super(key: key);
  @override
  _JournalDetailsState createState() => _JournalDetailsState();
}

class _JournalDetailsState extends State<JournalDetails> {
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
            '/journal',
            skiplink = false,
            '/',
            headingtext = 'Journal', isMsgActive =false,         isNotificationActive=false,
            context),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 375,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Column(
                            children: <Widget>[
                              (widget.type == 'journal_private')
                            ? Row()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                    Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 31, 10, 0),
                                          child: Image.asset(
                                              'assets/images/icons/classes-icon/community-icon/community-icon.png',
                                              width: 13.55,
                                              height: 13.55),
                                        ),
                                        Positioned(
                                          bottom: 7.0,
                                          right: 7.0,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.EMERALD_GREEN,
                                            child: SizedBox(
                                              width: 7,
                                              height: 7,
                                              child: Icon(Icons.done,
                                                  color: Colors.white, size: 5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 31, 2, 0),
                                      child: Text("Shared in the community",
                                          style: AppCss.mediumgrey8medium),
                                    ),
                        ]),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Text(
                            widget.title,
                            style: AppCss.blue20semibold
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: Text(dateTimeFormate(widget.postdate),
                              style: AppCss.mediumgrey8medium),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                          child: Text(widget.text, style: AppCss.grey12regular),
                        ),
                        Container(                          
                          padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.zero,
                          ),
                          child: Image.network(widget.imagepath,width: 295.0, height: 371.55, fit: BoxFit.cover),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: EditJournalEntry(                                    
                                    id: widget.id,
                                    title: widget.title,
                                    text: widget.text,
                                    imagepath: widget.imagepath,
                                    type: widget.type, postTopicId : widget.postTopicId,),
                              ),
                            );
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 27.49, 0, 20),
                                  child: Image.asset('assets/images/icons/edit-post/edit-post.png',
                                      width: 17.0,height: 17.0),
                                ),
                                Padding(
                                  padding:const EdgeInsets.fromLTRB(5, 28.49, 0, 20),
                                  child: Text("Edit your entry",
                                      style: AppCss.blue12semibold),
                                ),
                              ]),
                        ),]),
                        ),                    
                        Container(
                          padding: const EdgeInsets.fromLTRB(38, 32, 37, 144),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text("See this entry in the community",
                                style: AppCss.green12semibold,
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                ),
            ),
          ),
          ),
        ),
    ]);
  }
}
