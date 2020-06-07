import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatalogueCard extends StatelessWidget {
  final Function onTap;
  final String image;
  final String name;

  CatalogueCard({this.name, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 1,
                color: Colors.grey,
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (ctx, constraints) => Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 3, left: 3, right: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                    // image: DecorationImage(
                    //   image: NetworkImage(image),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  height: constraints.maxHeight * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 3,
                      style:
                          Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
