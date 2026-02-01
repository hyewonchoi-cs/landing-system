import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';

class OnCompleteScreen extends StatelessWidget {
  const OnCompleteScreen({
    super.key,
    required this.reasonText, // 종료 동기 (ex. 신체적 부작용)
    required this.weightText, // 체중 (ex. 16kg)
    required this.heightText, // 키 (ex. 15cm)
  });

  final String reasonText;
  final String weightText;
  final String heightText;

  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);
  static const _progressBg = Color(0xFFEFF1F4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // 상단 로고 + 진행바(완료 느낌)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/logo.svg',
                    width: 70,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: const LinearProgressIndicator(
                      value: 1.0,
                      minHeight: 8,
                      backgroundColor: _progressBg,
                      valueColor: AlwaysStoppedAnimation(_green),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      // 프로필 원형
                      Center(
                        child: SvgPicture.asset(
                          'assets/profile.svg',
                          width: 88,
                          height: 88,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        '온보딩 완료!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: _text,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '맞춤 플랜이 준비되었습니다',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 117, 117, 117),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // 나의 프로필 카드
                      _MyProfileCard(
                        reasonText: reasonText,
                        weightText: weightText,
                        heightText: heightText,
                      ),

                      const SizedBox(height: 22),

                      // 오늘의 맞춤 미션 헤더
                      const _TodayMissionHeader(),

                      const SizedBox(height: 14),

                      // 미션 카드 2개 (더미)
                      const _MissionCard(
                        icon: Icons.favorite_rounded,
                        iconSize: 32,
                        title: '신체 컨디션 체크',
                        tagText: '건강',
                        desc: '오늘의 몸 상태를 기록하고 회복 확인하기',
                      ),
                      const SizedBox(height: 12),
                      const _MissionCard(
                        icon: Icons.check_circle_rounded,
                        iconSize: 32,
                        title: ' 체중 유지 체크',
                        tagText: '관리',
                        desc: '매일 같은 시간 체중 기록하여 변화 모니터링',
                      ),
                    ],
                  ),
                ),
              ),

              // 하단 CTA
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    '🚀 맞춤 플랜 시작하기',
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
    );
  }
}

class _MyProfileCard extends StatelessWidget {
  const _MyProfileCard({
    required this.reasonText,
    required this.weightText,
    required this.heightText,
  });

  final String reasonText;
  final String weightText;
  final String heightText;

  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333.21,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: _green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _green, width: 1.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text('📋', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text(
                '나의 프로필',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: _text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _RowKV(left: '종료 동기', right: reasonText),
          const SizedBox(height: 12),
          _RowKV(left: '현재 체중', right: weightText),
          const SizedBox(height: 12),
          _RowKV(left: '키', right: heightText),
        ],
      ),
    );
  }
}

class _RowKV extends StatelessWidget {
  const _RowKV({required this.left, required this.right});

  final String left;
  final String right;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Text(
          right,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}

class _TodayMissionHeader extends StatelessWidget {
  const _TodayMissionHeader();

  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        SvgPicture.asset(
          'ai_logo.svg',
          width: 31,
          height: 31,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 10),
        const Text(
          '오늘의 맞춤 미션',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: _text,
          ),
        ),
      ],
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({
    required this.icon,
    required this.iconSize,
    required this.title,
    required this.tagText,
    required this.desc,
  });

  final IconData icon; // svg 경로
  final double iconSize; // 아이콘 크기
  final String title;
  final String tagText;
  final String desc;

  static const _green = Color(0xFF17B35D);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333.21,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: const Color(0xFF111827),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _green.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        tagText,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: _green,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
