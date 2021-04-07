import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/utils/ap_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApNetworkImage extends StatelessWidget {
  final String? url;

  const ApNetworkImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApUtils.isSupportCacheNetworkImage
        ? CachedNetworkImage(
            imageUrl: url!,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(ApIcon.error),
          )
        : Image.network(url!);
  }
}
