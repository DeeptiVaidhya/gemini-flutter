import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

const FontWeight w100 = FontWeight.w100; //Thin
const FontWeight w200 = FontWeight.w200; //ExtraLight
const FontWeight w300 = FontWeight.w300; //Light
const FontWeight w400 = FontWeight.w400; //Regular
const FontWeight w500 = FontWeight.w500; //Medium
const FontWeight w600 = FontWeight.w600; //SemiBold
const FontWeight w700 = FontWeight.w700; //Bold
const FontWeight w800 = FontWeight.w800; //ExtraBold
const FontWeight w900 = FontWeight.w900; //Black

class AppColors {
  static const Color PRIMARY_COLOR = Color(0xFFFFFFFF);
  static const Color SHADOWCOLOR = Color(0xFF33333326);// #33333326
  static const Color DEEP_GREEN = Color(0xFF357B40); //#357B40
  static const Color EMERALD_GREEN = Color(0xFF37BC40); //#37BC40
  static const Color DEEP_GREEN1 = Color(0xFF205828); //#205828
  static const Color PALE_GREEN = Color(0xFFCEF5CC); //#CEF5CC
  static const Color DEEP_BLUE = Color(0xff263E72); //#263E72
  static const Color DEEP_GREY = Color(0xff333333); //#333333
  static const Color LIGHT_ORANGE = Color(0xFFFF9A42); //#FF9A42
  static const Color MEDIUM_GREY = Color(0xFFFF707070); //#707070
  static const Color CYAN_BLUE = Color(0xFFFF8FC2EC); //#8FC2EC
  static const Color MEDIUM_GREY1 = Color(0xFFFF666666); //#666666
  static const Color MEDIUM_GREY2 = Color(0xFFFF757575); //#757575
  static const Color LIGHT_GREY = Color(0xFFFFCCCCCC); //#CCCCCC
  static const Color APPBAR_BG = Color(0xFFFFF3F9FD); //#F3F9FD
  static const Color BRIGHT_RED = Color(0xFFFFA4954); //#FA4954
  static const Color LIME_GREEN = Color(0xFFF93DBB6); //#93DBB6
  static const Color DARK_LIME_GREEN = Color(0xFF398344); //#398344
  static const Color PALE_BLUE = Color(0xFFCEECFF); //#CEECFF
  static const Color ffff = Color(0xFFD5F3CF); //#D5F3CF
  static const Color RED = Color(0xFFCC0000); //#CC0000
  static const Color SKY_BLUE = Color(0xFF2D8CFF); //#2D8CFF
  static const Color Black = Color(0xFF444444); //#0xFF444444
  static const Color ORANGE = Color(0xFFF29E55); //#F29E55
  static const Color TRANSPARENT = Color(0xFFFEBEBEB); //#EBEBEB
  static const Color LIGHT_GREY1 = Color(0xFFFF5F5F5); //#F5F5F5  
  static const Color BOLD_GREY = Color(0xFF4D4F5C); //#4D4F5C
  static const F4F9FD = Color(0xFFF4F9FD); //#F4F9FD
  
}

