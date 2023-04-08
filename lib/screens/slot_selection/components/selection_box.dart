import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_ecommerce/components/simmerContainer.dart';
import 'package:shop_ecommerce/constants.dart';

class SelectionBox extends StatefulWidget {
  bool isReserved;
  bool isSelected;
  bool hasWon;
  String? slotNumber;
  double? height;
  double? fontSize;
  bool? isBold;
  BorderRadius? borderRadius;
  SelectionBox(
      {this.hasWon = false,
      this.isSelected = false,
      this.isReserved = false,
      this.slotNumber,
      this.height,
      this.fontSize,
      this.isBold,
      this.borderRadius});

  @override
  _SelectionBoxState createState() => _SelectionBoxState();
}

class _SelectionBoxState extends State<SelectionBox>
    with SingleTickerProviderStateMixin {
  AnimationController? _resizableController;
  Color selectedColor = DarkPurple;

  static Color colorVariation(int note) {
    if (note <= 1) {
      return Colors.green[50]!;
    } else if (note > 1 && note <= 2) {
      return Colors.green[100]!;
    } else if (note > 2 && note <= 3) {
      return Colors.green[200]!;
    } else if (note > 3 && note <= 4) {
      return Colors.green[300]!;
    } else if (note > 4 && note <= 5) {
      return Colors.green[400]!;
    } else if (note > 5 && note <= 6) {
      return Colors.green;
    } else if (note > 6 && note <= 7) {
      return Colors.green[600]!;
    } else if (note > 7 && note <= 8) {
      return Color.fromARGB(255, 0, 164, 8)!;
    } else if (note > 8 && note <= 9) {
      return Color.fromARGB(255, 0, 166, 8)!;
    } else if (note > 9 && note <= 10) {
      return Color.fromARGB(255, 0, 160, 11)!;
    }
    return Colors.green[700]!;
  }

  AnimatedBuilder getContainer() {
    return new AnimatedBuilder(
        animation: _resizableController!,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: widget.hasWon == true
                  ? widget.borderRadius != null
                      ? widget.borderRadius
                      : borderRadius10
                  : null,
              border: Border.all(
                  color: colorVariation(
                      (_resizableController!.value * 10).round()),
                  width: 2.8),
            ),
            child:  Container(
                margin: EdgeInsets.all(1.6),
                alignment: Alignment.center,
                width: widget.height != null
                    ? widget.height
                    : MediaQuery.of(context).size.width / 15,
                height: widget.height != null
                    ? widget.height
                    : MediaQuery.of(context).size.width / 15,
                decoration: BoxDecoration(
                    color: !widget.isSelected
                        ? LightGray.withOpacity(.7)
                        : selectedColor,
                    border: Border.all(color: aBlack, width: 1),
                    borderRadius: widget.borderRadius != null
                        ? widget.borderRadius
                        : borderRadius6),
                child: Text(
                  widget.slotNumber != null ? widget.slotNumber! : "",
                  style: TextStyle(
                      fontWeight:
                          widget.isBold == true ? FontWeight.bold : null,
                      fontSize: widget.fontSize != null ? widget.fontSize : 12,
                      color: !widget.isSelected ? aBlack : aWhite),
                  textAlign: TextAlign.center,
                ),
              ),
             
          );
        });
  }

  @override
  void initState() {
    _resizableController = new AnimationController(
      vsync: this,
      duration: new Duration(
        milliseconds: 500,
      ),
    );
    _resizableController!.addStatusListener((animationStatus) {
      switch (animationStatus) {
        case AnimationStatus.completed:
          _resizableController!.reverse();
          break;
        case AnimationStatus.dismissed:
          _resizableController!.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }
    });
    _resizableController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.hasWon == true
        ? getContainer()
        : Container(
            decoration: BoxDecoration(
              borderRadius: widget.hasWon == true
                  ? widget.borderRadius != null
                      ? widget.borderRadius
                      : borderRadius10
                  : null,
            ),
            child: AnimatedContainer(
              margin: EdgeInsets.all(5),
              duration: defaultDuration,
              alignment: Alignment.center,
              width: widget.height != null
                  ? widget.height
                  : MediaQuery.of(context).size.width / 15,
              height: widget.height != null
                  ? widget.height
                  : MediaQuery.of(context).size.width / 15,
              decoration: BoxDecoration(
                  color: widget.isSelected
                      ? selectedColor
                      : widget.isReserved
                          ? LightGray.withOpacity(.7)
                          : aWhite,
                  border: Border.all(color: aBlack, width: 1),
                  borderRadius: widget.borderRadius != null
                      ? widget.borderRadius
                      : borderRadius6),
              child: Text(
                widget.slotNumber != null ? widget.slotNumber! : "",
                style: TextStyle(
                    fontWeight: widget.isBold == true ? FontWeight.bold : null,
                    fontSize: widget.fontSize != null ? widget.fontSize : 12,
                    color: widget.isSelected ? aWhite : aBlack),
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
