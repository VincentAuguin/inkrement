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
  static const Duration animationDuration = Duration(milliseconds: 300);

  late final AnimationController _controller = AnimationController(
    duration: animationDuration,
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0.0, -0.5),
  ).animate(_animation);
  late final Animation<double> _opacityAnimation = Tween<double>(
    begin: 1.0,
    end: 0.0,
  ).animate(_animation);

  late String _value;

  void _bump() {
    _controller.forward().then((value) {
      setState(() {
        _value = widget.value.toString();
      });
      _controller.reset();
    });
  }

  @override
  void initState() {
    super.initState();
    _value = widget.value.toString();
  }

  @override
  void didUpdateWidget(covariant BumpIntText oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _value = oldWidget.value.toString();
    });
    _bump();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle effectiveTextStyle =
        widget.textStyle ?? DefaultTextStyle.of(context).style;

    return Center(
        child: FadeTransition(
            opacity: _opacityAnimation,
            child: SlideTransition(
                position: _offsetAnimation,
                child: AutoSizeText(
                  _value.toString(),
                  style: effectiveTextStyle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ))));
  }
}
