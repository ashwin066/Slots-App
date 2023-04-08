import 'package:flutter/cupertino.dart';
import 'package:shop_ecommerce/constants.dart';

class TicketBG extends CustomPainter {
  final Color bgColor;

  TicketBG(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = bgColor != null ? bgColor : MuchLightGray
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0662857, size.height);
    path0.cubicTo(
        size.width * 0.0136857,
        size.height * 0.9999333,
        size.width * -0.0001714,
        size.height * 0.9656000,
        0,
        size.height * 0.8433333);
    path0.cubicTo(0, size.height * 0.6644500, 0, size.height * 0.3333500, 0,
        size.height * 0.1578000);
    path0.cubicTo(
        size.width * -0.0003429,
        size.height * 0.0333667,
        size.width * 0.0145000,
        size.height * -0.0001333,
        size.width * 0.0657143,
        0);
    path0.quadraticBezierTo(
        size.width * 0.1070143, 0, size.width * 0.2252000, 0);
    path0.quadraticBezierTo(size.width * 0.2310571, size.height * 0.0439000,
        size.width * 0.2441714, size.height * 0.0736000);
    path0.cubicTo(
        size.width * 0.2735714,
        size.height * 0.1403667,
        size.width * 0.3285857,
        size.height * 0.1435333,
        size.width * 0.3582571,
        size.height * 0.0755333);
    path0.quadraticBezierTo(size.width * 0.3739286, size.height * 0.0375000,
        size.width * 0.3771429, 0);
    path0.quadraticBezierTo(
        size.width * 0.8028607, 0, size.width * 0.9338143, 0);
    path0.cubicTo(
        size.width * 0.9855143,
        size.height * 0.0002667,
        size.width * 0.9999571,
        size.height * 0.0330000,
        size.width,
        size.height * 0.1494000);
    path0.cubicTo(
        size.width * 1.0003393,
        size.height * 0.3329000,
        size.width * 0.9998750,
        size.height * 0.6665667,
        size.width * 0.9996429,
        size.height * 0.8434000);
    path0.cubicTo(
        size.width * 1.0000286,
        size.height * 0.9668000,
        size.width * 0.9859143,
        size.height * 1.0004000,
        size.width * 0.9328571,
        size.height);
    path0.quadraticBezierTo(size.width * 0.8036607, size.height,
        size.width * 0.3775000, size.height);
    path0.quadraticBezierTo(size.width * 0.3747143, size.height * 0.9488000,
        size.width * 0.3581286, size.height * 0.9164667);
    path0.cubicTo(
        size.width * 0.3252143,
        size.height * 0.8482333,
        size.width * 0.2745143,
        size.height * 0.8527333,
        size.width * 0.2458000,
        size.height * 0.9141667);
    path0.quadraticBezierTo(size.width * 0.2297571, size.height * 0.9480000,
        size.width * 0.2256143, size.height);
    path0.quadraticBezierTo(size.width * 0.1786393, size.height,
        size.width * 0.0662857, size.height);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
