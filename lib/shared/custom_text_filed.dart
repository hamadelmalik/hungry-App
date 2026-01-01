import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? prefixIcon;

  const CustomTextFiled({
    super.key,
    required this.hint,
    required this.isPassword,
    this.controller,
    this.prefixIcon,
  });

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      obscureText: _obscureText,
      controller: widget.controller,

      validator: (v) {
        if (v == null || v.isEmpty) {
          return 'Please fill ${widget.hint}';
        }
        return null;
      },

      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,

        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: togglePassword,
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.hint,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
