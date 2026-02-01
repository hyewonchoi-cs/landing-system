import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 다음 화면으로 이동할 거면 import
import 'on_complete.dart';

class On3Screen extends StatefulWidget {
  const On3Screen({super.key});

  @override
  State<On3Screen> createState() => _On3ScreenState();
}

class _On3ScreenState extends State<On3Screen> {
  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);
  static const _progressBg = Color(0xFFEFF1F4);

  // 선택값
  String? _work; // 근무시간
  String? _sleep; // 수면패턴
  String? _workout; // 운동습관

  bool get _canNext => _work != null && _sleep != null && _workout != null;

  @override
  Widget build(BuildContext context) {
    final workItems = const [
      '09:00 - 18:00',
      '10:00 - 19:00',
      '교대 근무',
      '자유 근무',
      '근무 안 함',
    ];

    final sleepItems = const [
      '22:00 취침 / 06:00 기상',
      '23:00 취침 / 07:00 기상',
      '00:00 취침 / 08:00 기상',
      '01:00 취침 / 09:00 기상',
    ];

    final workoutItems = const [
      '운동 안 함',
      '주 1-2회 산책',
      '주 3-4회 산책',
      '주 1-2회 운동',
      '주 3-5회 운동',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // --------------------
              // 상단: 로고 + 진행바
              // --------------------
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
                      value: 0.54, // 3페이지니까 적당히 증가
                      minHeight: 8,
                      backgroundColor: _progressBg,
                      valueColor: AlwaysStoppedAnimation(_green),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // --------------------
              // 본문 (스크롤)
              // --------------------
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 프로필 + 타이틀
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/profile.svg',
                            width: 64,
                            height: 64,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              '일상 속 생활 패턴을\n알려주세요',
                              style: TextStyle(
                                fontSize: 22,
                                height: 1.25,
                                fontWeight: FontWeight.w900,
                                color: _text,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 26),

                      // --------------------
                      // 근무 시간
                      // --------------------
                      const _SectionLabel('근무 시간', requiredMark: true),
                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: workItems.map((t) {
                          final selected = _work == t;
                          return _ChipButton(
                            text: t,
                            selected: selected,
                            onTap: () => setState(() => _work = t),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 22),

                      // --------------------
                      // 수면 패턴
                      // --------------------
                      const _SectionLabel('수면 패턴', requiredMark: true),
                      const SizedBox(height: 12),

                      ...sleepItems.map((t) {
                        final selected = _sleep == t;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _SleepCard(
                            text: t,
                            selected: selected,
                            onTap: () => setState(() => _sleep = t),
                          ),
                        );
                      }),

                      const SizedBox(height: 8),

                      // --------------------
                      // 운동 습관
                      // --------------------
                      const _SectionLabel('운동 습관', requiredMark: true),
                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: workoutItems.map((t) {
                          final selected = _workout == t;
                          return _ChipButton(
                            text: t,
                            selected: selected,
                            onTap: () => setState(() => _workout = t),
                          );
                        }).toList(),
                      ),

                      // --------------------
                      // (시연용) 3개 선택 완료 시 경고 박스 노출
                      // --------------------
                      if (_canNext) ...[
                        const SizedBox(height: 22),
                        const _RiskBox(
                          title: '취약 구간 발견',
                          boldLine: '오후 4시(근무 중 허기)',
                          body: '가 가장 위험한 구간이군요. 이 시간에 특별 방어 미션을 배치하겠습니다.',
                        ),
                        const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
              ),

              // --------------------
              // 하단 다음 버튼
              // --------------------
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _canNext
                      ? () {
                          // TODO: 다음 온보딩 페이지로 연결
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const OnCompleteScreen(
                                reasonText: '신체적 부작용',
                                weightText: '16kg',
                                heightText: '15cm',
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    disabledBackgroundColor: const Color(0xFFBDBDBD),
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
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, {required this.requiredMark});

  final String text;
  final bool requiredMark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
        if (requiredMark) ...[
          const SizedBox(width: 4),
          const Text(
            '*',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFFEF4444),
            ),
          ),
        ],
      ],
    );
  }
}

// ✅ 근무시간/운동습관용 “pill chip”
class _ChipButton extends StatelessWidget {
  const _ChipButton({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  static const _green = Color(0xFF17B35D);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final bg = selected ? _green : Colors.white;
    final fg = selected ? Colors.white : const Color(0xFF111827);
    final bd = selected ? _green : _border;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: bd, width: 1.2),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: fg,
          ),
        ),
      ),
    );
  }
}

// ✅ 수면 패턴 카드
class _SleepCard extends StatelessWidget {
  const _SleepCard({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  static const _green = Color(0xFF17B35D);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final bg = selected ? _green.withOpacity(0.08) : Colors.white;
    final bd = selected ? _green : _border;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: bd, width: 1.2),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF111827),
          ),
        ),
      ),
    );
  }
}

// ✅ 취약 구간 박스(시연용)
class _RiskBox extends StatelessWidget {
  const _RiskBox({
    required this.title,
    required this.boldLine,
    required this.body,
  });

  final String title;
  final String boldLine;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333.21,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFC7C7), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 왼쪽 아이콘
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFFF6B6B),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.priority_high_rounded,
                  color: Colors.white, size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFEF4444),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  boldLine,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
