import 'package:flutter/material.dart';

enum ButtonStyleType{
  primary,
  secondary,
  disabled
}

class DefaultButton extends StatelessWidget {
  String label;
  ButtonStyleType style;
  VoidCallback onPressed;

  DefaultButton(
    this.label,
    this.style,
    this.onPressed,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    final buttonStyle = style == ButtonStyleType.primary
      ? TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 40)
        )
      : style == ButtonStyleType.secondary
      ? OutlinedButton.styleFrom(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          side: const BorderSide(
            color: Colors.blue,
            width: 1.2
          ),
          minimumSize: const Size(double.infinity, 40)
        )
      : TextButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey,
          minimumSize: const Size(double.infinity, 40)
        );

    if(style == ButtonStyleType.secondary){
      return OutlinedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Text(label) 
      );
    }else{
      return TextButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Text(label) 
      );
    }
  }
}