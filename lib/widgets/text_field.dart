import 'package:flutter/material.dart';
import 'package:WalkmanMobile/util/colors.dart';

class TextFieldCus extends StatelessWidget {
  final String hintText, text, error;
  final bool obscureText, enabled;
  final Function onChange;
  final TextInputType textInputType;
  final int maxLength;
  final int mixlines;
  final TextInputAction textInputAction;
  final Color textColor;
  final Function onEditComplete;
  final TextEditingController controller;

  const TextFieldCus(
      {Key key,
      this.hintText,
      this.text,
      this.error,
      this.obscureText,
      this.enabled,
      this.onChange,
      this.textInputType,
      this.maxLength,
      this.mixlines,
      this.textInputAction,
      this.textColor,
      this.controller,
      this.onEditComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: TextField(
        onSubmitted: onEditComplete,
        maxLines: mixlines,
        style: TextStyle(color: textColor),
        keyboardType: textInputType,
        obscureText: obscureText == null ? false : obscureText,
        maxLength: maxLength != null ? maxLength : null,
        onChanged: onChange,
        enabled: enabled != null ? enabled : null,
        textInputAction:
            textInputAction != null ? textInputAction : TextInputAction.done,
        decoration: InputDecoration(
          counterText: '',
          errorText: error,
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColor.darkGrey,
              width: 0.0,
            ),
          ),
          labelText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 0.0,
            ),
          ),
        ),
      ),
    );
  }
}
