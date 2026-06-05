import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const InnovationHelloApp());
}


class InnovationHelloApp extends StatelessWidget {
  const InnovationHelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的创新空间',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HelloHomePage(),
    );
  }
}

class HelloHomePage extends StatefulWidget {
  const HelloHomePage({super.key});

  @override
  State<HelloHomePage> createState() => _HelloHomePageState();
}

class _HelloHomePageState extends State<HelloHomePage> {
  int completedTasks = 0;
  String currentMood = '🚀 准备起飞';
  final Random _random = Random();
  final List<String> _moods = [
    '🚀 准备起飞',
    '💪 加油学习',
    '🔥 热情满满',
    '✨ 闪闪发光',
    '🎯 目标明确',
    '🌟 状态极佳',
    '💫 灵感爆发',
    '🎨 创意无限',
  ];

  void finishOneTask() {
    setState(() {
      completedTasks += 1;
      currentMood = _moods[_random.nextInt(_moods.length)];
    });
  }

  String get _levelTitle {
    if (completedTasks < 5) return '🌱 新手入门';
    if (completedTasks < 10) return '🌿 渐入佳境';
    if (completedTasks < 20) return '🌳 小有建树';
    if (completedTasks < 50) return '🏆 Flutter 达人';
    return '👑 Flutter 大师';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade900,
              Colors.indigo.shade900,
              Colors.blue.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.code, color: Colors.amber, size: 28),
                    const SizedBox(width: 12),
                    const Text(
                      '我的创新空间',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.amber, Colors.orange],
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Text(
                            _levelTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            currentMood,
                            key: ValueKey(currentMood),
                            style: const TextStyle(fontSize: 64),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'Flutter 创新实验',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '王梓桓 | 学号：0109',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                '成长足迹',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '$completedTasks',
                                style: const TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                              const Text(
                                '次突破',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'reset',
                      onPressed: () {
                        setState(() {
                          completedTasks = 0;
                          currentMood = '🚀 准备起飞';
                        });
                      },
                      backgroundColor: Colors.red.withOpacity(0.8),
                      child: const Icon(Icons.refresh),
                    ),
                    FloatingActionButton.extended(
                      onPressed: finishOneTask,
                      icon: const Icon(Icons.flash_on),
                      label: const Text('突破自我'),
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black87,
                    ),
                    FloatingActionButton.small(
                      heroTag: 'share',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '已打卡 $completedTasks 次，继续加油！💪',
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      backgroundColor: Colors.blue.withOpacity(0.8),
                      child: const Icon(Icons.share),
                    ),
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
