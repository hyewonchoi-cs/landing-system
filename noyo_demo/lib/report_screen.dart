import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5E7EB);
  static const _cardBg = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Top Bar =====
              Row(
                children: [
                  SvgPicture.asset(
                    'logo.svg',
                    width: 60,
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

              const SizedBox(height: 10),

              // ===== Week Selector =====
              Row(
                children: [
                  _RoundIconButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Center(
                      child: Text(
                        '10월 1주차 리포트',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: _text,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _RoundIconButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ===== Summary Card =====
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                decoration: BoxDecoration(
                  color: _cardBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: _border, width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row: uo badge + summary text
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _UoBadge(),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.35,
                                color: _text,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(text: '김지우님 '),
                                TextSpan(
                                  text: '‘안정화 단계’',
                                  style: TextStyle(
                                    color: _green,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        '\n에 진입했어요. 몸이 새로운 균형을 찾고\n있으며, 자생력이 크게 향상되었습니다.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Score pill
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Text(
                                '요요 방어 점수',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: _text,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '78/100',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: _green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: const LinearProgressIndicator(
                              value: 0.78,
                              minHeight: 8,
                              backgroundColor: Color(0xFFD1D5DB),
                              valueColor: AlwaysStoppedAnimation(_green),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ===== Mission Trend Card =====
              _SectionCard(
                title: '미션 진행률 추세',
                rightIcon: Icons.trending_up_rounded,
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(
                          child: _MiniStatCard(
                            label: '주간 미션 성공',
                            value: '32개',
                            valueColor: _text,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _MiniStatCard(
                            label: '평균 자생력',
                            value: '78%',
                            valueColor: _green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: _LineChart(
                        points: const [50, 68, 82, 88, 92, 98, 94], // 더미
                        fill: true,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const _XAxisLabels(
                        labels: ['월', '화', '수', '목', '금', '토', '일']),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ===== Weight Trend Card =====
              _SectionCard(
                title: '몸무게 변화 추세',
                subtitle: '안전 대역 내 유지 중',
                rightIcon: Icons.monitor_heart_rounded,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFFCF4),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: _WeightInfo(
                              label: '현재 몸무게',
                              value: '72.1',
                              unit: 'kg',
                              valueColor: _text,
                            ),
                          ),
                          Expanded(
                            child: _WeightInfo(
                              label: '주간 변화',
                              value: '-0.2',
                              unit: 'kg',
                              valueColor: _green,
                              alignEnd: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: _LineChart(
                        // 71~73 근처로 왔다갔다 느낌
                        points: const [
                          72.6,
                          72.3,
                          72.7,
                          72.4,
                          72.2,
                          72.5,
                          72.3
                        ],
                        yMin: 69,
                        yMax: 75,
                        fill: true,
                        safeBandMin: 71,
                        safeBandMax: 73,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const _XAxisLabels(
                        labels: ['월', '화', '수', '목', '금', '토', '일']),
                    const SizedBox(height: 10),
                    const _LegendRow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================
// Small components
// =====================

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Icon(icon, color: const Color(0xFF6B7280)),
      ),
    );
  }
}

class _UoBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: const BoxDecoration(
        color: Color(0xFFEFFCF4),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'uo',
          style: TextStyle(
            color: Color(0xFF17B35D),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.rightIcon,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final IconData rightIcon;
  final Widget child;

  static const _text = Color(0xFF111827);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: _text,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFFCF4),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Icon(rightIcon, color: const Color(0xFF17B35D)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _MiniStatCard extends StatelessWidget {
  const _MiniStatCard({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightInfo extends StatelessWidget {
  const _WeightInfo({
    required this.label,
    required this.value,
    required this.unit,
    required this.valueColor,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final String unit;
  final Color valueColor;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment:
              alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: valueColor,
              ),
            ),
            const SizedBox(width: 6),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                unit,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _XAxisLabels extends StatelessWidget {
  const _XAxisLabels({required this.labels});
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: labels
          .map(
            (t) => Expanded(
              child: Center(
                child: Text(
                  t,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(
          color: const Color(0xFFBFF3D1),
          label: '안전 대역',
          isLine: false,
        ),
        const SizedBox(width: 14),
        _LegendItem(
          color: const Color(0xFF17B35D),
          label: '실제 몸무게',
          isLine: true,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.isLine,
  });

  final Color color;
  final String label;
  final bool isLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: isLine ? 26 : 26,
          height: isLine ? 4 : 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

// =====================
// Simple line chart painter
// =====================

class _LineChart extends StatelessWidget {
  const _LineChart({
    required this.points,
    this.yMin,
    this.yMax,
    this.fill = true,
    this.safeBandMin,
    this.safeBandMax,
  });

  final List<double> points;
  final double? yMin;
  final double? yMax;
  final bool fill;

  /// weight chart에서 안전대역(밴드) 표시
  final double? safeBandMin;
  final double? safeBandMax;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LineChartPainter(
        points: points,
        yMin: yMin,
        yMax: yMax,
        fill: fill,
        safeBandMin: safeBandMin,
        safeBandMax: safeBandMax,
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.points,
    required this.yMin,
    required this.yMax,
    required this.fill,
    required this.safeBandMin,
    required this.safeBandMax,
  });

  final List<double> points;
  final double? yMin;
  final double? yMax;
  final bool fill;
  final double? safeBandMin;
  final double? safeBandMax;

  static const _green = Color(0xFF17B35D);

  @override
  void paint(Canvas canvas, Size size) {
    final padL = 14.0;
    final padR = 10.0;
    final padT = 10.0;
    final padB = 22.0;

    final chartW = size.width - padL - padR;
    final chartH = size.height - padT - padB;

    // grid lines (y=100/75/50/25 느낌)
    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;

    for (int i = 0; i < 4; i++) {
      final y = padT + chartH * (i / 3);
      canvas.drawLine(Offset(padL, y), Offset(padL + chartW, y), gridPaint);
    }

    // y range
    final minV = yMin ?? points.reduce((a, b) => a < b ? a : b);
    final maxV = yMax ?? points.reduce((a, b) => a > b ? a : b);
    final range = (maxV - minV).abs() < 0.0001 ? 1.0 : (maxV - minV);

    double toY(double v) {
      final t = (v - minV) / range;
      return padT + chartH * (1 - t);
    }

    double toX(int i) {
      if (points.length == 1) return padL + chartW / 2;
      return padL + chartW * (i / (points.length - 1));
    }

    // safe band (weight chart)
    if (safeBandMin != null && safeBandMax != null) {
      final top = toY(safeBandMax!);
      final bottom = toY(safeBandMin!);
      final bandRect = Rect.fromLTRB(padL, top, padL + chartW, bottom);
      final bandPaint = Paint()
        ..color = const Color(0xFFBFF3D1).withOpacity(0.45);
      canvas.drawRRect(
        RRect.fromRectAndRadius(bandRect, const Radius.circular(12)),
        bandPaint,
      );
    }

    // path
    final path = Path();
    for (int i = 0; i < points.length; i++) {
      final x = toX(i);
      final y = toY(points[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // fill under line (연한 그라데이션 느낌)
    if (fill) {
      final fillPath = Path.from(path)
        ..lineTo(toX(points.length - 1), padT + chartH)
        ..lineTo(toX(0), padT + chartH)
        ..close();

      final fillPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _green.withOpacity(0.20),
            _green.withOpacity(0.00),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

      canvas.drawPath(fillPath, fillPaint);
    }

    final linePaint = Paint()
      ..color = _green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);

    // points
    final dotPaint = Paint()..color = _green;
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(Offset(toX(i), toY(points[i])), 4.5, dotPaint);
      canvas.drawCircle(
        Offset(toX(i), toY(points[i])),
        4.5,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(Offset(toX(i), toY(points[i])), 3.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.yMin != yMin ||
        oldDelegate.yMax != yMax ||
        oldDelegate.safeBandMin != safeBandMin ||
        oldDelegate.safeBandMax != safeBandMax ||
        oldDelegate.fill != fill;
  }
}
