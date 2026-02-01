import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'on2.dart';

class On1Screen extends StatefulWidget {
  const On1Screen({super.key});

  @override
  State<On1Screen> createState() => _On1ScreenState();
}

class _On1ScreenState extends State<On1Screen> {
  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);
  static const _progressBg = Color(0xFFEFF1F4);

  String? _selected;
  bool get _canNext => _selected != null;

  @override
  Widget build(BuildContext context) {
    final items = const <_ReasonItem>[
      _ReasonItem(
        keyValue: 'cost',
        title: '비용 부담',
        subtitle: '경제적 지속 가능성을 위한 맞춤 플랜',
      ),
      _ReasonItem(
        keyValue: 'side_effect',
        title: '신체적 부작용',
        subtitle: '메스꺼움, 탈모 등 건강 회복이 우선',
      ),
      _ReasonItem(
        keyValue: 'pregnancy',
        title: '임신 계획',
        subtitle: '안전한 몸 상태를 만드는 것이 목표',
      ),
      _ReasonItem(
        keyValue: 'etc',
        title: '기타',
        subtitle: '내성 걱정, 목표 체중 도달 등',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20), // ✅ 전체 화면 padding 20
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
                      value: 0.18,
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
                      // 프로필 + 질문
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
                              '치료제 사용을 종료한\n결정적인 이유는 무엇인가요?',
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

                      const SizedBox(height: 25),

                      // 선택 카드 리스트
                      ...items.map((e) {
                        final selected = _selected == e.keyValue;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Center(
                            // ✅ 고정 width(333.21)일 때 중앙 정렬
                            child: _ReasonCard(
                              title: e.title,
                              subtitle: e.subtitle,
                              selected: selected,
                              onTap: () =>
                                  setState(() => _selected = e.keyValue),
                            ),
                          ),
                        );
                      }),

                      // ✅ "신체적 부작용" 선택 시에만 AI 설명 박스 노출
                      if (_selected == 'side_effect') ...[
                        const SizedBox(height: 6),
                        const Center(
                          child: _AiExplainBox(
                            highlight: '신체적 부작용',
                            textBefore: '그 결심이 흔들리지 않도록, ',
                            textAfter: '에 최적화된 방어막을 설계할게요.',
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
              ),

              // --------------------
              // 하단 버튼
              // --------------------
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _canNext
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  On2Screen(prevAnswerKey: _selected!),
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

class _ReasonItem {
  final String keyValue;
  final String title;
  final String subtitle;
  const _ReasonItem({
    required this.keyValue,
    required this.title,
    required this.subtitle,
  });
}

class _ReasonCard extends StatelessWidget {
  const _ReasonCard({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  static const double _cardW = 333.21;
  static const double _cardH = 93.291;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? _green.withOpacity(0.08) : Colors.white;
    final borderColor = selected ? _green : _border;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: _cardW,
        height: _cardH,
        padding: const EdgeInsets.fromLTRB(21.35, 21.35, 21.35, 21.35),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ 선택 원
            Container(
              width: 26,
              height: 26,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? _green : const Color(0xFFBDBDBD),
                  width: 2,
                ),
                color: selected ? _green : Colors.transparent,
              ),
              child: selected
                  ? const Center(
                      child: Icon(Icons.check, size: 16, color: Colors.white),
                    )
                  : null,
            ),

            const SizedBox(width: 14),

            // ✅ 텍스트 영역 (세로 정렬)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: _text,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // 설명
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _muted,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiExplainBox extends StatelessWidget {
  const _AiExplainBox({
    required this.highlight,
    required this.textBefore,
    required this.textAfter,
  });

  final String highlight;
  final String textBefore;
  final String textAfter;

  static const _green = Color(0xFF17B35D);
  static const _bg = Color(0xFFF8F8F8);
  static const _text = Color(0xFF111827);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333.21, // 카드와 동일 폭
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ✅ AI SVG 아이콘
          SvgPicture.asset(
            'ai_logo.svg',
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 16),

          // ✅ 텍스트 영역
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _text,
                  height: 1.35,
                ),
                children: [
                  TextSpan(text: textBefore),
                  TextSpan(
                    text: highlight,
                    style: const TextStyle(
                      color: _green,
                      fontWeight: FontWeight.w700, // 강조만 살짝
                    ),
                  ),
                  TextSpan(text: textAfter),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
