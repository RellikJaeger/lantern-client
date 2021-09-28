import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:lantern/common/common.dart';

/// Forked version of https://github.com/retroportalstudio/focused_menu that
/// always displays the focused child at the top of the page
class FocusedMenuHolder extends StatefulWidget {
  final Widget child;
  final SizedBox menu;
  final double menuWidth;
  final Function onPressed;
  final double menuOffset;
  final double paddingTop;
  final double paddingBottom;

  const FocusedMenuHolder({
    Key? key,
    required this.child,
    required this.menu,
    required this.onPressed,
    required this.menuWidth,
    this.menuOffset = 5,
    this.paddingTop = 16,
    this.paddingBottom = 16,
  }) : super(key: key);

  @override
  _FocusedMenuHolderState createState() => _FocusedMenuHolderState();
}

class _FocusedMenuHolderState extends State<FocusedMenuHolder> {
  final containerKey = GlobalKey();
  var childOffset = const Offset(0, 0);
  Size? childSize;

  void updateChildMetrics() {
    var renderBox =
        containerKey.currentContext!.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      childOffset = offset;
      childSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: containerKey,
        onTap: () async {
          widget.onPressed();
        },
        onLongPress: () async {
          await openMenu(context);
        },
        child: widget.child);
  }

  Future openMenu(BuildContext context) async {
    updateChildMetrics();
    await Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              animation = Tween(begin: 0.0, end: 1.0).animate(animation);
              return FadeTransition(
                  opacity: animation,
                  child: FocusedMenuDetails(
                    childOffset: childOffset,
                    childSize: childSize,
                    menuWidth: widget.menuWidth,
                    menuOffset: widget.menuOffset,
                    paddingTop: widget.paddingTop,
                    paddingBottom: widget.paddingBottom,
                    menu: widget.menu,
                    child: widget.child,
                  ));
            },
            fullscreenDialog: true,
            opaque: false));
  }
}

class FocusedMenuDetails extends StatelessWidget {
  final Widget child;
  final SizedBox menu;
  final Offset childOffset;
  final Size? childSize;
  final double menuWidth;
  final double menuOffset;
  final double paddingTop;
  final double paddingBottom;

  const FocusedMenuDetails(
      {Key? key,
      required this.child,
      required this.menu,
      required this.childOffset,
      required this.childSize,
      required this.menuWidth,
      required this.menuOffset,
      required this.paddingTop,
      required this.paddingBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    final menuX = (childOffset.dx + menuWidth) < size.width
        ? childOffset.dx
        : (childOffset.dx - menuWidth + childSize!.width);

    // constrain height of menu to fit within bounds, relying on scrolling list
    // to handle overflow
    final maxMenuHeight =
        size.height - paddingTop - paddingBottom - mediaQuery.viewPadding.top;
    final menuHeight = min(maxMenuHeight, menu.height!);

    // always position menu so that we can fit all of it on the screen
    var menuY = max(paddingTop + mediaQuery.viewPadding.top,
        size.height - paddingBottom - menuHeight);
    // position child above menu, allowing it to overflow off top of screen if
    // necessary
    var childY = menuY - childSize!.height - menuOffset;
    if (childY > childOffset.dy) {
      // our calculated child position is actually lower than the current position
      // of the child, adjust it and the menu upwards to keep child in original
      // position
      final yAdjustment = childY - childOffset.dy;
      childY = childOffset.dy;
      menuY -= yAdjustment;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: black.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              top: menuY,
              left: menuX,
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 200),
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return Transform.scale(
                    scale: value,
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                tween: Tween(begin: 0.0, end: 1.0),
                child: Container(
                  width: menuWidth,
                  height: menuHeight,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: SingleChildScrollView(
                      child: menu,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: childY,
                left: childOffset.dx,
                child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                        width: childSize!.width,
                        height: childSize!.height,
                        child: child))),
          ],
        ),
      ),
    );
  }
}
