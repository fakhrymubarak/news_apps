import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_apps/themes/themes.dart';

void showSnackBar(BuildContext context, String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, style: TextStyles.reg12pt())),
    );

class NetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit? fit;

  const NetworkImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        imageUrl: url,
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(value: downloadProgress.progress),
        ),
        errorWidget: (context, url, error) => Center(
          child: SvgPicture.asset(Assets.imgError),
        ),
      ),
    );
  }
}
