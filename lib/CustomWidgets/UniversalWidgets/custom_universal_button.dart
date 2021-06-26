import 'package:camp_navigate/Helpers/custom_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * this button is used thorughout the whole application
 */
class CustomUniversalButton extends StatefulWidget {
  final VoidCallback? onPressedFunction;
  String? text;
  Color? mainColor;
  Color? borderColor;
  Color? textColor;

  CustomUniversalButton(
      {this.text,
        this.onPressedFunction,
        this.mainColor,
        this.borderColor,
        this.textColor});

  @override
  _CustomUniversalButtonState createState() => _CustomUniversalButtonState();
}

class _CustomUniversalButtonState extends State<CustomUniversalButton> {
  @override
  Widget build(BuildContext context) {
    double? width = CustomSizes(context).getWidth(context);
    double? height = CustomSizes(context).getHeight(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: this.widget.borderColor!),
        borderRadius: BorderRadius.circular(26.0),
      ),
      width: width! * 0.870,
      height: height! * 0.057,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.0),
                )),
            elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) return 1;
                  return 0;
                }),
            backgroundColor:
            MaterialStateProperty.all<Color>(this.widget.mainColor!),
            foregroundColor:
            MaterialStateProperty.all<Color>(this.widget.textColor!),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return this.widget.mainColor!.withOpacity(0.04);
                if (states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.pressed))
                  return this.widget.mainColor!.withOpacity(0.04);
                return this.widget.mainColor!.withOpacity(0.04); // Defer to the widget's default.
              },
            ),
          ),
          onPressed: () => widget.onPressedFunction!(),
          child: Text(this.widget.text!)),
    );
  }
}