class AppCss {
  static final white9semibold = TextStyle(fontFamily: 'Poppins',fontWeight: w600, color: AppColors.PRIMARY_COLOR, fontSize: 8.0);
  static final skyblue10semibold = TextStyle(fontFamily: 'Poppins',fontWeight: w600,color: AppColors.SKY_BLUE, fontSize: 10.0);
  static final red9semibold = TextStyle(fontFamily: 'Poppins',fontWeight: w600,color: AppColors.RED, fontSize: 9.0);
  static final blue26semibold = TextStyle(fontFamily: 'Poppins',fontWeight: w600,color: AppColors.DEEP_BLUE, fontSize: 26.0);
  static final grey14regular = TextStyle(fontFamily: 'Poppins',fontWeight: w400,fontSize: 14.0,color: AppColors.DEEP_GREY);
  static final mediumgrey14light = TextStyle(fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY2, fontSize: 14.0, fontWeight: w300);
  static final mediumgrey8medium = TextStyle(fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY1, fontSize: 8.0, fontWeight: w500);
  static final mediumgrey6medium = TextStyle(fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY1, fontSize: 6.0, fontWeight: w500);
  static final mediumgrey8extrabold = TextStyle(fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY1, fontSize: 8.0, fontWeight: w800);
  static final grey8medium = TextStyle(fontFamily: 'Poppins',color: AppColors.DEEP_GREY, fontSize: 8.0, fontWeight: w500);
   static final mediumgrey6extrabold = TextStyle(fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY1, fontSize: 6.0, fontWeight: w800);
  static final mediumgrey10bold = TextStyle(fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY2, fontSize: 10.0, fontWeight: w700);
  static final blue14bold =  TextStyle(fontFamily: 'Poppins',fontSize: 14.0, color: AppColors.DEEP_BLUE, fontWeight: w700);
  static final white14bold = TextStyle(fontFamily: 'Poppins',fontSize: 14.0, color: AppColors.PRIMARY_COLOR, fontWeight: w700);
  static final white14semibold = TextStyle(fontFamily: 'Poppins',fontSize: 14.0, color: AppColors.PRIMARY_COLOR, fontWeight: w600);

