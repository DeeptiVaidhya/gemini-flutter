import 'package:flutter/material.dart';
import 'package:gemini/pages/health-check-in/meds-health-check-in.dart';
import 'package:gemini/pages/health-check-in/mental-health-check-in.dart';
import 'package:gemini/pages/health-check-in/physical-health-check-in.dart';
import 'package:gemini/pages/health-check-in/blood-pressure-health-check-in.dart';
import 'package:gemini/pages/health-check-in/pulse-health-check-in.dart';
import 'package:gemini/pages/health-check-in/start-health-check-in.dart';
import 'package:gemini/pages/health-check-in/thanks-health-check-in.dart';
import 'package:gemini/pages/health-check-in/weight-health-check-in.dart';
import 'package:gemini/pages/health-checkin-record/health-checkin-record.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/reply-post.dart';
import 'package:gemini/pages/learning-topic/learning-topic-details.dart';
import 'package:gemini/pages/learning-topic/learning-topic.dart';
import 'package:gemini/pages/library/library-details.dart';
import 'package:gemini/pages/messages/create-message.dart';
import 'package:gemini/pages/messages/messages-details.dart';
import 'package:gemini/pages/messages/messages.dart';
import 'package:gemini/pages/more/account-details.dart';
import 'package:gemini/pages/more/contact.dart';
import 'package:gemini/pages/more/edit-photo.dart';
import 'package:gemini/pages/more/edit-profile.dart';
import 'package:gemini/pages/more/public-profile.dart';
import 'package:gemini/pages/practice/body-practice/body-practice.dart';
import 'package:gemini/pages/practice/mind-practice/mind-practice.dart';
import 'package:gemini/pages/previsit-questions/previsit-intro.dart';
import 'package:gemini/pages/previsit-questions/previsit-question.dart';
import 'package:gemini/pages/signin/signin.dart';
import 'package:gemini/pages/checkin/checkin.dart';
import 'package:gemini/pages/classes/class-details.dart';
import 'package:gemini/pages/classes/classes.dart';
import 'package:gemini/pages/create-password/create-password.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/create-post.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/post-details.dart';
import 'package:gemini/pages/home/community-tab/discussion-tab/post.dart';
import 'package:gemini/pages/home/home.dart';
import 'package:gemini/pages/journal/create-journal-entry.dart';
import 'package:gemini/pages/journal/edit-journal-entry.dart';
import 'package:gemini/pages/journal/journal-complete.dart';
import 'package:gemini/pages/journal/journal-details.dart';
import 'package:gemini/pages/journal/journal.dart';
import 'package:gemini/pages/journal/view-journal-entry.dart'; 
import 'package:gemini/pages/library/library.dart';
import 'package:gemini/pages/more/more.dart';
// import 'package:gemini/pages/page-not-found/page-not-found.dart';
import 'package:gemini/pages/reset-password/forgot_password.dart';
import 'package:gemini/pages/signup/check-access-code.dart';
import 'package:gemini/pages/signup/create-your-account.dart';
import 'package:gemini/pages/reset-password/reset-password.dart';
import 'package:gemini/pages/welcome/welcome.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home/community-tab/discussion-tab/edit-post.dart';

