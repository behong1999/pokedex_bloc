import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;

  final Duration duration;

  // ignore: use_key_in_widget_constructors
  const ScrollToHideWidget({
    @required this.controller,
    this.duration = const Duration(milliseconds: 300),
    @required this.child,
  });

  @override
  _ScrollToHideWidgetState createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  void listen() {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      hide();
    } else {
      show();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.removeListener(listen);
    super.dispose();
  }

  _onEndScroll() {
    setState(() {
      show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isVisible ? kBottomNavigationBarHeight : 0,
      duration: widget.duration,
      child: Wrap(children: [widget.child]),
    );
  }
}
