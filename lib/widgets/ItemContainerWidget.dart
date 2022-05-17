import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemContainerWidget extends StatefulWidget {
  final String titles;
  final String subTitles;
  final Icon prefixIcon;
  final Function() onChange;
  final Function() onDelete;

  const ItemContainerWidget(
      {Key? key,
      required this.titles,
      required this.subTitles,
      required this.prefixIcon,
      required this.onChange,
      required this.onDelete})
      : super(key: key);

  @override
  State<ItemContainerWidget> createState() => _ItemContainerWidgetState();
}

class _ItemContainerWidgetState extends State<ItemContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(237, 237, 237, 237),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Row(
                children: [
                  widget.prefixIcon,
                  Container(
                    width: 180,
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.titles,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.subTitles,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              onTap: widget.onChange,
            ),
            GestureDetector(
              child: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onTap: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
