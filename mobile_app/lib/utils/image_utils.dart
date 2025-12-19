import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 이미지 유틸리티
/// 
/// 이미지 로딩 및 표시 관련 헬퍼 함수들
/// 캐싱을 통한 성능 최적화 포함

/// 네트워크 이미지 위젯 생성 (캐싱 포함)
/// 
/// 에러 처리와 플레이스홀더를 포함한 네트워크 이미지 위젯
/// cached_network_image를 사용하여 이미지 캐싱 및 성능 최적화
Widget buildNetworkImage({
  required String imageUrl,
  double? width,
  double? height,
  BoxFit fit = BoxFit.cover,
  String? placeholder,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: width,
    height: height,
    fit: fit,
    placeholder: (context, url) => Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    ),
    errorWidget: (context, url, error) => Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
      ),
    ),
    // 메모리 캐시 활성화 (null이거나 infinity가 아닌 경우에만)
    memCacheWidth: width != null && width != double.infinity ? width.toInt() : null,
    memCacheHeight: height != null && height != double.infinity ? height.toInt() : null,
    // 디스크 캐시 활성화
    cacheKey: imageUrl,
  );
}

/// 메뉴 목록용 최적화된 이미지 위젯
/// 
/// 리스트에서 사용하는 작은 이미지용 최적화 버전
Widget buildMenuThumbnail({
  required String imageUrl,
  double size = 60.0,
}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    width: size,
    height: size,
    fit: BoxFit.cover,
    placeholder: (context, url) => Container(
      width: size,
      height: size,
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    ),
    errorWidget: (context, url, error) => Container(
      width: size,
      height: size,
      color: Colors.grey[300],
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.grey,
        size: 24,
      ),
    ),
    // 썸네일용 메모리 캐시 최적화
    memCacheWidth: size.toInt(),
    memCacheHeight: size.toInt(),
  );
}

