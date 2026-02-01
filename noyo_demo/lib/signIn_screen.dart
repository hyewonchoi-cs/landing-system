import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noyo_demo/on1.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const _green = Color(0xFF17B35D);
  static const _border = Color(0xFFE5E7EB);
  static const _text = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 로고
                  SvgPicture.asset(
                    'assets/logo.svg',
                    width: 110,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    '회원가입이 필요해요',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: _text,
                    ),
                  ),
                  const SizedBox(height: 36),

                  _OutlinedSocialButton(
                    label: '애플로 시작하기',
                    leading:
                        const Icon(Icons.apple, size: 22, color: Colors.black),
                    onTap: () {}, // 나중에 연동
                  ),
                  const SizedBox(height: 12),

                  _OutlinedSocialButton(
                    label: '카카오로 시작하기',
                    leading: _KakaoDot(),
                    onTap: () {}, // 나중에 연동
                  ),
                  const SizedBox(height: 12),

                  _OutlinedSocialButton(
                    label: 'Google로 시작하기',
                    leading: _GoogleDot(),
                    onTap: () {}, // 나중에 연동
                  ),

                  const SizedBox(height: 28),

                  Row(
                    children: const [
                      Expanded(child: Divider(color: _border, thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text('또는',
                            style: TextStyle(color: Color(0xFF9CA3AF))),
                      ),
                      Expanded(child: Divider(color: _border, thickness: 1)),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // 로그인 버튼 (여기만 실제 이동)
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF3F4F6),
                        foregroundColor: const Color(0xFF9CA3AF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const On1Screen()),
                        );
                      },
                      child: const Text(
                        '로그인',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('아직 계정이 없으신가요?  ',
                          style: TextStyle(color: Color(0xFF6B7280))),
                      Text('회원가입하기',
                          style: TextStyle(
                              color: _green, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlinedSocialButton extends StatelessWidget {
  const _OutlinedSocialButton({
    required this.label,
    required this.leading,
    required this.onTap,
  });

  final String label;
  final Widget leading;
  final VoidCallback onTap;

  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: _border, width: 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          foregroundColor: const Color(0xFF111827),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading,
            const SizedBox(width: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}

// 카카오/구글 아이콘은 “시연용”으로 간단한 점/원형 배지로 대체
class _KakaoDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 11,
      backgroundColor: Color(0xFF2A1A00),
      child: Text('K',
          style: TextStyle(
              color: Color(0xFFFFE812),
              fontSize: 12,
              fontWeight: FontWeight.w800)),
    );
  }
}

class _GoogleDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 11,
      backgroundColor: Color(0xFFF3F4F6),
      child: Text('G',
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w800)),
    );
  }
}
