import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomLoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0,
          ScreenUtil().setHeight(20).toDouble(), 0,
          ScreenUtil().setHeight(40).toDouble()
      ),
      child: Center(
        child: SizedBox(
          width: ScreenUtil().setWidth(40).toDouble(),
          height: ScreenUtil().setWidth(40).toDouble(),
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