  static final white26semibold = TextStyle(fontFamily: 'Poppins',letterSpacing: 0.0,fontSize: 26.0, color: AppColors.PRIMARY_COLOR, fontWeight: w600);
  static final grey12regular = TextStyle(fontFamily: 'Poppins',fontSize: 12.0, color: AppColors.DEEP_GREY, fontWeight: w400);
  static final grey12semibold = TextStyle(fontFamily: 'Poppins',fontSize: 12.0, color: AppColors.DEEP_GREY, fontWeight: w600);
  static final green12regular = TextStyle(fontFamily: 'Poppins',color: AppColors.DEEP_GREEN, fontSize: 12.0, fontWeight: w400);
  static final grey12thin = TextStyle(fontFamily: 'Poppins',fontSize: 12.0, fontWeight: w100, color: AppColors.DEEP_GREY);
  static final green12semibold = TextStyle(fontFamily: 'Poppins',fontSize: 12.0, fontWeight: w600, color: AppColors.DEEP_GREEN);
  static final grey10light = TextStyle(fontFamily: 'Poppins',fontWeight: w300, fontSize: 10, color: AppColors.DEEP_GREY);
  static final grey12light = TextStyle(fontFamily: 'Poppins',fontWeight: w300,fontSize: 12,color: AppColors.DEEP_GREY,height: 2.0);
  static final blue20semibold =TextStyle(fontFamily: 'Poppins',fontWeight: w600, fontSize: 20, color: AppColors.DEEP_BLUE);
  static final blue14medium =TextStyle(fontFamily: 'Poppins',fontWeight: w500, color: AppColors.DEEP_BLUE, fontSize: 14.0);
  static final white14medium = TextStyle(fontFamily: 'Poppins',fontWeight: w500, color: AppColors.PRIMARY_COLOR, fontSize: 14.0);
  static final grey14thin = TextStyle(fontFamily: 'Poppins',fontSize: 14.0,fontWeight: FontWeight.w100,color: AppColors.DEEP_GREY);
  static final blue16semibold = TextStyle(fontFamily: 'Poppins',fontSize: 16.0,fontWeight: FontWeight.w600,color: AppColors.DEEP_BLUE);
  static final blue14semibold = TextStyle(fontFamily: 'Poppins',fontSize: 14.0,fontWeight: FontWeight.w600,color: AppColors.DEEP_BLUE);
  static final white14light =TextStyle(fontFamily: 'Poppins',fontSize: 14.0,fontWeight: w300,color: AppColors.PRIMARY_COLOR);
  static final grey12medium = TextStyle(fontFamily: 'Poppins',color: AppColors.DEEP_GREY,fontSize: 12.0,fontWeight: FontWeight.w500);
  static final green57light = TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.w300,fontSize: 57,color: AppColors.DEEP_GREEN1);
  static final blue16bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 16, color: AppColors.DEEP_BLUE);
  static final blue13bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 13, color: AppColors.DEEP_BLUE);
  static final white13bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 13, color: AppColors.PRIMARY_COLOR);
  static final green13bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 13, color: AppColors.DEEP_GREEN);
  static final white12regular = TextStyle(fontFamily: 'Poppins',fontWeight: w400, color: AppColors.PRIMARY_COLOR, fontSize: 12.0);
  static final white10bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, color: AppColors.PRIMARY_COLOR, fontSize: 10.0);
   static final white20bold =TextStyle(fontFamily: 'Poppins',fontWeight: w700, color: AppColors.PRIMARY_COLOR, fontSize: 20.0);
  static final blue12bold = TextStyle(fontFamily: 'Poppins',fontSize: 12.0, fontWeight: w700, color: AppColors.DEEP_BLUE);
  static final blue10bold = TextStyle(fontFamily: 'Poppins',fontSize: 10.0, fontWeight: w700, color: AppColors.DEEP_BLUE);
  static final mediumgrey12light = TextStyle(fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY2, fontSize: 12.0, fontWeight: w300);
  static final white12semibold = TextStyle(fontFamily: 'Poppins',color: AppColors.PRIMARY_COLOR, fontSize: 12.0, fontWeight: w600);
  static final blue12semibold =TextStyle(fontFamily: 'Poppins',fontSize: 12.0, fontWeight: w600, color: AppColors.DEEP_BLUE);
  static final white8bold = TextStyle(fontFamily: 'Poppins',fontWeight: w900, fontSize: 8, color: Color(0xffFFFFFF));
  static final white8semibold = TextStyle(fontFamily: 'Poppins',fontWeight: w600, fontSize: 8, color: Color(0xffFFFFFF));
 static final white8light =TextStyle(fontFamily: 'Poppins',fontWeight: w300, fontSize: 8, color: Color(0xffFFFFFF));
  static final white26bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 26, color: Color(0xffFFFFFF));
  static final green6bold =TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 6.0, color: AppColors.DEEP_GREEN);
  static final green19bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 19.0, color: AppColors.DEEP_GREEN);
  static final brightred12regular = TextStyle(fontFamily: 'Poppins',fontWeight: w400, fontSize: 12, color: AppColors.BRIGHT_RED);
  static final brightred12bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 12, color: AppColors.BRIGHT_RED);
  static final blue18semibold = TextStyle(fontFamily: 'Poppins',fontSize: 18.0, fontWeight: w600, color: AppColors.DEEP_BLUE);
  static final font12semibold =TextStyle(fontFamily: 'Poppins',fontSize: 12.0, fontWeight: w600);
  static final white16semibold = TextStyle(fontFamily: 'Poppins',fontSize: 16.0,fontWeight: FontWeight.w600,color: AppColors.PRIMARY_COLOR);
  static final black78bold = TextStyle(fontFamily: 'Poppins',fontSize: 78.0,fontWeight: FontWeight.bold,color: AppColors.DEEP_GREY);
  static final deepgrey12medium = TextStyle(fontFamily: 'Poppins',color: AppColors.DEEP_GREY, fontSize: 12.0, fontWeight: w500);
  static final green8medium = TextStyle(fontFamily: 'Poppins',color: AppColors.DEEP_GREEN, fontSize: 8.0, fontWeight: w500);
  static final green10semibold = TextStyle(fontFamily: 'Poppins',fontWeight: w600, color: AppColors.DEEP_GREEN, fontSize: 10.0);
  static final green10bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, color: AppColors.DEEP_GREEN, fontSize: 10.0);
  static final blue8bold = TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 8, color: AppColors.DEEP_BLUE);
  static final mediumgrey12regular = TextStyle(fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY2, fontSize: 12.0, fontWeight: w400);
   static final mediumgrey12italic = TextStyle(fontStyle: FontStyle.italic,fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY2, fontSize: 12.0, fontWeight: w400);
  static final white8medium =TextStyle(fontFamily: 'Poppins',fontWeight: w500, fontSize: 8, color: Color(0xffFFFFFF));
  static final mediumgrey10regular = TextStyle(fontFamily: 'Poppins',color: AppColors.MEDIUM_GREY2, fontSize: 10.0, fontWeight: w400);
  static final blue10semibold = TextStyle(fontFamily: 'Poppins',fontSize: 10.0, fontWeight: w600, color: AppColors.DEEP_BLUE);  
  static final white11bold =  TextStyle(fontFamily: 'Poppins',fontWeight: w600, fontSize: 11, color: AppColors.PRIMARY_COLOR);
  static final green11bold =TextStyle(fontFamily: 'Poppins',fontWeight: w700, fontSize: 11, color: AppColors.DEEP_GREEN);
  static final grey78bold = TextStyle(fontFamily: 'Poppins',color: AppColors.DEEP_GREY, fontSize: 78.0, fontWeight: w700);
  static final red10regular =TextStyle(fontFamily: 'Poppins',color: AppColors.RED, fontSize: 10.0, fontWeight: w400);
  static final red9light =TextStyle(fontFamily: 'Poppins',color: AppColors.RED, fontSize: 9.0, fontWeight: w300);
  static final grey12bold = TextStyle(fontFamily: 'Poppins',color: AppColors.DEEP_GREY, fontSize: 12.0, fontWeight: w700);
  static final skyblue10bold =TextStyle(fontFamily: 'Poppins',color: AppColors.SKY_BLUE, fontSize: 10.0, fontWeight: w700);
  static final blue11bolditalic = TextStyle(fontFamily: 'Lora',fontStyle: FontStyle.italic,fontSize: 11.0, fontWeight: w700, color: AppColors.DEEP_BLUE);

  static final boldgrey12bold = GoogleFonts.sourceSansPro(textStyle: TextStyle(color: AppColors.BOLD_GREY, fontSize: 12.0, fontWeight: w700));
  static final boldgrey12regular = GoogleFonts.sourceSansPro(textStyle: TextStyle(color: AppColors.BOLD_GREY, fontSize: 12.0, fontWeight: w400));

   
}

