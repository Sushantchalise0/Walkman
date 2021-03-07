import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Color color;
  final Function onPressed;
  final IconData icon;
  final String label;
  const AuthButton({
    Key key,
    @required this.color,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white,
                size: 18.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
