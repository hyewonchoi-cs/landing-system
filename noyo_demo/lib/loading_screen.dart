import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const _text = Color(0xFF111827);
  static const _muted = Color(0xFF9CA3AF);

  static const _green = Color(0xFF17B35D); // ✅ 진한 초록
  static const _greenSoft = Color(0xFFBFEED6); // 로딩 중 버튼 색

  bool _done = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // ✅ 3초 로딩
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() => _done = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 뒤로가기
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
            ),

            const Spacer(),

            // 로딩 인디케이터
            SizedBox(
              width: 54,
              height: 54,
              child: CircularProgressIndicator(
                strokeWidth: 7,
                valueColor: AlwaysStoppedAnimation(
                  _done ? _green : _text,
                ),
                backgroundColor: const Color(0xFFE5E7EB),
              ),
            ),

            const Spacer(),

            // 하단 버튼
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _done
                      ? () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _done ? _green : _greenSoft,
                    disabledBackgroundColor: _greenSoft,
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
            ),
          ],
        ),
      ),
    );
  }
}
