import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';	
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/journal/create-journal-entry.dart';	
import 'package:gemini/pages/journal/journal-details.dart';	
import 'package:gemini/pages/widget/footer.dart';	
import 'package:gemini/pages/widget/header.dart';	
import 'package:gemini/pages/widget/helper.dart';	
import 'package:gemini/services/post.dart';	
import 'package:localstorage/localstorage.dart';	
import 'package:page_transition/page_transition.dart';
	
class Journal extends StatefulWidget {	
   final String postId;
  const Journal({Key? key,required this.postId}) : super(key: key);
  @override	
  _JournalState createState() => _JournalState();	
}	
class _JournalState extends State<Journal> {	

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();	
  final LocalStorage storage = new LocalStorage('gemini');	
  final LocalStorage storagejournal = new LocalStorage('gemini-journal');	
  final LocalStorage storageEditJournal = new LocalStorage('gemini-edit-journal');
  var postId;
  var journalList = [];	

  @override	
  void initState() {
    postId = isVarEmpty(widget.postId);	
    storagejournal.clear();	
    storageEditJournal.clear();
    super.initState();	
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));	
    allJournalPost();	
  }	
  
  allJournalPost() async {	
    final data = await getPost(<String, dynamic>{"post_id": ""});	
    if (data['status'] == "success") {	
      setState(() {
        Navigator.of(context, rootNavigator: true).pop();	
        journalList = data['data']['posts'];	
      });	
    } else {	
      if (data['is_valid']) {	
        setState(() {	
          Navigator.of(context, rootNavigator: true).pop();	
        });	
        toast(data['msg']);	
      } else {	
        storage.clear();	
        Navigator.pushNamed(context, '/');	
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
        height: height,	
        width: width,	
        fit: BoxFit.cover,	
      ),	
      Scaffold(	
        appBar: header(	
        logedin = true,	
        back = true,	
        logo = false,	
        skip = false,	
        backlink = true,	
        '/home',	
        skiplink = false,	
        '/',	
        headingtext = 'Journal',	
        isMsgActive =false,   
        isNotificationActive=false,
        context),	
          backgroundColor: Colors.transparent,	
          body: SingleChildScrollView(	
            child: Center(	
              child: Container(	
                constraints: BoxConstraints(	
                  maxWidth: 375,	
                ),	
                child: Column(	
                  children: <Widget>[	
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0, bottom: 30, left: 20, right: 20),
                      child: Container(
                        width: 500,
                        decoration: BoxDecoration(
                          color: AppColors.PRIMARY_COLOR,
                          borderRadius: new BorderRadius.circular(10.0),                            
                          boxShadow: [
                            BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 30),
                                child: Stack(
                                  children: <Widget>[
                                    Container(                                    
                                      width: 76,
                                      height: 76,
                                      decoration: new BoxDecoration(
                                        color: Color(0xFFCEECFF),
                                        borderRadius: new BorderRadius.circular(100),
                                      ),
                                    ),
                                    Positioned(
                                      top: 22,
                                      left: 3,
                                      right: 3,
                                      child: SvgPicture.asset('assets/images/icons/journal/journal.svg',width: 48.95,height: 55.96,),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(	
                                padding: const EdgeInsets.only(top: 14.73, left: 20,right: 19),	
                                child: Text('This week’s reflection: Inflammation in Your Body',style: AppCss.blue20semibold,textAlign: TextAlign.center),	
                              ),
                              Padding(	
                                padding: const EdgeInsets.only(top: 7.95, bottom: 25,left: 20,right: 19),	
                                child: Text('Take a moment to reflect on lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed At vero eos et accusam et justo dolores.',style: AppCss.grey14regular,textAlign: TextAlign.center),	
                              ),
                              Padding(	
                                padding: const EdgeInsets.only(	bottom: 30, left: 15, right: 13),	
                                child: buttion(	
                                    btnwidth = 275,	
                                    btnheight = 44,	
                                    btntext = 'Create a journal entry'.toUpperCase(),	
                                    AppCss.blue14bold,	
                                    AppColors.LIGHT_ORANGE,	
                                    btntypesubmit = true, () {	
                                    var postTopicId = isVarEmpty(widget.postId);                       
                                    var url="/journal/$postTopicId";                              
                                    Navigator.of(context).pushReplacement(
                                      new MaterialPageRoute( 
                                      settings:  RouteSettings(name:url),
                                      builder: (context) => new CreateJournalEntry(
                                        postTopicId : postTopicId!,
                                      ) 
                                      )
                                    ); 	
                                }, 12, 12, 15, 13, context),	
                              ),                       
                            ],
                          ),
                        ),
                      ),
                    ),                    
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(	
                        padding: const EdgeInsets.only(bottom: 16,left: 20,right: 20),	
                        child: Text('Your past journal entries',style: AppCss.blue18semibold),	
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                      child: journalList.isEmpty ? 
                      Align(
                      alignment: Alignment.topLeft,
                      child: Padding(	
                        padding: const EdgeInsets.only(bottom: 16,left: 20,right: 20),	
                        child: Text('No journal post yet',style: AppCss.grey12medium),	
                      ),
                    ): ListView.separated(	
                        separatorBuilder: (BuildContext context, int index) =>	
                        Container(margin: EdgeInsets.only(bottom: 16)),
                        physics: NeverScrollableScrollPhysics(),	
                        scrollDirection: Axis.vertical,	
                        shrinkWrap: true,	
                        itemCount: journalList.length,	
                        itemBuilder: (context, index) {	
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.PRIMARY_COLOR,
                              borderRadius: new BorderRadius.circular(10.0),                            
                              boxShadow: [
                                BoxShadow(color: AppColors.SHADOWCOLOR,spreadRadius: 0,blurRadius: 7,offset: Offset(0, 4))
                              ],
                            ),                              
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ListTile(                               
                                  leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),                                
                                  child: Image.network(journalList[index]['image_path'],width: 40,height: 40,fit: BoxFit.cover),
                                  ),	
                                  title: Padding(	
                                    padding: const EdgeInsets.fromLTRB(13, 8, 46, 0),	
                                    child: Text(journalList[index]['title'],style: AppCss.blue16semibold),	
                                  ),	
                                  subtitle: Column(	
                                    children: <Widget>[	
                                    Row(	
                                      mainAxisAlignment:MainAxisAlignment.start,	
                                      children: [	
                                        Padding(	
                                          padding:const EdgeInsets.fromLTRB(13, 0, 10, 13),	
                                          child: Text(dateTimeFormate(journalList[index]['created_at']),	
                                              style:AppCss.mediumgrey8medium),	
                                        ),]
                                    ),
                                  ]),	
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top:10.0,right: 2,bottom: 10),
                                    child: Image.asset("assets/images/icons/chevron-thin/chevron-thin.png",width: 9.0, height: 15.32),
                                  ),	
                                  onTap: () {	
                                    Navigator.push(	
                                      context,	
                                      PageTransition(	
                                        type: PageTransitionType.fade,	
                                        child: JournalDetails(	
                                          id: journalList[index]['id'],
                                          postTopicId : widget.postId,	
                                          title: journalList[index]['title'],	
                                          text: journalList[index]['text'],	
                                          imagepath: journalList[index]	['image_path'],	
                                          type: journalList[index]['type'],	
                                          postdate: journalList[index]['created_at'], key: null,	
                                        ),	
                                      ),	
                                    );	
                                  },	
                                ),
                              ),
                            ),
                          );	
                        },	
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
              ishomepageactive = false,	
              isclassespageactive = true,	
              islibyrarypageactive = false,	
              ismorepageactive = false,	
              context)),	
    ]);	
  }	
}	
