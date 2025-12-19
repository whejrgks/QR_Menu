import 'package:flutter/material.dart';

/// 이미지 유틸리티
/// 
/// 이미지 로딩 및 표시 관련 헬퍼 함수들

/// 네트워크 이미지 위젯 생성
/// 
/// 에러 처리와 플레이스홀더를 포함한 네트워크 이미지 위젯
Widget buildNetworkImage({
  required String imageUrl,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  String? placeholder,
}) {
  return Image.network(
    imageUrl,
    width: width,
    height: height,
    fit: fit,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return Container(
        width: width,
        height: height,
        color: Colors.grey[200],
        child: Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(
          Icons.image_not_supported,
          color: Colors.grey,
        ),
      );
    },
  );
}

