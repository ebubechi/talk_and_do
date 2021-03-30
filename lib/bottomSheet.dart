import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatefulWidget {
  final Widget data;
  MyFloatingActionButton({this.data});
  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  bool showFab = true;
  @override
  Widget build(BuildContext context) {
    return showFab
        ? FloatingActionButton(
          elevation: 5.0,
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 30.0,
                ),
                backgroundColor: Colors.redAccent,
            onPressed: () {
              var bottomSheetController = showBottomSheet(
                  context: context,
                  builder: (context) => BottomSheetWidget(
                        data: widget.data,
                      ),
              );
              showFoatingActionButton(false);
              bottomSheetController.closed.then((value) {
                showFoatingActionButton(true);
              });
            },
          )
        : Container();
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }
}

class BottomSheetWidget extends StatefulWidget {
  final Widget data;
  const BottomSheetWidget({this.data});
  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
  
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.data,
          ]),
    );
  }
}
