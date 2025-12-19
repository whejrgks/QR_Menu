import 'package:flutter/material.dart';

/// 공통 로딩 위젯
/// 
/// 앱 전역에서 사용하는 일관된 로딩 인디케이터
class LoadingWidget extends StatelessWidget {
  final String? message;

  const LoadingWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

