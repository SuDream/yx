// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




double currentWidth(double width) {
  return ScreenUtil().setWidth(width);
}

//
double currentFontSize(double width) {
  return ScreenUtil().setSp(width * 2);
}

double CW(double width) {
  return (width * 2).w;
}

double CH(double height) {
  return (height * 2).h;
}

double FSp(double sp) {
  return (sp * 2).sp;
}

double kWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double kHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}


SizedBox SBW(double w) {
  return SizedBox(
    width: w,
  );
}

SizedBox SBH(double h) {
  return SizedBox(
    height: h,
  );
}
//-----------------------  控件 --------------------------------
InkWell SDInkWell({required Widget child, required GestureTapCallback onTap}) {
  return InkWell(
    onTap: onTap,
    highlightColor: Colors.transparent,
    radius: 0,
    child: child,
  );
}

//remove widget wave Style
Widget ClearWave({required Widget child}) {
  return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: child);
}

// overflow text
Widget OfText(String title, {TextStyle? style, int? maxLines}) {
  return Text(
    title,
    overflow: TextOverflow.ellipsis,
    style: style,
    maxLines: maxLines,
  );
}

Widget StText(String title,
    {Color? color, double? fs, FontWeight? fw, int? maxLines,double? height}) {
  return Text(
    title,
    style: TextStyle(fontWeight: fw, color: color, fontSize: FSp(fs ?? 13),height:height),
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
  );
}

//-----------------------  方法 --------------------------------
Color rgba(int r, int g, int b, double opacity) {
  return Color.fromRGBO(r, g, b, opacity);
}
Color singleRgba(int c) {
  return Color.fromRGBO(c, c, c, 1);
}