import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String placeholder;
  final IconData icon;
  final void Function() onTap;

  MyButton({
    Key? key,
    required this.placeholder,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
      ),
      child: Row(
        children: [
          Text(
            placeholder, // Aqui exibimos o valor do placeholder
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(width: 4),
          Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
