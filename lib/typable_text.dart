import 'package:flutter/material.dart';

class TypableText extends AnimatedWidget {
  final String text;
  final TextStyle style;

  TypableText({Key key, Animation<double> animation, this.text, this.style})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    int totalLettersCount = text.length;
    int currentLettersCount = (totalLettersCount * animation.value).round();
    return Text(
      text.substring(0, currentLettersCount),
      style: style,
    );
  }
}

class TypeableTextFormField extends StatefulWidget {
  final String finalText;
  final InputDecoration decoration;
  final Animation<double> animation;

  TypeableTextFormField(
      {Key key, this.animation, this.finalText, this.decoration})
      : super(key: key);

  @override
  TypeableTextFormFieldState createState() {
    return new TypeableTextFormFieldState();
  }
}

class TypeableTextFormFieldState extends State<TypeableTextFormField> {
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: widget.decoration,
      controller: controller,
    );
  }

  @override
  void initState() {
    super.initState();
    widget.animation.addListener(() {
      int totalLettersCount = widget.finalText.length;
      int currentLettersCount =
          (totalLettersCount * widget.animation.value).round();
      setState(() {
        controller.text = widget.finalText.substring(0, currentLettersCount);
      });
    });
  }
}
