import 'package:flutter/cupertino.dart';

////// Clipper Class for Upper Container or Sign Up //////////

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var h=size.height;
    var w= size.width;
    final path=Path();
    path.lineTo(0, h-70);
    path.quadraticBezierTo(w*0.5, h+70, w,h-70);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
