// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:freelance/src/core/theme/app_colors.dart';

class SlideMenu extends StatefulWidget {
  final Widget? child;
  final List<Widget>? menuItems;

  const SlideMenu({super.key, this.child, this.menuItems});

  @override
  _SlideMenuState createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = Tween(begin: const Offset(0.0, 0.0), end: const Offset(-0.2, 0.0)).animate(CurveTween(curve: Curves.decelerate).animate(_controller!));

    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        setState(() {
          _controller?.value -= data.primaryDelta! / context.size!.width;
        });
      },
      onHorizontalDragEnd: (data) {
        if (data.primaryVelocity! > 2500) {
          _controller?.animateTo(.0);
        } else if (_controller!.value >= .5 || data.primaryVelocity! < -2500) {
          _controller?.animateTo(1.0);
        } else {
          _controller?.animateTo(.0);
        }
      },
      child: Stack(
        children: <Widget>[
          SlideTransition(position: animation, child: widget.child),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return AnimatedBuilder(
                  animation: _controller!,
                  builder: (context, child) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          right: .0,
                          top: .0,
                          bottom: .0,
                          width: constraint.maxWidth * animation.value.dx * -1,
                          child: Container(
                            color: primary.value,
                            child: Row(
                              children: widget.menuItems!.map((child) {
                                return Expanded(
                                  child: child,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
