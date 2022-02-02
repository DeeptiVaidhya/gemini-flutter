import 'package:flutter/material.dart';
import 'package:gemini/pages/home/dashboard-tab/dashboard-tab.dart';
import 'package:gemini/pages/home/progress-tab/progress-tab.dart';
import 'package:gemini/pages/home/community-tab/community-tab.dart';
import 'package:gemini/pages/widget/header.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/checkin.dart';
import 'package:localstorage/localstorage.dart';

class Home extends StatefulWidget {
  final String type;
  const Home({Key? key, this.type = ""}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final LocalStorage storage = new LocalStorage('gemini');
  final LocalStorage loginC = new LocalStorage('gemini_login');
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  get username => null;
  int activeTabIndex = 0;
  var type;
  var checkinList = [];
  var strLength;
  var loginCount;
  var val;

  @override
  void initState() {
    type = widget.type;
    print(type);
    if (type == "progress") {
      setState(() {
        val = 1;
      });
    }
    if (type == "community") {
      setState(() {
        val = 2;
      });
    }
    val = 0;
    checkLoginToken(context);
    _tabController = TabController(
      length: 3,
      initialIndex: val, //(type == "community") ? 2 : 0,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });
    super.initState();
  }

  Future<void> checkInList() async {
    try {
      final data = await getDailyCheckin(<String, dynamic>{});
      if (data['status'] == "success") {
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
          //checkinList = data['data']['checkin'];
        });
      } else {
        if (data['is_valid']) {
          setState(() {
            Navigator.of(context, rootNavigator: true).pop();
          });
          Navigator.pushNamed(context, '/signin');
        } else {
          Navigator.pushNamed(context, '/home');
          errortoast(data['msg']);
        }
      }
    } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();
      print('Caught error: $err');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loginCount = loginC.getItem('login_count');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(children: <Widget>[
      Image.asset(
        "assets/images/bg.png",
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
      (loginCount == 0)
          ? Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 375),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 148),
                              child:
                                  Image.asset("assets/images/health-list.png"),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 30),
                              child: Text(
                                  'Now let’s start your health check-in',
                                  style: AppCss.blue26semibold,
                                  textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, right: 24),
                              child: Text(
                                  'You will be asked a few questions about your health and well-being. It will only take about 5 minutes.',
                                  style: AppCss.grey14regular,
                                  textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 105, bottom: 78, left: 20, right: 20),
                              child: buttion(
                                  btnwidth = 295,
                                  btnheight = 44,
                                  btntext = 'START CHECK-IN',
                                  AppCss.blue14bold,
                                  AppColors.LIGHT_ORANGE,
                                  btntypesubmit = true, () {
                                Navigator.pushNamed(context, '/mental-checkin');
                              }, 13, 13, 73, 72, context),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.transparent,
              appBar: header(
                  logedin = true,
                  back = false,
                  logo = false,
                  skip = false,
                  backlink = false,
                  '/',
                  skiplink = false,
                  '/',
                  headingtext = storage.getItem('name') != null
                      ? 'Hi, ' + storage.getItem('name') + '!'
                      : 'Hi',
                  isMsgActive = false,
                  isNotificationActive = false,
                  context),
              body: Container(
                child: Column(
                  children: [
                    Container(
                      width: 375,
                      height: 33,
                      margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                      child: TabBar(
                        indicatorPadding: EdgeInsets.symmetric(vertical: 0),
                        unselectedLabelColor: AppColors.DEEP_GREEN,
                        labelColor: Colors.white,
                        indicatorColor: AppColors.DEEP_GREEN,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.DEEP_GREEN),
                        labelStyle: AppCss.white12semibold,
                        labelPadding: EdgeInsets.zero,
                        tabs: [
                          Tab(text: 'Dashboard'),
                          Tab(text: 'Progress'),
                          Tab(text: 'Community')
                        ],
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 18.0),
                        child: TabBarView(
                          children: [
                            DashboardTab(),
                            ProgressTab(),
                            CommunityTab()
                          ],
                          controller: _tabController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
    ]);
  }
}
