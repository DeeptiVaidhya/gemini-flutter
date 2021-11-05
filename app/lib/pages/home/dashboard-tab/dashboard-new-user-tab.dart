import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/footer.dart';

class DashboardNewUser extends StatefulWidget {
  @override
  _DashboardNewUserState createState() => _DashboardNewUserState();
}

class _DashboardNewUserState extends State<DashboardNewUser> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child:
                      Text('Welcome, Melissa!', style: AppCss.blue20semibold),
                ),
                SizedBox(
                  height: 70.0,
                  child: ListView(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.only(right: 10),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: new BoxDecoration(
                              color: AppColors.LIME_GREEN.withOpacity(0.3),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.only(right: 10),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: new BoxDecoration(
                              color: AppColors.LIME_GREEN.withOpacity(0.3),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.only(right: 10),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: new BoxDecoration(
                              color: AppColors.LIME_GREEN.withOpacity(0.3),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                              width: 55,
                              height: 60,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: new BoxDecoration(
                                color: AppColors.DARK_LIME_GREEN,
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 8, right: 8),
                                    child: Text("Class".toUpperCase(),
                                        style: AppCss.white8bold,
                                        textAlign: TextAlign.center),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 19, bottom: 2),
                                    child: Text("5",
                                        style: AppCss.white26bold,
                                        textAlign: TextAlign.center),
                                  )
                                ],
                              )),
                        ),
                        Center(
                          child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 50,
                              height: 50,
                              decoration: new BoxDecoration(
                                  color:
                                      AppColors.PRIMARY_COLOR.withOpacity(0.5),
                                  borderRadius: new BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.DEEP_GREEN)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 8, right: 8),
                                    child: Text("Class",
                                        style: AppCss.green6bold,
                                        textAlign: TextAlign.center),
                                  ),
                                  Container(
                                    child: Text("6",
                                        style: AppCss.green19bold,
                                        textAlign: TextAlign.center),
                                  )
                                ],
                              )),
                        ),
                        Center(
                          child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 50,
                              height: 50,
                              decoration: new BoxDecoration(
                                  color:
                                      AppColors.PRIMARY_COLOR.withOpacity(0.5),
                                  borderRadius: new BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.DEEP_GREEN)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 8, right: 8),
                                    child: Text("Class",
                                        style: AppCss.green6bold,
                                        textAlign: TextAlign.center),
                                  ),
                                  Container(
                                    child: Text("8",
                                        style: AppCss.green19bold,
                                        textAlign: TextAlign.center),
                                  )
                                ],
                              )),
                        ),
                        Center(
                          child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 50,
                              height: 50,
                              decoration: new BoxDecoration(
                                  color:
                                      AppColors.PRIMARY_COLOR.withOpacity(0.5),
                                  borderRadius: new BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.DEEP_GREEN)),
                              child: Container(
                                child: Image.asset(
                                    'assets/images/icons/navbar-icon/green-dots.png'),
                              )),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 22, left: 25, right: 24, bottom: 15),
                  child: Text(
                      'We need some text below which welcomes Melissa to GEMIN and tells her what she can expect from the app',
                      style: AppCss.brightred12bold,
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 11),
                  child: Text('Lorem ipsum dolor',
                      style: AppCss.blue18semibold,
                      textAlign: TextAlign.center),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 39, bottom: 16),
                  child: Text(
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut',
                      style: AppCss.grey12regular,
                      textAlign: TextAlign.center),
                ),
                Container(
                  width: 215,
                  height: 44,
                  margin: const EdgeInsets.only(top: 11, bottom: 78),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("/journal");
                    },
                    style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(22),
                        ),
                        primary: AppColors.LIGHT_ORANGE),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 12, left: 30, right: 29),
                      child: Text("GET STARTED",
                          style: AppCss.blue14bold,
                          textAlign: TextAlign.center),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: floatingactionbuttion(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: footer(
            ishomepageactive = true,
            isclassespageactive = false,
            islibyrarypageactive = false,
            ismorepageactive = false,
            context));
  }
}
