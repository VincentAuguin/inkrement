import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BumpIntText extends StatefulWidget {
  const BumpIntText({Key? key, required this.value, this.textStyle})
      : super(key: key);

  final int value;

  final TextStyle? textStyle;

  @override
  State<StatefulWidget> createState() => _BumpIntTextState();
}

class _BumpIntTextState extends State<BumpIntText>
    with SingleTickerProviderStateMixin {
  static const Duration animationDuration = Duration(milliseconds: 750);

  late final AnimationController _controller = AnimationController(
    duration: animationDuration,
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.5),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutExpo,
  ));
  late final Animation<double> _previousValueOpacityAnimation = Tween<double>(
    begin: 1.0,
    end: 0.0,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutExpo,
  ));
  late bool _widgetNeverBumped;
  late String _previousValue;
  late double _actualValueOpacity;

  void _bump() {
    // Trigger bump animations
    if (_actualValueOpacity == 0.0) {
      Timer(
          Duration(
              milliseconds: (animationDuration.inMilliseconds * 0.3).toInt()),
          () {
        setState(() {
          _actualValueOpacity = 1.0;
          _widgetNeverBumped = false;
        });
      });
      if (!_widgetNeverBumped) {
        _controller
          ..reset()
          ..forward();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _previousValue = "";
    _actualValueOpacity = 1.0;
    _widgetNeverBumped = true;
  }

  @override
  void didUpdateWidget(covariant BumpIntText oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _previousValue = oldWidget.value.toString();
      _actualValueOpacity = 0.0;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bump();

    TextStyle effectiveTextStyle =
        widget.textStyle ?? DefaultTextStyle.of(context).style;

    return Center(
        child: Stack(
      children: [
        FadeTransition(
            opacity: _previousValueOpacityAnimation,
            child: SlideTransition(
                position: _offsetAnimation,
                child: AutoSizeText(
                  _previousValue.toString(),
                  style: effectiveTextStyle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ))),
        Opacity(
            opacity: _actualValueOpacity,
            child: AutoSizeText(
              widget.value.toString(),
              style: effectiveTextStyle,
              textAlign: TextAlign.center,
              maxLines: 1,
            ))
      ],
    ));
  }
}
