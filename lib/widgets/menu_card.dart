import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import './common_button.dart';

class MenuCard extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;

  MenuCard({this.image, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 350,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 5,
          ),
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SvgPicture.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: CommonButton(
                title: title,
                borderRadius: 30,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2F7DA4),
                    Color(0xFF315C91),
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
