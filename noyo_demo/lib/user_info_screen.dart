import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'loading_screen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  static const _green = Color(0xFF17B35D);
  static const _border = Color(0xFFE5E7EB);

  final _nameCtrl = TextEditingController();
  final _breedCtrl = TextEditingController();

  String? _age;
  String? _body;
  String? _activity;

  bool get _canNext =>
      _nameCtrl.text.trim().isNotEmpty &&
      _breedCtrl.text.trim().isNotEmpty &&
      _age != null &&
      _body != null &&
      _activity != null;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _breedCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 전역 테마로 흰색 고정했으면 없어도 됨.
      // backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            // 상단바 + 진행바
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/logo.svg',
                        width: 60,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none_rounded),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.settings_outlined),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: const LinearProgressIndicator(
                      value: 0.18,
                      minHeight: 8,
                      backgroundColor: Color(0xFFEFF1F4),
                      valueColor: AlwaysStoppedAnimation(_green),
                    ),
                  ),
                ],
              ),
            ),

            // 본문
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 타이틀 영역
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/profile.svg',
                          width: 59,
                          height: 59,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Text(
                            '사용자님에 대해서\n알려주세요.',
                            style: TextStyle(
                              fontSize: 24,
                              height: 1.16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),

                    const _Label('이름 *'),
                    _TextField(
                      controller: _nameCtrl,
                      hintText: '이름을 입력해주세요',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 18),

                    const _Label('견종 *'),
                    _TextField(
                      controller: _breedCtrl,
                      hintText: '견종을 등록해주세요',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 22),

                    const _Label('나이 *'),
                    _ChoiceRow(
                      value: _age,
                      options: const ['0~1살', '2~3살', '4~6살', '7~9살'],
                      onChanged: (v) => setState(() => _age = v),
                    ),
                    const SizedBox(height: 22),

                    const _Label('체형 *'),
                    _ChoiceRow(
                      value: _body,
                      options: const ['날씬해요', '적당해요', '통통해요'],
                      onChanged: (v) => setState(() => _body = v),
                    ),
                    const SizedBox(height: 22),

                    const _Label('활동량 *'),
                    _ChoiceRow(
                      value: _activity,
                      options: const ['적어요', '적당해요', '많아요'],
                      onChanged: (v) => setState(() => _activity = v),
                    ),

                    const SizedBox(height: 28),

                    // 다음 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _canNext
                            ? () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const LoadingScreen()),
                                );
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _green,
                          disabledBackgroundColor: _green.withOpacity(0.35),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          '다음',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  static const _bgField = Color(0xFFF3F4F6);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: _bgField,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String? value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  static const _green = Color(0xFF17B35D);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((opt) {
        final selected = value == opt;
        return ChoiceChip(
          label: Text(
            opt,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: selected ? _green : const Color(0xFF111827),
            ),
          ),
          selected: selected,
          onSelected: (_) => onChanged(opt),
          selectedColor: _green.withOpacity(0.10),
          backgroundColor: Colors.white,
          side: BorderSide(color: selected ? _green : _border, width: 1.4),
          shape: StadiumBorder(
            side: BorderSide(color: selected ? _green : _border, width: 1.4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        );
      }).toList(),
    );
  }
}
