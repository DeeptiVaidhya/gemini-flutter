// import 'package:auto_orientation/auto_orientation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gemini/pages/video/OverlayWidget.dart';
// import 'package:video_player/video_player.dart';
// import 'package:wakelock/wakelock.dart';
// import 'package:flutter/services.dart' show SystemChrome;

// class VideoPlayerWidget extends StatefulWidget {
//   final VideoPlayerController controller;

//   const VideoPlayerWidget({Key? key,required this.controller}) : super(key: key);

//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late Orientation target;

//   @override
//   void initState() {
//     super.initState();
//   }
//   void setOrientation(bool isPortrait) {
//     if (isPortrait) {
//       Wakelock.disable();
//       SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//     } else {
//       Wakelock.enable();
//       SystemChrome.setEnabledSystemUIOverlays([]);
//     }
//   }

//   @override
//   Widget build(BuildContext context) => widget.controller.value.isInitialized
//   ? Container(alignment: Alignment.topCenter, child: buildVideo())
//   : Center(child: CircularProgressIndicator());

//   Widget buildVideo() => OrientationBuilder(
//         builder: (context, orientation) {
//           final isPortrait = orientation == Orientation.portrait;
//           setOrientation(isPortrait);
//           return Stack(
//             fit: isPortrait ? StackFit.loose : StackFit.expand,
//             children: <Widget>[
//               buildVideoPlayer(),
//               Positioned.fill(
//                 child: BasicOverlayWidget(
//                   controller: widget.controller,
//                   onClickedFullScreen: () {
//                     target = isPortrait
//                         ? Orientation.landscape
//                         : Orientation.portrait;
//                     if (isPortrait) {
//                       AutoOrientation.landscapeRightMode();
//                     } else {
//                       AutoOrientation.portraitUpMode();
//                     }
//                   }, practiceResourceId: '',
//                 ),
//               ),
//             ],
//           );
//         },
//       );

//   // Widget buildVideoPlayer() {
//   //   final video = AspectRatio(
//   //     aspectRatio: widget.controller.value.aspectRatio,
//   //     child: VideoPlayer(widget.controller),
//   //   );

//   //   return buildFullScreen(child: video);
//   // }

//    Widget buildVideoPlayer() => buildFullScreen(
//         child: AspectRatio(
//            aspectRatio: widget.controller.value.aspectRatio,
//           child: VideoPlayer(widget.controller),
//         ),
//       );

//   Widget buildFullScreen({
//     required Widget child,
//   }) {
//     final size = widget.controller.value.size;
//     final width = size.width;
//     final height = size.height;

//     return FittedBox(
//       fit: BoxFit.cover,
//       child: SizedBox(width: width, height: height, child: child),
//     );
//   }
// }
