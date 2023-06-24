import 'package:flutter/material.dart';

class SlideBillMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;

  const SlideBillMenu({Key? key, required this.child, required this.menuItems})
      : super(key: key);

  @override
  State<SlideBillMenu> createState() => _SlideBillMenuState();
}

class _SlideBillMenuState extends State<SlideBillMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween(begin: const Offset(0.0, 0.0), end: const Offset(-0.2, 0.0))
            .animate(CurveTween(curve: Curves.bounceOut).animate(_controller));

    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        setState(() {
          _controller.value -=
              (data.primaryDelta! / (context.size!.width * 0.2));
        });
      },
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Stack(
            children: [
              SlideTransition(
                position: animation,
                child: widget.child,
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                    right: .0,
                    top: .0,
                    bottom: .0,
                    width: constraint.maxWidth * animation.value.dx * -1,
                    child: Row(
                      children: widget.menuItems.map(
                        (child) {
                          return Expanded(
                            child: child,
                          );
                        },
                      ).toList(),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
