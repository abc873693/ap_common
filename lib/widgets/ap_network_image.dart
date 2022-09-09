import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ApNetworkImage extends StatelessWidget {
  final String url;

  const ApNetworkImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApUtils.isSupportCacheNetworkImage
        ? CachedNetworkImage(
            imageUrl: url,
            placeholder: (
              BuildContext context,
              String url,
            ) =>
                const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (
              BuildContext context,
              String url,
              dynamic error,
            ) =>
                Icon(ApIcon.error),
          )
        : Image.network(url);
  }
}
