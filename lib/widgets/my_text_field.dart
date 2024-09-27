import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController urlController;
  final FocusNode? urlFocusNode;

  MyTextFormField({
    Key? key,
    required this.urlController,
    this.urlFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: urlController,
      focusNode: urlFocusNode,
      decoration: InputDecoration(
        hintText: 'Search or paste link here...',
        hintStyle: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.black38,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.pinkAccent,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a YouTube URL';
        }
        return null;
      },
    );
  }
}
