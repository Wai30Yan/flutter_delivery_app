import 'package:flutter/material.dart';

class CustomInfoTile extends StatelessWidget {
  const CustomInfoTile({
    required this.title,
    required this.info,
    Key? key,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            info,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ]),
      ),
    );
  }
}
