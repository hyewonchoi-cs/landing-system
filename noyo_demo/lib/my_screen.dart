import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);
  static const _bg = Color(0xFFF6F7F8);

  @override
  Widget build(BuildContext context) {
    // 더미 로그 데이터 (UI 시연용)
    final logs = <_LogItem>[
      _LogItem(
        time: '06:00',
        iconBg: _green,
        icon: Icons.check_rounded,
        title: '안정 시작',
        progress: 0.12,
        rightText: '위험도 8%',
        barColor: _green,
        badge: null,
      ),
      _LogItem(
        time: '09:30',
        iconBg: const Color(0xFFFFB020),
        icon: Icons.trending_up_rounded,
        title: '위험 상승 45%',
        progress: 0.45,
        rightText: '위험도 45%',
        barColor: const Color(0xFFFFB020),
        badge: null,
      ),
      _LogItem(
        time: '11:15',
        iconBg: const Color(0xFF8B5CF6),
        icon: Icons.opacity_rounded,
        title: '수분 쉴드 사용 -25%',
        progress: 0.20,
        rightText: '위험도 20%',
        barColor: _green,
        badge: _MiniBadge(text: '배지\n획득', icon: Icons.star_rounded),
        smallDot: _SmallDot(
            color: const Color(0xFFFFB020), icon: Icons.emoji_events_rounded),
      ),
      _LogItem(
        time: '13:45',
        iconBg: const Color(0xFFFFB020),
        icon: Icons.warning_amber_rounded,
        title: '위험 상승 67%',
        progress: 0.67,
        rightText: '위험도 67%',
        barColor: const Color(0xFFFFB020),
        badge: null,
      ),
      _LogItem(
        time: '15:20',
        iconBg: const Color(0xFFFF4D6D),
        icon: Icons.waves_rounded,
        title: '요요 공격 92%',
        progress: 0.92,
        rightText: '위험도 92%',
        barColor: const Color(0xFFFF4D6D),
        badge: null,
      ),
      _LogItem(
        time: '15:45',
        iconBg: const Color(0xFFA855F7),
        icon: Icons.shield_rounded,
        title: '회복 미션 활성화',
        progress: 0.78,
        rightText: '위험도 78%',
        barColor: const Color(0xFFFFB020),
        badge: null,
      ),
      _LogItem(
        time: '17:30',
        iconBg: const Color(0xFF10B981),
        icon: Icons.eco_rounded,
        title: '회복 진행 45%',
        progress: 0.45,
        rightText: '위험도 45%',
        barColor: const Color(0xFFFFB020),
        badge: _MiniBadge(text: '배지 획득', icon: Icons.star_rounded),
        smallDot: _SmallDot(
            color: const Color(0xFFFFB020), icon: Icons.emoji_events_rounded),
      ),
      _LogItem(
        time: '19:00',
        iconBg: const Color(0xFF22C55E),
        icon: Icons.favorite_rounded,
        title: '회복 완료 12%',
        progress: 0.12,
        rightText: '위험도 12%',
        barColor: _green,
        badge: null,
      ),
      _LogItem(
        time: '21:30',
        iconBg: _green,
        icon: Icons.check_rounded,
        title: '안정 복귀 성공',
        progress: 0.05,
        rightText: '위험도 5%',
        barColor: _green,
        badge: _MiniBadge(text: '배지 획득', icon: Icons.star_rounded),
        smallDot: _SmallDot(
            color: const Color(0xFFFFB020), icon: Icons.emoji_events_rounded),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --------------------
              // 상단바: 로고 + 아이콘
              // --------------------
              Row(
                children: [
                  SvgPicture.asset(
                    'logo.svg',
                    width: 40,
                    height: 32,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded),
                    color: _text,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined),
                    color: _text,
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // --------------------
              // 프로필 카드
              // --------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _bg,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    // 왼쪽 uo 원형
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: _green.withOpacity(0.12),
                        shape: BoxShape.circle,
                        border: Border.all(color: _green, width: 2),
                      ),
                      child: SvgPicture.asset(
                        'logo2.svg',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // 이름/직책
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '카스테라',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: _text,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '작성',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: _muted,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 우측 배지/알림 표시
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: _border),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.emoji_events_outlined,
                              size: 18, color: Color(0xFFFFB020)),
                          SizedBox(width: 6),
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: _text,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // 프로필 편집 줄
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                decoration: BoxDecoration(
                  border: Border.all(color: _border),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: const [
                    Text(
                      '프로필 편집',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: _text,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.chevron_right_rounded, color: _muted),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // --------------------
              // 획득한 배지
              // --------------------
              const Row(
                children: [
                  Icon(Icons.emoji_events_rounded,
                      color: Color(0xFFFFB020), size: 18),
                  SizedBox(width: 8),
                  Text(
                    '획득한 배지',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: _text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: const [
                  Expanded(
                    child: _BadgeCard(
                      active: true,
                      title: '안정 유지',
                      subtitle: '6시간 안정 유지',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _BadgeCard(
                      active: false,
                      title: '빠른 회복',
                      subtitle: '위험에서 빠른 복귀',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _BadgeCard(
                      active: false,
                      title: '수분 마스터',
                      subtitle: '수분 실드 연속 활용',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // --------------------
              // Log
              // --------------------
              const Text(
                'Log',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: _text,
                ),
              ),
              const SizedBox(height: 12),

              _Timeline(
                items: logs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  const _BadgeCard({
    required this.active,
    required this.title,
    required this.subtitle,
  });

  final bool active;
  final String title;
  final String subtitle;

  static const _border = Color(0xFFE5E7EB);
  static const _muted = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    final bg = active ? const Color(0xFFFFF7E6) : const Color(0xFFF3F4F6);
    final iconBg = active ? const Color(0xFFFFB020) : const Color(0xFFBDBDBD);

    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.emoji_events_rounded, color: iconBg, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: active ? const Color(0xFFFF8A00) : _muted,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: _muted,
              height: 1.15,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.items});

  final List<_LogItem> items;

  static const _line = Color(0xFFBFEBD3); // 연한 초록 라인
  static const _muted = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 왼쪽 세로 라인
        Positioned(
          left: 44, // 시간(약 40) + 여백(4)
          top: 0,
          bottom: 0,
          child: Container(
            width: 2,
            color: _line,
          ),
        ),

        Column(
          children: items.map((e) => _TimelineRow(item: e)).toList(),
        ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.item});

  final _LogItem item;

  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 시간
          SizedBox(
            width: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                item.time,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: _muted,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // 아이콘 (라인 위)
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: item.iconBg,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(item.icon, color: Colors.white, size: 22),
              ),
              if (item.smallDot != null)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: item.smallDot!.color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(item.smallDot!.icon,
                        color: Colors.white, size: 10),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 12),

          // 카드
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 타이틀 + 배지
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: _text,
                          ),
                        ),
                      ),
                      if (item.badge != null) ...[
                        const SizedBox(width: 10),
                        _MiniBadgeView(badge: item.badge!),
                      ],
                    ],
                  ),
                  const SizedBox(height: 10),

                  // progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: item.progress.clamp(0, 1),
                      minHeight: 6,
                      backgroundColor: const Color(0xFFF3F4F6),
                      valueColor: AlwaysStoppedAnimation(item.barColor),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      item.rightText,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: _muted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBadgeView extends StatelessWidget {
  const _MiniBadgeView({required this.badge});

  final _MiniBadge badge;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(badge.icon, color: const Color(0xFFFFB020), size: 14),
        const SizedBox(width: 4),
        Text(
          badge.text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: Color(0xFFFF8A00),
            height: 1.05,
          ),
        ),
      ],
    );
  }
}

class _LogItem {
  final String time;
  final Color iconBg;
  final IconData icon;
  final String title;
  final double progress;
  final String rightText;
  final Color barColor;
  final _MiniBadge? badge;
  final _SmallDot? smallDot;

  _LogItem({
    required this.time,
    required this.iconBg,
    required this.icon,
    required this.title,
    required this.progress,
    required this.rightText,
    required this.barColor,
    this.badge,
    this.smallDot,
  });
}

class _MiniBadge {
  final String text;
  final IconData icon;
  const _MiniBadge({required this.text, required this.icon});
}

class _SmallDot {
  final Color color;
  final IconData icon;
  const _SmallDot({required this.color, required this.icon});
}
