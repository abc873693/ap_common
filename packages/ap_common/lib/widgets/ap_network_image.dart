import 'package:ap_common/utils/ap_utils.dart';
import 'package:ap_common_flutter_core/ap_common_flutter_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ApNetworkImage extends StatelessWidget {
  const ApNetworkImage({super.key, required this.url});
  final String url;

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
