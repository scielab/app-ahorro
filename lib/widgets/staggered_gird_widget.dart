import 'package:flutter/material.dart';

class StaggeredDualWidet extends StatelessWidget {
  const StaggeredDualWidet({
    required this.builder,
    required this.itemCount,
    this.spacing = 0.0,
    this.aspectRatio = 0.5,
    super.key
  });

  final IndexedWidgetBuilder builder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ), 
      itemBuilder: (context, index) {
        return Transform.translate(
          offset: Offset(0.0, index.isOdd ? 50 : 0.0),
          child: builder(context,index),
        );
      },
      itemCount: itemCount,
    );
  }
}