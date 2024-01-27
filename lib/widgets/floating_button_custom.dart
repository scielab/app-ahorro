
import 'package:flutter/material.dart';

class FloatingActionButtonCustom extends FloatingActionButtonLocation {
  final double xOffset;
  final double yOffset;

  FloatingActionButtonCustom(this.xOffset, this.yOffset);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double halfWidth = scaffoldGeometry.scaffoldSize.width / 2.0;
    final double halfHeight = scaffoldGeometry.scaffoldSize.height / 2.0;
    final double dx = halfWidth + xOffset;
    final double dy = halfHeight + yOffset;
    return Offset(dx, dy);
  }
}