// class AppCss {
//   static final white9semibold = GoogleFonts.poppins(textStyle: TextStyle(fontWeight: w600, color: AppColors.PRIMARY_COLOR, fontSize: 8.0));
//   static final skyblue10semibold = GoogleFonts.poppins(textStyle: TextStyle(fontWeight: w600,color: AppColors.SKY_BLUE, fontSize: 10.0));
//   static final red9semibold = GoogleFonts.poppins(textStyle: TextStyle(fontWeight: w600,color: AppColors.RED, fontSize: 9.0));
//   static final blue26semibold = GoogleFonts.poppins(textStyle: TextStyle(fontWeight: w600,color: AppColors.DEEP_BLUE, fontSize: 26.0));
//   static final grey14regular = GoogleFonts.poppins(textStyle: TextStyle(fontWeight: w400,fontSize: 14.0,color: AppColors.DEEP_GREY));
//   static final mediumgrey14light = GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.MEDIUM_GREY2, fontSize: 14.0, fontWeight: w300));
//   static final mediumgrey8medium = GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.MEDIUM_GREY1, fontSize: 8.0, fontWeight: w500));
//   static final mediumgrey6medium = GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.MEDIUM_GREY1, fontSize: 6.0, fontWeight: w500));
//   static final mediumgrey8extrabold = GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.MEDIUM_GREY1, fontSize: 8.0, fontWeight: w800));
//   static final grey8medium = GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.DEEP_GREY, fontSize: 8.0, fontWeight: w500));
//    static final mediumgrey6extrabold = GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.MEDIUM_GREY1, fontSize: 6.0, fontWeight: w800));
//   static final mediumgrey10bold = GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.MEDIUM_GREY2, fontSize: 10.0, fontWeight: w700));
//   static final blue14bold = GoogleFonts.poppins(textStyle: TextStyle(
//           fontSize: 14.0, color: AppColors.DEEP_BLUE, fontWeight: w700));
//   static final white14bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 14.0, color: AppColors.PRIMARY_COLOR, fontWeight: w700));

