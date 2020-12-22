import 'package:flutter/material.dart';

class OverlayBuilderState {
  OverlayState overlayState;
  OverlayEntry overlayEntry;
  Widget child;

  OverlayBuilderState({this.overlayState, this.child});

  bool isShowingOverlay() => overlayEntry != null;

  void showOverlay() {
    overlayEntry = OverlayEntry(builder: (context) {
      return CenterAbout(
        position: Offset(MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).padding.top),
        // Có thể cộng thêm với Appbar height ( + AppBar().preferredSize.height)
        child: Material(
          child: child,
        ),
      );
    });

    addToOverlay(overlayEntry);
  }

  void addToOverlay(OverlayEntry entry) {
    overlayState?.insert(entry);
  }

  void removeOverlay() {
    overlayEntry.remove();
    overlayEntry = null;
  }
}

class CenterAbout extends StatefulWidget {
  final Offset position;
  final Widget child;

  const CenterAbout({Key key, this.position, this.child}) : super(key: key);

  @override
  _CenterAboutState createState() => _CenterAboutState();
}

class _CenterAboutState extends State<CenterAbout> {
  bool isSwitch = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 100), () {
      setState(() {
        isSwitch = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position.dy,
      left: widget.position.dx,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isSwitch ? 0 : 1,
        child: FractionalTranslation(
          translation: const Offset(-0.5, 0.1),
          child: widget.child,
        ),
      ),
    );
  }
}
