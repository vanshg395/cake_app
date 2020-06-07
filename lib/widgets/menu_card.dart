import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './common_button.dart';

class MenuCard extends StatelessWidget {
  final String image;
  final String id;
  final String title;
  final Function onTap;

  MenuCard({this.image, this.title, this.id, this.onTap});

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
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 30),
              child: CommonButton(
                title: title,
                borderRadius: 30,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2F7DA4),
                    Color(0xFF315C91),
                  ],
                ),
                onPressed: onTap,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