//   static final white26semibold = GoogleFonts.poppins(
//     textStyle: TextStyle(
//       letterSpacing: 0.0,fontSize: 26.0, color: AppColors.PRIMARY_COLOR, fontWeight: w600)
//   );
//   static final grey12regular = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 12.0, color: AppColors.DEEP_GREY, fontWeight: w400));
//   static final grey12semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 12.0, color: AppColors.DEEP_GREY, fontWeight: w600));
//   static final green12regular = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.DEEP_GREEN, fontSize: 12.0, fontWeight: w400));
//   static final grey12thin = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 12.0, fontWeight: w100, color: AppColors.DEEP_GREY));
//   static final green12semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 12.0, fontWeight: w600, color: AppColors.DEEP_GREEN));
//   static final grey10light = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w300, fontSize: 10, color: AppColors.DEEP_GREY));
//   static final grey12light = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w300,
//           fontSize: 12,
//           color: AppColors.DEEP_GREY,
//           height: 2.0));
//   static final blue20semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w600, fontSize: 20, color: AppColors.DEEP_BLUE));
//   static final blue14medium = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w500, color: AppColors.DEEP_BLUE, fontSize: 14.0));
//   static final white14medium = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w500, color: AppColors.PRIMARY_COLOR, fontSize: 14.0));
//   static final grey14thin = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 14.0,
//           fontWeight: FontWeight.w100,
//           color: AppColors.DEEP_GREY));
//   static final blue16semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 16.0,
//           fontWeight: FontWeight.w600,
//           color: AppColors.DEEP_BLUE));
//   static final blue14semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 14.0,
//           fontWeight: FontWeight.w600,color: AppColors.DEEP_BLUE));
//   static final white14light = GoogleFonts.poppins(
//       textStyle: GoogleFonts.poppins(
//           textStyle: TextStyle(
//               fontSize: 14.0,
//               fontWeight: w300,
//               color: AppColors.PRIMARY_COLOR)));
//   static final grey12medium = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.DEEP_GREY,
//           fontSize: 12.0,
//           fontWeight: FontWeight.w500));
//   static final green57light = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: FontWeight.w300,
//           fontSize: 57,
//           color: AppColors.DEEP_GREEN1));
//   static final blue16bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, fontSize: 16, color: AppColors.DEEP_BLUE));
//   static final blue13bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, fontSize: 13, color: AppColors.DEEP_BLUE));
//           static final white13bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, fontSize: 13, color: AppColors.PRIMARY_COLOR));
          
