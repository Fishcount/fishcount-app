import 'package:flutter/material.dart';

class FilterOptionWidget extends StatefulWidget {
  final Function() onTap;
  final String text;
  final Icon icon;

  const FilterOptionWidget({Key? key, required this.onTap, required this.text,
    required this.icon,})
      : super(key: key);

  @override
  State<FilterOptionWidget> createState() => _FilterOptionWidgetState();
}

class _FilterOptionWidgetState extends State<FilterOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            right: BorderSide(
              color: Colors.black26,
            ),
            left: BorderSide(
              color: Colors.black26,
            ),
            top: BorderSide(
              color: Colors.black26,
            ),
            bottom: BorderSide(
              color: Colors.black26,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(widget.text),
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: widget.icon,
            ),
          ],
        ),
      ),
    );
  }
}
