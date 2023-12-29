
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabItem extends StatefulWidget {
  final String text;

  final Function onTap;
  final String image;



  const TabItem(this.text,

      {super.key, required this.onTap, required this.image, });

  @override
  State<TabItem> createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Image.asset(widget.image,width: 50,height: 30,),
            Text(widget.text),


          ],
        ),
      ),
    );
  }
}