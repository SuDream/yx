import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yx_flutter/Class/Common/yx_constant.dart';

class ImageUtils {
  static ImageProvider getAssetImage(String name, {String format = 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static ImageProvider getImageProvider(String imageUrl,
      {String holderImg = img_none, String format = 'png'}) {
    if (imageUrl.isEmpty) {
      return AssetImage(getImgPath(holderImg, format: format));
    }

    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      return CachedNetworkImageProvider(imageUrl);
    } else {
      return AssetImage(getImgPath(imageUrl, format: format));
    }
  }
}

/// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {
  const LoadImage(this.image,
      {Key? key,
      required this.width,
      required this.height,
      this.fit = BoxFit.cover,
      this.format = 'png',
      this.holderImg = img_none})
      : super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final String holderImg;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty || image == 'null') {
      return LoadAssetImage(holderImg,
          height: height, width: width, fit: fit, format: format);
    } else {
      if (image.startsWith('http') || image.startsWith('https')) {
        return CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) =>
              LoadAssetImage(holderImg, height: height, width: width, fit: fit),
          errorWidget: (context, url, error) =>
              LoadAssetImage(holderImg, height: height, width: width, fit: fit),
          width: width,
          height: height,
          fit: fit,
        );
      } else {
        return LoadAssetImage(image,
            height: height, width: width, fit: fit, format: format);
      }
    }
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(
    this.image, {
    Key? key,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.format = 'png',
    // this.color
  }) : super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  // final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtils.getImgPath(image, format: format),
      height: height,
      width: width,
      fit: fit,
      // color: color,
      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}
