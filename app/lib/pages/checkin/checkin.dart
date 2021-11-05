import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini/custom-icon/gemini-icon.dart';
import 'package:gemini/pages/app-css.dart';
import 'package:gemini/pages/widget/helper.dart';
import 'package:gemini/services/checkin.dart';

class CheckIn extends StatefulWidget {
  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
   void initState() {  
    WidgetsBinding.instance!.addPostFrameCallback((_) => loader(context, _keyLoader));
    checkInList();
    super.initState();
  }

  Future<void> checkInList() async {
    try {
      final data = await getDailyCheckin(<String, dynamic>{});
      if (data['status'] == "success") {       
        setState(() {
          Navigator.of(context, rootNavigator: true).pop();
        }); 
      } else {      
        if (data['is_valid']) {	
          setState(() {	
            Navigator.of(context, rootNavigator: true).pop();	
          });	
          Navigator.pushNamed(context, 'signin');
          errortoast(data['msg']);
        } else {	
          Navigator.pushNamed(context, 'home');
          errortoast(data['msg']);	
        }	
      }	
   } catch (err) {
      Navigator.of(context, rootNavigator: true).pop();	
      print('Caught error: $err');
    }
  }

  final myImageAndCaption = [
    ["assets/images/icons/checkin/mental-health.svg",'Mental Health'],
    ["assets/images/icons/checkin/physical.svg", 'Physical Health'],
    ["assets/images/icons/checkin/medication.svg",'Medications/ Supplements'],
    ["assets/images/icons/checkin/bloodpressure.svg",'Blood Pressure'],
    ["assets/images/icons/checkin/pulse.svg", 'Pulse'],
    ["assets/images/icons/checkin/weight.svg", 'Weight'],
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.DEEP_BLUE,
      body: LayoutBuilder(
        builder: (context, constraints) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: 500,
                ), 
                child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 28.0, left: 107.0, right: 107.0),
                    child: new Text("Health check-in", style: AppCss.white14medium,textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding:const EdgeInsets.only(top: 61.0, left: 54.0, right: 54.0),
                    child: new Text("Please select one of the below to complete your health check-in", style: AppCss.white12regular,textAlign: TextAlign.center),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top:84.0,left: 58,right: 57),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: constraints.maxWidth < 500 ? 5 : 8,
                      crossAxisSpacing: 3,
                      childAspectRatio: constraints.maxWidth < 500 ? height/900.0 : height /700,  
                      children: [
                        ...myImageAndCaption.map(                          
                          (i) => Column(                            
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                child: CircleAvatar(radius: (100),
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(i.first,fit: BoxFit.fill)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5.0),
                                child: Text(i.last,textAlign: TextAlign.center,style: AppCss.white10bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ),
          ),
        );
        }
      ),
      bottomNavigationBar: new Container(
         margin: const EdgeInsets.only(top:5,bottom:26.5),
        height: 75.0,
        child: GestureDetector(
        onTap: () {
            Navigator.pop(context,true);
          },
          child: Icon(GeminiIcon.clear,size: 61, color: AppColors.PRIMARY_COLOR),
        )
      ),
    );
  }
}
