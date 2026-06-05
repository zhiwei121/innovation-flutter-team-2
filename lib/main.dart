import 'package:flutter/material.dart';

void main() {
  runApp(const InnovationHelloApp());
}

class InnovationHelloApp extends StatelessWidget {
  const InnovationHelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '李四的创新实验',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
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

  void finishOneTask() {
    setState(() {
      completedTasks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E293B),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 图标
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Colors.indigo, Colors.deepPurple],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withOpacity(0.5),
                          blurRadius: 25,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.rocket_launch,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 标题
                  const Text(
                    '第 14 周入门任务完成 🎉',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    '李学海 · 第二小组',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 计数卡片
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Colors.indigo, Colors.deepPurple],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withOpacity(0.4),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(
                      '今日已完成 $completedTasks 次打卡',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 进度条
                  LinearProgressIndicator(
                    value: completedTasks / 10,
                    backgroundColor: Colors.white24,
                    valueColor:
                        const AlwaysStoppedAnimation(Colors.indigoAccent),
                    minHeight: 8,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '${(completedTasks / 10 * 100).clamp(0, 100).toInt()}%',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: finishOneTask,
        icon: const Icon(Icons.check),
        label: const Text('完成打卡'),
      ),
    );
  }
}