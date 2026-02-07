import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller ;
  final Function(String)? onChanged;
  const SearchWidget({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(

      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hint: Text('Search...........'),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(strokeAlign: 1),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(strokeAlign: 1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
