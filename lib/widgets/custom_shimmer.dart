import 'package:flutter/material.dart';
import 'package:picgalapp/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class Shimmer extends StatefulWidget {
  final Widget? child;
  final int shimmerDuration;
  final AnimationController? controller;
  final List<Color>? colors;
  final double borderRadius;

  const Shimmer({
    Key? key,
    this.child,
    this.shimmerDuration = 1500,
    this.controller,
    this.colors,
    this.borderRadius = 0.0,
  }) : super(key: key);

  @override
  _Skeleton createState() => _Skeleton();
}

class _Skeleton extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation gradientPosition;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        AnimationController(
            vsync: this,
            duration: Duration(
              milliseconds: widget.shimmerDuration,
            ));

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    )..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child!,
        Positioned.fill(
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                gradient: LinearGradient(
                  colors: widget.colors ??
                      Provider.of<ThemeNotifier>(context)
                          .appTheme
                          ?.shimmer_colors,
                  begin: Alignment(gradientPosition.value, 0),
                  end: Alignment(-1, 0),
                )),
          ),
        )
      ],
    );
  }
}
