import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/Constents.dart';

import '../res.dart';

enum ProgressDialogType { Normal, Download }

bool _isShowing = false;
late BuildContext _context;
bool _barrierDismissible = true, _showLogs = false;

double _borderRadius = 8.0;
Color _backgroundColor = Colors.transparent;
Curve _insetAnimCurve = Curves.easeInOut;

Widget _progressWidget = Image.asset(
  Res.loader,
  width: 180,
  height: 180,
);

class ProgressDialog {
  _Body? _dialog;
  ProgressDialog(BuildContext context,
      {ProgressDialogType? type, bool? isDismissible, bool? showLogs}) {
    _context = context;
    _barrierDismissible = isDismissible ?? true;
    _showLogs = showLogs ?? false;
  }

  bool isShowing() {
    return _isShowing;
  }

  void dismiss(BuildContext context) {
    if (_isShowing) {
      try {
        _isShowing = false;
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
          if (_showLogs) debugPrint('ProgressDialog dismissed');
        } else {
          if (_showLogs) debugPrint('Cant pop ProgressDialog');
        }
      } catch (_) {}
    } else {
      if (_showLogs) debugPrint('ProgressDialog already dismissed');
    }
  }

  Future<bool> hide(BuildContext context) {
    if (_isShowing) {
      try {
        _isShowing = false;
        Navigator.of(context).pop(true);
        if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } catch (_) {
        return Future.value(false);
      }
    } else {
      if (_showLogs) debugPrint('ProgressDialog already dismissed');
      return Future.value(false);
    }
  }

  void show() {
    if (!_isShowing) {
      _dialog = new _Body();
      _isShowing = true;
      if (_showLogs) debugPrint('ProgressDialog shown');
      showDialog<dynamic>(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: WillPopScope(
              onWillPop: () {
                return Future.value(_barrierDismissible);
              },
              child: Dialog(
                  backgroundColor: _backgroundColor,
                  insetAnimationCurve: _insetAnimCurve,
                  insetAnimationDuration: Duration(milliseconds: 10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius))),
                  child: _dialog),
            ),
          );
        },
      );
    } else {
      if (_showLogs) debugPrint("ProgressDialog already shown/showing");
    }
  }
}

// ignore: must_be_immutable
class _Body extends StatefulWidget {
  _BodyState _dialog = _BodyState();

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _BodyState extends State<_Body> {
  @override
  void dispose() {
    _isShowing = false;
    if (_showLogs) debugPrint('ProgressDialog dismissed by back button');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppConstant.appColor,
        shape: BoxShape.circle,
      ),
      child: _progressWidget,
    );
  }
}
