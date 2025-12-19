import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../utils/format_utils.dart';

/// 메뉴 추가/수정 다이얼로그
/// 
/// 메뉴 정보를 입력받는 다이얼로그 위젯입니다.
class MenuFormDialog extends StatefulWidget {
  final MenuItem? menu; // null이면 추가, 있으면 수정

  const MenuFormDialog({
    Key? key,
    this.menu,
  }) : super(key: key);

  @override
  State<MenuFormDialog> createState() => _MenuFormDialogState();
}

class _MenuFormDialogState extends State<MenuFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;
  late TextEditingController _allergensController;
  bool _isAvailable = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.menu?.name ?? '');
    _descriptionController = TextEditingController(text: widget.menu?.description ?? '');
    _priceController = TextEditingController(
      text: widget.menu != null ? widget.menu!.price.toStringAsFixed(0) : '',
    );
    _imageUrlController = TextEditingController(text: widget.menu?.imageUrl ?? '');
    _allergensController = TextEditingController(
      text: widget.menu?.allergens?.join(', ') ?? '',
    );
    _isAvailable = widget.menu?.isAvailable ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _allergensController.dispose();
    super.dispose();
  }

  MenuItem? _buildMenuItem() {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    final allergens = _allergensController.text.trim().isEmpty
        ? null
        : _allergensController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

    return MenuItem(
      id: widget.menu?.id ?? 'menu-${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.tryParse(_priceController.text.trim()) ?? 0,
      imageUrl: _imageUrlController.text.trim().isEmpty
          ? null
          : _imageUrlController.text.trim(),
      allergens: allergens?.isEmpty ?? true ? null : allergens,
      isAvailable: _isAvailable,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.menu != null;

    return AlertDialog(
      title: Text(isEdit ? '메뉴 수정' : '메뉴 추가'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 메뉴 이름
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '메뉴 이름 *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '메뉴 이름을 입력해주세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 설명
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: '설명 *',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '설명을 입력해주세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 가격
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: '가격 (원) *',
                  border: OutlineInputBorder(),
                  prefixText: '₩ ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '가격을 입력해주세요.';
                  }
                  final price = double.tryParse(value.trim());
                  if (price == null || price <= 0) {
                    return '올바른 가격을 입력해주세요.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 이미지 URL
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: '이미지 URL',
                  border: OutlineInputBorder(),
                  hintText: 'https://example.com/image.jpg',
                  helperText: '메뉴 이미지의 URL을 입력하세요 (선택사항)',
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),

              // 알레르기 정보
              TextFormField(
                controller: _allergensController,
                decoration: const InputDecoration(
                  labelText: '알레르기 정보',
                  border: OutlineInputBorder(),
                  hintText: '밀, 우유, 대두 (쉼표로 구분)',
                  helperText: '알레르기 유발 성분을 쉼표로 구분하여 입력하세요',
                ),
              ),
              const SizedBox(height: 16),

              // 판매 상태
              SwitchListTile(
                title: const Text('판매 중'),
                subtitle: Text(_isAvailable ? '현재 판매 중입니다' : '품절 상태입니다'),
                value: _isAvailable,
                onChanged: (value) {
                  setState(() {
                    _isAvailable = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: () {
            final menu = _buildMenuItem();
            if (menu != null) {
              Navigator.pop(context, menu);
            }
          },
          child: Text(isEdit ? '수정' : '추가'),
        ),
      ],
    );
  }
}

