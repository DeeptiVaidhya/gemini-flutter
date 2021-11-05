import 'package:flutter/material.dart';
import 'package:gemini/pages/app-css.dart';

class GardenTab extends StatefulWidget {
  @override
  _GardenTabState createState() => _GardenTabState();
}

class _GardenTabState extends State<GardenTab> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 90),
              padding: const EdgeInsets.only(bottom: 24),
              child: Text('Earn flowers to grow your garden',
                  style: AppCss.blue18semibold),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 22, left: 27, right: 27, bottom: 15),
              child: Text(
                  'In order to start earning flowers you must lorem ipsum dolor sit amet',
                  style: AppCss.grey12regular,
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 108),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(22),
                    ),
                    primary: const Color(0xffFF9A42)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12, bottom: 12, left: 88, right: 87),
                  child: Text("GET STARTED",
                      style: AppCss.blue14bold, textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
