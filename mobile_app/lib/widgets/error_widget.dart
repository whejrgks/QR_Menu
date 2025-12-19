import 'package:flutter/material.dart';

/// 공통 에러 위젯
/// 
/// 에러 상황을 표시하고 재시도 기능을 제공하는 위젯
class ErrorDisplayWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onRetry;
  final Widget? trailingAction;

  const ErrorDisplayWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.onRetry,
    this.trailingAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null || trailingAction != null) ...[
              const SizedBox(height: 24),
              if (onRetry != null && trailingAction != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh),
                      label: const Text('다시 시도'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    trailingAction!,
                  ],
                )
              else if (onRetry != null)
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('다시 시도'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                )
              else
                trailingAction!,
            ],
          ],
        ),
      ),
    );
  }
}

/// 메뉴를 찾을 수 없을 때 표시하는 위젯
class MenuNotFoundWidget extends StatelessWidget {
  final VoidCallback? onBack;

  const MenuNotFoundWidget({
    Key? key,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            const Text(
              '메뉴를 찾을 수 없습니다.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '요청하신 메뉴가 존재하지 않거나\n삭제되었을 수 있습니다.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            if (onBack != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back),
                label: const Text('목록으로 돌아가기'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 빈 상태 위젯
/// 
/// 데이터가 없을 때 표시하는 위젯
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color? iconColor;

  const EmptyStateWidget({
    Key? key,
    this.icon = Icons.restaurant_menu,
    required this.message,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: iconColor ?? Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}


