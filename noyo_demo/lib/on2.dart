import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noyo_demo/on3.dart';

// TODO: 너 프로젝트 홈 화면 import로 교체
// import 'home_screen.dart';

class On2Screen extends StatefulWidget {
  const On2Screen({super.key, required this.prevAnswerKey});

  final String prevAnswerKey;

  @override
  State<On2Screen> createState() => _On2ScreenState();
}

class _On2ScreenState extends State<On2Screen> {
  static const _green = Color(0xFF17B35D);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);
  static const _progressBg = Color(0xFFEFF1F4);

  final _weightCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();

  bool _analyzed = false; // ✅ 분석 완료 여부

  bool get _filled =>
      _weightCtrl.text.trim().isNotEmpty && _heightCtrl.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _weightCtrl.addListener(_onChanged);
    _heightCtrl.addListener(_onChanged);
  }

  void _onChanged() {
    // ✅ 분석 전에는 입력 변화에 따라 버튼 활성화만 갱신
    // 분석 후에는 입력이 막히므로 여기서 특별히 할 것 없음
    if (!_analyzed) setState(() {});
  }

  @override
  void dispose() {
    _weightCtrl.removeListener(_onChanged);
    _heightCtrl.removeListener(_onChanged);
    _weightCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  void _onPrimaryButtonPressed() {
    if (!_filled) return;

    if (!_analyzed) {
      // ✅ 1) 분석하기 단계
      FocusScope.of(context).unfocus(); // 키보드 닫기
      setState(() {
        _analyzed = true; // 입력 비활성화 + 결과 박스 노출
      });
      return;
    }

    // ✅ 2) 다음 단계

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const On3Screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 더미 결과(시연용)
    final dummyBmi = '10625.0';
    final dummyBmr = '-116kcal';

    final buttonEnabled = _filled;
    final buttonLabel = _analyzed ? '다음' : '분석하기';

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
                      value: 0.36,
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
                              '현재 신체 지표를 입력하여\n유지 관리 계획을 세워볼게요',
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

                      // 현재 체중
                      const _FieldLabel('현재 체중', requiredMark: true),
                      const SizedBox(height: 10),
                      _UnitTextField(
                        controller: _weightCtrl,
                        hintText: '체중을 입력해주세요',
                        unitText: 'kg',
                        enabled: !_analyzed, // ✅ 분석 후 입력 비활성화
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),

                      const SizedBox(height: 22),

                      // 키
                      const _FieldLabel('키', requiredMark: true),
                      const SizedBox(height: 10),
                      _UnitTextField(
                        controller: _heightCtrl,
                        hintText: '키를 입력해주세요',
                        unitText: 'cm',
                        enabled: !_analyzed, // ✅ 분석 후 입력 비활성화
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),

                      // ✅ 분석 완료 후에만 결과 박스 노출
                      if (_analyzed) ...[
                        const SizedBox(height: 22),
                        _AiAnalyzeBox(
                          bmiValue: dummyBmi,
                          bmrValue: dummyBmr,
                          secondLine:
                              '약물 없이도 현재 체중을 건강하게 유지할 수 있도록, 요요 방지에 최적화된 미션을 준비하겠습니다.',
                        ),
                        const SizedBox(height: 8),
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
                  onPressed: buttonEnabled ? _onPrimaryButtonPressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    disabledBackgroundColor: const Color(0xFFBDBDBD),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    buttonLabel,
                    style: const TextStyle(
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text, {required this.requiredMark});

  final String text;
  final bool requiredMark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),
        if (requiredMark) ...[
          const SizedBox(width: 4),
          const Text(
            '*',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFFEF4444),
            ),
          ),
        ],
      ],
    );
  }
}

class _UnitTextField extends StatelessWidget {
  const _UnitTextField({
    required this.controller,
    required this.hintText,
    required this.unitText,
    required this.enabled,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final String unitText;
  final bool enabled;
  final TextInputType keyboardType;

  static const _fieldBg = Color(0xFFF3F4F6);
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: _fieldBg,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              keyboardType: keyboardType,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _text,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: _muted.withOpacity(0.45),
                  fontWeight: FontWeight.w700,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            unitText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _AiAnalyzeBox extends StatelessWidget {
  const _AiAnalyzeBox({
    required this.bmiValue,
    required this.bmrValue,
    required this.secondLine,
  });

  final String bmiValue;
  final String bmrValue;
  final String secondLine;

  static const _green = Color(0xFF17B35D);
  static const _bg = Color(0xFFF8F8F8);
  static const _text = Color(0xFF111827);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 333.21,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'ai_logo.svg',
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 14),
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
                  const TextSpan(text: '현재 BMI는 '),
                  TextSpan(
                    text: bmiValue,
                    style: const TextStyle(
                      color: _green,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: '이고, 기초 대사량은'),
                  TextSpan(
                    text: bmrValue,
                    style: const TextStyle(
                      color: _green,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: '입니다.\n\n'),
                  TextSpan(text: secondLine),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
