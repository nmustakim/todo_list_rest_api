import 'package:flutter/material.dart';

import '../../const/const.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {  },
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style: bodyTextStyle1,
            )),
            Icon(icon)

          ],
        ),
      ),
    );
  }
}
