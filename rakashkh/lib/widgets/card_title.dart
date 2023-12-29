import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rakashkh/app/dimensions.dart';

class CardTitle extends StatefulWidget {
  String departmanet;
  Color color;
  String svg;

  CardTitle(
      {super.key,
      required this.departmanet,
      required this.color,
      required this.svg});

  @override
  State<CardTitle> createState() => _CardTitleState();
}

class _CardTitleState extends State<CardTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        h20,
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: 25,
          width: 350,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              w10,
              SvgPicture.asset(
                height: 30,
                widget.svg,
                // color: widget.color,
                color: widget.color,
              ),
              // Image.asset(
              //   height: 30,
              //   widget.png,
              //   color: widget.color,
              // ),
              w20,
              Flexible(
                child: Text(widget.departmanet,
                    style: TextStyle(
                        fontSize: 22,
                        color: widget.color,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        Divider(
          color: widget.color,
          thickness: 2,
          indent: 40,
          endIndent: 30,
        ),
        h10,
      ],
    );
  }
}
