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
      cursorColor: Colors.white,
      obscureText: _obscureText,
      controller: widget.controller,
    cursorErrorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white, // 👈 لون النص المكتوب
        fontSize: 16,
      ),

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
                onPressed: togglePassword,color: Colors.white,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.transparent,
      ),
    );
  }
}
