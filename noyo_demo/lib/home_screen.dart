import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'my_screen.dart'; // ✅ 새로 만들 마이 탭
import 'report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ====== Colors (figma 느낌) ======
  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _cardBorder = Color(0xFFE5E7EB);
  static const _bg = Colors.white;

  // bottom tab
  int _tabIndex = 0;

  // ====== Missions dummy ======
  final List<_DefenseMission> _missions = [
    _DefenseMission(
      id: 'water',
      title: '물 마시기',
      subtitle: '요요 위험 -25% 감소',
      reduce: 25,
      circleColor: Color(0xFF9DB7FF),
      icon: Icons.water_drop_rounded,
    ),
    _DefenseMission(
      id: 'breath',
      title: '호흡',
      subtitle: '요요 위험 -35% 감소',
      reduce: 35,
      circleColor: Color(0xFF87D7A6),
      icon: Icons.air_rounded,
    ),
    _DefenseMission(
      id: 'protein',
      title: '단백질 간식 섭취',
      subtitle: '요요 위험 -35% 감소',
      reduce: 35,
      circleColor: Color(0xFFF5E07C),
      icon: Icons.apple_rounded,
    ),
    _DefenseMission(
      id: 'walk',
      title: '빠른 걷기 30분',
      subtitle: '요요 위험 -40% 감소',
      reduce: 40,
      circleColor: Color(0xFFC8B3FF),
      icon: Icons.directions_walk_rounded,
    ),
  ];

  final Set<String> _doneIds = {};
  bool _shownFirstToast = false;

  int get _doneCount => _doneIds.length;
  int get _remainCount => _missions.length - _doneCount;

  int get _riskPercent {
    final reduced = _missions
        .where((m) => _doneIds.contains(m.id))
        .fold<int>(0, (sum, m) => sum + m.reduce);
    final v = 100 - reduced;
    return v.clamp(0, 100);
  }

  bool get _allDone => _riskPercent == 0;

  String get _headline {
    if (_allDone) return '모든 미션 완료! 🎉';
    return '미션 $_remainCount개만 더 하면 완료에요!';
  }

  String get _riskTitle {
    if (_allDone) return '안정 상태 도달!';
    if (_riskPercent <= 50) return '위험이 줄어들고 있어요!';
    return '요요 공격이 다가오고 있어요!';
  }

  Color get _riskBarColor {
    if (_allDone) return _green;
    if (_riskPercent <= 50) return const Color(0xFFFF8A00);
    return const Color(0xFFEF4444);
  }

  void _toggleMission(_DefenseMission m) {
    setState(() {
      final wasDone = _doneIds.contains(m.id);
      if (wasDone) {
        _doneIds.remove(m.id);
      } else {
        _doneIds.add(m.id);
        if (!_shownFirstToast) {
          _shownFirstToast = true;
          _showBlockedToast();
        } else {
          _showBlockedToast();
        }
      }
    });
  }

  void _showBlockedToast() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _green,
        margin: const EdgeInsets.only(left: 70, right: 70, bottom: 130),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        duration: const Duration(milliseconds: 900),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shield_rounded, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              '차단 성공!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ 핵심: 탭 화면들을 한 Scaffold 안에서 교체
    final tabs = <Widget>[
      _homeBody(), // 홈
      const ReportScreen(), // 리포트
      const MyScreen(), // 마이
    ];

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: IndexedStack(
          index: _tabIndex,
          children: tabs,
        ),
      ),
      bottomNavigationBar: _FloatingBottomTabs(
        index: _tabIndex,
        onChanged: (i) => setState(() => _tabIndex = i),
      ),
    );
  }

  Widget _homeBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== top bar =====
          Row(
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                width: 70,
                height: 32,
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

          const SizedBox(height: 12),

          const Text(
            '카스테라님',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),

          Text(
            _headline,
            style: const TextStyle(
              fontSize: 24,
              height: 1.2,
              fontWeight: FontWeight.w900,
              color: _text,
            ),
          ),

          const SizedBox(height: 16),

          _RiskGaugeCard(
            title: _riskTitle,
            percent: _riskPercent,
            barColor: _riskBarColor,
            allDone: _allDone,
          ),

          const SizedBox(height: 22),

          const Text(
            '방어 미션',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: _text,
            ),
          ),

          const SizedBox(height: 12),

          ..._missions.map((m) {
            final done = _doneIds.contains(m.id);
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _DefenseMissionCard(
                mission: m,
                done: done,
                onTap: () => _toggleMission(m),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// =========================
// Risk Gauge Card
// =========================
class _RiskGaugeCard extends StatelessWidget {
  const _RiskGaugeCard({
    required this.title,
    required this.percent,
    required this.barColor,
    required this.allDone,
  });

  final String title;
  final int percent;
  final Color barColor;
  final bool allDone;

  static const _text = Color(0xFF111827);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final isSafe = allDone;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border, width: 1.2),
        boxShadow: isSafe
            ? [
                BoxShadow(
                  color: const Color(0xFF17B35D).withOpacity(0.15),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                )
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  '요요 위험 게이지',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              if (!isSafe)
                Container(
                  width: 34,
                  height: 34,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE7E7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.priority_high_rounded,
                    color: Color(0xFFFF3B30),
                  ),
                )
              else
                const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF22C55E),
                  size: 32,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              height: 1.2,
              fontWeight: FontWeight.w900,
              color: _text,
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: percent / 100.0,
              minHeight: 14,
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: AlwaysStoppedAnimation(barColor),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                '안전',
                style: TextStyle(
                  color: Color(0xFF17B35D),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                '$percent%',
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              const Text(
                '위험',
                style: TextStyle(
                  color: Color(0xFFEF4444),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =========================
// Mission Card
// =========================
class _DefenseMissionCard extends StatelessWidget {
  const _DefenseMissionCard({
    required this.mission,
    required this.done,
    required this.onTap,
  });

  final _DefenseMission mission;
  final bool done;
  final VoidCallback onTap;

  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final bg = done ? _green.withOpacity(0.06) : Colors.white;
    final borderColor = done ? _green : _border;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 1.4),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: mission.circleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(mission.icon, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mission.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: done ? _green : _text,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    mission.subtitle,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _green,
                    ),
                  ),
                ],
              ),
            ),
            if (done)
              Container(
                width: 34,
                height: 34,
                decoration: const BoxDecoration(
                  color: _green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white),
              )
            else
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: _muted,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// =========================
// Floating bottom tabs
// =========================
class _FloatingBottomTabs extends StatelessWidget {
  const _FloatingBottomTabs({
    required this.index,
    required this.onChanged,
  });

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
        child: Container(
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TabItem(
                label: '홈',
                icon: Icons.home_filled,
                active: index == 0,
                onTap: () => onChanged(0),
              ),
              _TabItem(
                label: '리포트',
                icon: Icons.insert_chart_outlined,
                active: index == 1,
                onTap: () => onChanged(1),
              ),
              _TabItem(
                label: '마이',
                icon: Icons.person_rounded,
                active: index == 2,
                onTap: () => onChanged(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            Icon(icon, color: active ? _text : _muted),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: active ? _text : _muted,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// Models
// =========================
class _DefenseMission {
  const _DefenseMission({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.reduce,
    required this.circleColor,
    required this.icon,
  });

  final String id;
  final String title;
  final String subtitle;
  final int reduce;
  final Color circleColor;
  final IconData icon;
}
