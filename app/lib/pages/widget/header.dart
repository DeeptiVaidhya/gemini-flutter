import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/widget/appbar-tab.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gemini/pages/app-css.dart';
bool logedin = false;
bool back = false;
bool logo = false;
bool skip = false;
bool backlink = false;
bool skiplink = false;
bool isrefresh = false;
String backnamedrouts = '';
String skipnamedrouts = '';
String headingtext = '';
bool isMsgActive = false;
bool isNotificationActive = false;

header(logedin, back, logo, skip, backlink, backnamedrouts, skiplink,skipnamedrouts, headingtext,isMsgActive,isNotificationActive,context,
    [callback]) {
  if (logedin) {
    return PreferredSize(
      preferredSize: Size.fromHeight(71.0),
      child: AppBar(
          toolbarHeight: 71.0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.DEEP_BLUE,
          elevation: 0,
          leading: back
            ? IconButton(
                icon: Icon(GeminiIcon.icon_back_white,size: 13,color: AppColors.PRIMARY_COLOR),
                tooltip: 'Back',
                onPressed: () => {
                  if (backlink)
                    {
                      Navigator.pushNamed(context, backnamedrouts),
                      if (isVarEmpty(callback)!="") {
                        callback('Stop')
                      }
                    }
                  else
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: backnamedrouts,
                      ),
                    )
                },
              )
              : Container(
                  padding: const EdgeInsets.only(left: 15.0,top: 22.64,bottom: 22.68),
                  child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/home");
                  },
                  child: SvgPicture.asset("assets/images/logo-icon/appbar/appbar-small-logo.svg",width: 26.94,height: 26.59))),
                title: logo
                  ? Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/welcome");
                    },
                    child: SvgPicture.asset(
                      "assets/images/logo-icon/logo.svg",
                      width: 40,
                      height: 39.68,
                    ),
                  ),
                )
          : Container(child: Text(headingtext, style: AppCss.white14medium,maxLines: 2)),
          centerTitle: true,
          actions: [
            appbar(isMsgActive = isMsgActive, isNotificationActive=isNotificationActive, context),
            // Badge(
            //   position: BadgePosition.topEnd(top: 14, end: -1),
            //   badgeColor: AppColors.BRIGHT_RED,
            //   badgeContent: Text('2', style: AppCss.white8semibold),
            //   child: IconButton(
            //     icon: SvgPicture.asset("assets/images/icons/envelope/envelope.svg",width: 16,height: 16,
            //     ),
            //     onPressed: () => {
            //       Navigator.push(
            //         context,
            //         PageTransition(
            //           type: PageTransitionType.fade,
            //           child: Messages(),
            //         ),
            //       )
            //     },
            //   ),
            // ),
            // SizedBox(width:5),
            // Badge(
            //   position: BadgePosition.topEnd(top: 14, end: 11),
            //   badgeColor: AppColors.BRIGHT_RED,
            //   badgeContent: Text('3', style: AppCss.white8semibold),
            //   child: IconButton(
            //     icon: Icon(GeminiIcon.bell_icon,size: 17, color: AppColors.PRIMARY_COLOR),
            //     onPressed: () => {
            //       Navigator.push(
            //         context,
            //         PageTransition(
            //           type: PageTransitionType.fade,
            //           child: NotificationPage(),
            //         ),
            //       )
            //     },
            //   ),
            // ),
            // SizedBox(width:5),
          ]),
    );
  } else {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: back
            ? IconButton(
                icon :Icon(GeminiIcon.icon_back,size: 13, color: AppColors.DEEP_BLUE),                
                tooltip: 'Back',
                onPressed: () => {
                  if (backlink)
                    Navigator.pushNamed(context, backnamedrouts)
                  else
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: backnamedrouts,
                      ),
                    )
                },
              )
            : null,
        title: logo
            ? Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SvgPicture.asset(
                  "assets/images/logo-icon/logo.svg",
                  width: 40,
                  height: 39.68,
                ),
              )
            : Text(headingtext, style: AppCss.blue14medium),
        centerTitle: true,
        actions: skip
        ? [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: new InkWell(
                child: Text('Skip',style: TextStyle(color: Color(0xff357B40),fontSize: 12,fontWeight: FontWeight.w600),
                textAlign: TextAlign.left),
                onTap: () {
                  if (skiplink)
                    Navigator.pushNamed(context, skipnamedrouts);
                  else
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: skipnamedrouts,
                      ),
                    );
                },
              ),
            ),
          ]
            : []);
  }
}