class Routes extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GEMINI',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      onUnknownRoute: (RouteSettings setting) {
        return new MaterialPageRoute(builder: (context) => Welcome());
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/')  { 
          return MaterialPageRoute(builder: (_) => Welcome());
        }
        var uri = Uri.parse(settings.name!);          
        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'create-password') {
          var id = uri.pathSegments[1];
          return PageTransition(
              settings: settings,
              child: CreatePassword(code: id),
              type: PageTransitionType.fade);
        }
        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'reset-password') {
          var id = uri.pathSegments[1];
          return PageTransition(
            settings: settings,
            child: ResetPassword(code: id),
            type: PageTransitionType.fade
          );
        }

        var route = settings.name.toString();
        if (uri.pathSegments.length > 1) {
          route = '/' + uri.pathSegments[0];
        }

        if (uri.toString().contains('?')) {
          var r = uri.toString().split('?');
          route = r[0];
        }

        switch (route) {           
          case '/':   
            return PageTransition(
                settings: settings,
                child: Welcome(),
                type: PageTransitionType.fade);
          case '/welcome':
            return PageTransition(
                settings: settings,
                child: Welcome(),
                type: PageTransitionType.fade);
          case '/signup':
            return PageTransition(
                settings: settings,
                child: CreateYourAccount(accessCode: '',),
                type: PageTransitionType.fade);
            
          case '/signin':
            return PageTransition(
                settings: settings,
                child: SignIn(),
                type: PageTransitionType.fade);
          case '/home':
            return PageTransition(
                settings: settings,
                child: Home(),
                type: PageTransitionType.fade);
          case '/classes':
            return PageTransition(
                settings: settings,
                child: Classes(),
                type: PageTransitionType.fade);
          case '/more':
            return PageTransition(
                settings: settings,
                child: More(),
                type: PageTransitionType.fade);
          case '/create-post':
            return PageTransition(
                settings: settings,
                child: CreatePost(
                  topicId: uri.pathSegments.last,
                ),
                type: PageTransitionType.fade);
           case '/edit-post':
            return PageTransition(
                settings: settings,
                child: EditPost(
                  postId: uri.pathSegments.last,
                ),
                type: PageTransitionType.fade);
          case '/post':
            return PageTransition(
                settings: settings,
                child: Post(topicId: uri.pathSegments.last),
                type: PageTransitionType.fade);
          case '/edit-profile':
            return PageTransition(
                settings: settings,
                child: EditProfile(),
                type: PageTransitionType.fade);
          case '/public-profile':
            return PageTransition(
                settings: settings,
                child: PublicProfile(postId: '', type: '', buddyUserId: uri.pathSegments.last),
                type: PageTransitionType.fade);
          case '/check-in':
            return PageTransition(
                settings: settings,
                child: CheckIn(),
              type: PageTransitionType.fade);
          case '/library':
            return PageTransition(
                settings: settings,
                child: Library(),
                type: PageTransitionType.fade);
           case '/library-details':
            return PageTransition(
                settings: settings,
                child: LibraryDetails(topicId: uri.pathSegments.last, classId: '', title: '',),
                type: PageTransitionType.fade);
          case '/class-details':
            return PageTransition(
                settings: settings,
                child: ClasseDetails(classId: uri.pathSegments.last),
                type: PageTransitionType.fade);
          case '/journal':
            return PageTransition(
                settings: settings,
                child: Journal(postId: uri.pathSegments.last),
                type: PageTransitionType.fade);
          case '/create-journal-entry':
            return PageTransition(
                settings: settings,
                child: CreateJournalEntry(postTopicId: '',),
                type: PageTransitionType.fade);
          case '/journal-complete':
            return PageTransition(
                settings: settings,
                child: JournalComplete(postId: '',),
                type: PageTransitionType.fade);
          case '/create-access-code':
            return PageTransition(
                settings: settings,
                child: CheckAccessCode(),
                type: PageTransitionType.fade);
          case '/edit-journal-entry':
            return PageTransition(
                settings: settings,
                child: EditJournalEntry(
                    id: '', title: '', text: '', imagepath: '', type: '', key: null, postTopicId: '',),
                type: PageTransitionType.fade);
          case '/view-journal-entry':
            return PageTransition(
                settings: settings,
                child: ViewJournalEntry(title: '',text: '',shareCommunity: true,postId: '',fileName: '',
                fileBytes: '', key: null, postTopicId: '', type: '',),
                type: PageTransitionType.fade);
          case '/journal-details':
            return PageTransition(
            settings: settings,
            child: JournalDetails(id: '',title: '',text: '',imagepath: '',type: '',postdate: '', key: null, postTopicId: '',),
            type: PageTransitionType.fade);
          case '/forgot-password':
          return PageTransition(
              settings: settings,
              child: ForgotPassword(),
              type: PageTransitionType.fade);
          case '/post-details':
          return PageTransition(
              settings: settings,
              child: PostDetails(
                postId: uri.pathSegments.last
              ),
              type: PageTransitionType.fade);
          case '/learning-topics':
          var id = isVarEmpty(uri.pathSegments.last); 
          return PageTransition(
              settings: settings,
              child: LearningTopic(classId :id, type: '',),
              type: PageTransitionType.fade);
          case '/learning-topic-details': 
           var id = isVarEmpty(uri.pathSegments.last);         
          return PageTransition(              
              settings: settings,
              child: LearningTopicDetails(topicId: id, title: '', classId:''),
              type: PageTransitionType.fade);
          case '/edit-profile':
          return PageTransition(
              settings: settings,
              child: EditProfile(key: null,),
              type: PageTransitionType.fade);
          case '/start-previsit':
          return PageTransition(
              settings: settings,
              child: PrevisitIntroduction(key: null,),
              type: PageTransitionType.fade);
          case '/previsit-ques':
          return PageTransition(
              settings: settings,
              child: PrevisitQuestion1(qid: uri.pathSegments.last),
              type: PageTransitionType.fade);              
          case '/body-practice':
          return PageTransition(
              settings: settings,
              child: BodyPractice(practiceId:uri.pathSegments.last, type: ''),
              type: PageTransitionType.fade);         
          case '/mind-practice':
          return PageTransition(
              settings: settings,
              child: MindPractice(practiceId: uri.pathSegments.last, type: ''),
              type: PageTransitionType.fade);        
           case '/reply-post':
            return PageTransition(
                settings: settings,
                child: ReplyPost(postId: uri.pathSegments.last),
                type: PageTransitionType.fade);
          case '/account-details':
            return PageTransition(
                settings: settings,
                child: AccountDetails(),
                type: PageTransitionType.fade);
          case '/edit-photo':
            return PageTransition(
                settings: settings,
                child: EditPhoto(fileName: ''),
                type: PageTransitionType.fade);
           case '/create-message':
            return PageTransition(
              settings: settings,
              child: CreateMessages(userId: uri.pathSegments.last),
              type: PageTransitionType.fade);
            case '/messages':
            return PageTransition(
              settings: settings,
              child: Messages(),
              type: PageTransitionType.fade);
            case '/message-details':
            return PageTransition(
              settings: settings,
              child: MessagesDetails(buddy_user_id: uri.pathSegments.last),
              type: PageTransitionType.fade);
            case '/contact':
            return PageTransition(
              settings: settings,
              child: Contact(),
              type: PageTransitionType.fade);
            case '/start-checkin':
            return PageTransition(
              settings: settings,
              child: StartHealthCheckIn(),
              type: PageTransitionType.fade);
            case '/mental-checkin':
            return PageTransition(
              settings: settings,
              child: MentalHealthCheckIn(),
              type: PageTransitionType.fade);
            case '/physical-checkin':
            return PageTransition(
              settings: settings,
              child: PhysicallyHealthCheckIn(mentalvalue: '',),
              type: PageTransitionType.fade);
            case '/meds-checkin':
            return PageTransition(
              settings: settings,
              child: MedsHealthCheckIn(mentalvalue: '', physicalvalue: '',),
              type: PageTransitionType.fade);
            case '/blood-pressure-checkin':
            return PageTransition(
              settings: settings,
              child: BloodPressureHealthCheckIn(mentalvalue: '', physicalvalue: '', isSuplement: '',),
              type: PageTransitionType.fade);
             case '/pulse-checkin':
            return PageTransition(
              settings: settings,
              child: PulseHealthCheckIn(bpdiastolic: '', bpsystolic: '', mentalvalue: '', physicalvalue: '', isSuplement: '',),
              type: PageTransitionType.fade);
              case '/weight-health-check-in':
            return PageTransition(
              settings: settings,
              child: WeightHealthCheckIn(bpm: '', bpdiastolic: '', bpsystolic: '', mentalvalue: '', physicalvalue: '', isSuplement: '',),
              type: PageTransitionType.fade);
               case '/thanks-health-check-in':
            return PageTransition(
              settings: settings,
              child: ThanksHealthCheckIn(),
              type: PageTransitionType.fade);
             case '/health-check-in-records':
            return PageTransition(
              settings: settings,
              child: HealthCheckinRecord(),
              type: PageTransitionType.fade); 


              
          default:
          return null;
        }
      },
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      )),
    );
  }
}