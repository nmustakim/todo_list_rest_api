import 'package:flutter/material.dart';

import '../../const/const.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key? key,
    required this.id,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final int id;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: () {},
        child: Row(
          children: [
            Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(25)),
              child: Center(child: Text(id.toString())),
            ),
            const SizedBox(
              width: 15,
            ),
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