//    static final green13bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, fontSize: 13, color: AppColors.DEEP_GREEN));
//   static final white12regular = GoogleFonts.poppins(textStyle: TextStyle(fontWeight: w400, color: AppColors.PRIMARY_COLOR, fontSize: 12.0));
//   static final white10bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, color: AppColors.PRIMARY_COLOR, fontSize: 10.0));
//    static final white20bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, color: AppColors.PRIMARY_COLOR, fontSize: 20.0));
//   static final blue12bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 12.0, fontWeight: w700, color: AppColors.DEEP_BLUE));
//   static final blue10bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 10.0, fontWeight: w700, color: AppColors.DEEP_BLUE));
//   static final mediumgrey12light = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.MEDIUM_GREY2, fontSize: 12.0, fontWeight: w300));
//   static final white12semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.PRIMARY_COLOR, fontSize: 12.0, fontWeight: w600));
//   static final blue12semibold = GoogleFonts.poppins(
//       textStyle: GoogleFonts.poppins(
//           textStyle: TextStyle(
//               fontSize: 12.0, fontWeight: w600, color: AppColors.DEEP_BLUE)));
//   static final white8bold = GoogleFonts.poppins(
//       textStyle:
//           TextStyle(fontWeight: w900, fontSize: 8, color: Color(0xffFFFFFF)));
//   static final white8semibold = GoogleFonts.poppins(
//       textStyle:
//           TextStyle(fontWeight: w600, fontSize: 8, color: Color(0xffFFFFFF)));
//  static final white8light = GoogleFonts.poppins(
//       textStyle:
//           TextStyle(fontWeight: w300, fontSize: 8, color: Color(0xffFFFFFF)));
//   static final white26bold = GoogleFonts.poppins(
//       textStyle:
//           TextStyle(fontWeight: w700, fontSize: 26, color: Color(0xffFFFFFF)));
//   static final green6bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, fontSize: 6.0, color: AppColors.DEEP_GREEN));
//   static final green19bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, fontSize: 19.0, color: AppColors.DEEP_GREEN));
//   static final brightred12regular = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w400, fontSize: 12, color: AppColors.BRIGHT_RED));
//   static final brightred12bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, fontSize: 12, color: AppColors.BRIGHT_RED));
//   static final blue18semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 18.0, fontWeight: w600, color: AppColors.DEEP_BLUE));
//   static final font12semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(fontSize: 12.0, fontWeight: w600));
//   static final white16semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 16.0,
//           fontWeight: FontWeight.w600,
//           color: AppColors.PRIMARY_COLOR));
//    static final black78bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 78.0,
//           fontWeight: FontWeight.bold,
//           color: AppColors.DEEP_GREY));
//   static final deepgrey12medium = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.DEEP_GREY, fontSize: 12.0, fontWeight: w500));
//   static final green8medium = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.DEEP_GREEN, fontSize: 8.0, fontWeight: w500));
//   static final green10semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w600, color: AppColors.DEEP_GREEN, fontSize: 10.0));
//   static final green10bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, color: AppColors.DEEP_GREEN, fontSize: 10.0));
//   static final blue8bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, fontSize: 8, color: AppColors.DEEP_BLUE));
//   static final mediumgrey12regular = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.MEDIUM_GREY2, fontSize: 12.0, fontWeight: w400));
//   static final white8medium = GoogleFonts.poppins(
//       textStyle:
//           TextStyle(fontWeight: w500, fontSize: 8, color: Color(0xffFFFFFF)));
//   static final mediumgrey10regular = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.MEDIUM_GREY2, fontSize: 10.0, fontWeight: w400));
//   static final blue10semibold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontSize: 10.0, fontWeight: w600, color: AppColors.DEEP_BLUE));
//   static final blue11bolditalic = GoogleFonts.lora(fontStyle: FontStyle.italic,textStyle: TextStyle(
//           fontSize: 11.0, fontWeight: w700, color: AppColors.DEEP_BLUE));
//   static final white11bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w600, fontSize: 11, color: AppColors.PRIMARY_COLOR));
//   static final green11bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           fontWeight: w700, fontSize: 11, color: AppColors.DEEP_GREEN));
//   static final grey78bold = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.DEEP_GREY, fontSize: 78.0, fontWeight: w700));
//   static final red10regular = GoogleFonts.poppins(
//       textStyle: TextStyle(
//           color: AppColors.RED, fontSize: 10.0, fontWeight: w400));
//    static final grey12bold = GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.DEEP_GREY, fontSize: 12.0, fontWeight: w700));
//    static final skyblue10bold = GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.SKY_BLUE, fontSize: 10.0, fontWeight: w700));
//   static final boldgrey12bold = GoogleFonts.sourceSansPro(textStyle: TextStyle(color: AppColors.BOLD_GREY, fontSize: 12.0, fontWeight: w700));
//   static final boldgrey12regular = GoogleFonts.sourceSansPro(textStyle: TextStyle(color: AppColors.BOLD_GREY, fontSize: 12.0, fontWeight: w400));

   
// }
