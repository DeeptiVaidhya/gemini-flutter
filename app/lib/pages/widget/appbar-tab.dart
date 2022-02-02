import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/notifications/notification.dart';
import 'package:page_transition/page_transition.dart';

bool isMsgActive = false;
bool isNotificationActive = false;
appbar(isMsgActive, isNotificationActive,context) {
  return new Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      // Container(
      //   margin: EdgeInsets.only(top: 5),
      //   padding: EdgeInsets.zero,
      //   decoration: isMsgActive ? BoxDecoration(border: Border(bottom: BorderSide(width: 5, color: AppColors.PRIMARY_COLOR))): null,
      //   child: IconButton(
      //     hoverColor: Colors.transparent,
      //     icon: isMsgActive ? Icon(GeminiIcon.envelope_activate,size: 16,color: AppColors.PRIMARY_COLOR)
      //     : SvgPicture.asset("assets/images/icons/envelope/envelope.svg",width: 16,height: 16,
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
      Badge(
        position: BadgePosition.topStart(top: 15.0,start: 25),
        badgeColor: AppColors.BRIGHT_RED,
        badgeContent: Text('12', style: AppCss.white8semibold),
        child: Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.zero,
          decoration: isMsgActive ? BoxDecoration(border: Border(bottom: BorderSide(width: 5, color: AppColors.PRIMARY_COLOR))): null,
          child: Column(
            children: [
            IconButton(
              hoverColor: Colors.transparent,
              onPressed: () => {
                Navigator.pushNamed(context, '/messages')
              },
              icon: isMsgActive ? Icon(GeminiIcon.envelope_activate,size: 16,color: AppColors.PRIMARY_COLOR)
              : SvgPicture.asset("assets/images/icons/envelope/envelope.svg",width: 16,height: 16,
            ),
            ),
          ]),
        ),
      ),        
      SizedBox(width:6.0),
      Badge(
        position: BadgePosition.topStart(top: 15,start: 20.0),
        badgeColor: AppColors.BRIGHT_RED,
        badgeContent: Text('3', style: AppCss.white8semibold),
        child: Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.zero,
          decoration: isNotificationActive ? BoxDecoration(border: Border(bottom: BorderSide(width: 5, color: AppColors.PRIMARY_COLOR))): null,
          child: Column(
            children: [
            IconButton(
              hoverColor: Colors.transparent,
              onPressed: () => {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: NotificationPage(),
                  ),
                )
              },
              icon: isNotificationActive ? Icon(GeminiIcon.bell_activate,size: 18,color: AppColors.PRIMARY_COLOR): Icon(GeminiIcon.bell_inactivate,size: 18, color: AppColors.PRIMARY_COLOR),
            ),
          ]),
        ),
      ),
      SizedBox(width:5),
    ],
  );
}

