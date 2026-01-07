import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(

      child: TextField(
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
