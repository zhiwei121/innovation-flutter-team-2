import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const InnovationHelloApp());
}

class InnovationHelloApp extends StatelessWidget {
  const InnovationHelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '创新实验 Flutter 入门',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B9D),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'PingFang SC',
      ),
      home: const HelloHomePage(),
    );
  }
}

// ── 卡通星星粒子 ──────────────────────────────────────
class StarParticle {
  double x;
  double y;
  double size;
  double speedX;
  double speedY;
  double opacity;
  Color color;
  double rotation;

  StarParticle({
    required this.x,
    required this.y,
    required this.size,
    required this.speedX,
    required this.speedY,
    required this.opacity,
    required this.color,
    required this.rotation,
  });
}

// ── 卡通火箭绘制 ──────────────────────────────────────
class CartoonRocketPainter extends CustomPainter {
  final double wobble;

  CartoonRocketPainter({this.wobble = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(wobble * 0.05);

    final bodyPaint = Paint()..color = const Color(0xFFFF6B9D);
    final windowPaint = Paint()..color = const Color(0xFF81D4FA);
    final windowBorderPaint = Paint()
      ..color = const Color(0xFFE1F5FE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final nosePaint = Paint()..color = const Color(0xFFFFAB91);
    final finPaint = Paint()..color = const Color(0xFFFFD54F);
    final flamePaint1 = Paint()..color = const Color(0xFFFFF176);
    final flamePaint2 = Paint()..color = const Color(0xFFFFAB40);
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    // 火焰
    final flamePath = Path();
    flamePath.moveTo(-12, 38);
    flamePath.quadraticBezierTo(-6, 58 + sin(wobble * 0.3) * 6, 0, 62 + sin(wobble * 0.3) * 8);
    flamePath.quadraticBezierTo(6, 58 + sin(wobble * 0.3 + 1) * 6, 12, 38);
    canvas.drawPath(flamePath, flamePaint2);

    final innerFlamePath = Path();
    innerFlamePath.moveTo(-7, 38);
    innerFlamePath.quadraticBezierTo(-3, 50 + sin(wobble * 0.4) * 4, 0, 52 + sin(wobble * 0.4) * 5);
    innerFlamePath.quadraticBezierTo(3, 50 + sin(wobble * 0.4 + 1) * 4, 7, 38);
    canvas.drawPath(innerFlamePath, flamePaint1);

    // 左侧尾翼
    final leftFinPath = Path();
    leftFinPath.moveTo(-18, 22);
    leftFinPath.lineTo(-32, 40);
    leftFinPath.lineTo(-18, 36);
    leftFinPath.close();
    canvas.drawPath(leftFinPath, finPaint);

    // 右侧尾翼
    final rightFinPath = Path();
    rightFinPath.moveTo(18, 22);
    rightFinPath.lineTo(32, 40);
    rightFinPath.lineTo(18, 36);
    rightFinPath.close();
    canvas.drawPath(rightFinPath, finPaint);

    // 火箭身体（圆角矩形）
    final bodyRect = RRect.fromRectAndCorners(
      const Rect.fromLTWH(-20, -20, 40, 60),
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft: const Radius.circular(6),
      bottomRight: const Radius.circular(6),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    // 身体高光
    final highlightRect = RRect.fromRectAndCorners(
      const Rect.fromLTWH(-14, -14, 12, 48),
      topLeft: const Radius.circular(12),
      bottomLeft: const Radius.circular(4),
    );
    canvas.drawRRect(highlightRect, highlightPaint);

    // 火箭头部（鼻锥）
    final nosePath = Path();
    nosePath.moveTo(0, -38);
    nosePath.quadraticBezierTo(-22, -12, -20, -14);
    nosePath.lineTo(20, -14);
    nosePath.quadraticBezierTo(22, -12, 0, -38);
    canvas.drawPath(nosePath, nosePaint);

    // 窗户
    canvas.drawCircle(const Offset(0, 4), 11, windowPaint);
    canvas.drawCircle(const Offset(0, 4), 11, windowBorderPaint);

    // 窗户高光
    final windowHighlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(-3, 1), 4, windowHighlightPaint);

    // 小星星装饰
    _drawStar(canvas, -28, -22, 5, const Color(0xFFFFD54F));
    _drawStar(canvas, 26, -10, 4, const Color(0xFFCE93D8));
    _drawStar(canvas, -22, 16, 3, const Color(0xFF81D4FA));

    canvas.restore();
  }

  void _drawStar(Canvas canvas, double x, double y, double size, Color color) {
    final paint = Paint()..color = color;
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = -pi / 2 + (2 * pi * i / 5);
      final innerAngle = angle + pi / 5;
      if (i == 0) {
        path.moveTo(x + cos(angle) * size, y + sin(angle) * size);
      } else {
        path.lineTo(x + cos(angle) * size, y + sin(angle) * size);
      }
      path.lineTo(x + cos(innerAngle) * size * 0.4, y + sin(innerAngle) * size * 0.4);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CartoonRocketPainter oldDelegate) {
    return wobble != oldDelegate.wobble;
  }
}

// ── 波浪背景 ──────────────────────────────────────
class WaveBackgroundPainter extends CustomPainter {
  final Color color1;
  final Color color2;
  final double animationValue;

  WaveBackgroundPainter({
    required this.color1,
    required this.color2,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 渐变背景
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFFFF3E0),
          const Color(0xFFFFE0B2),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 第一层波浪
    final wave1Paint = Paint()..color = color1;
    final wave1Path = Path();
    wave1Path.moveTo(0, size.height);
    for (double x = 0; x <= size.width; x++) {
      final y = size.height - 60 +
          sin((x / size.width * 2 * pi) + animationValue * 2) * 15;
      wave1Path.lineTo(x, y);
    }
    wave1Path.lineTo(size.width, size.height);
    wave1Path.close();
    canvas.drawPath(wave1Path, wave1Paint);

    // 第二层波浪
    final wave2Paint = Paint()..color = color2;
    final wave2Path = Path();
    wave2Path.moveTo(0, size.height);
    for (double x = 0; x <= size.width; x++) {
      final y = size.height - 35 +
          sin((x / size.width * 2 * pi) + animationValue * 2 + 1.5) * 12;
      wave2Path.lineTo(x, y);
    }
    wave2Path.lineTo(size.width, size.height);
    wave2Path.close();
    canvas.drawPath(wave2Path, wave2Paint);
  }

  @override
  bool shouldRepaint(covariant WaveBackgroundPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}

// ── 装饰云朵 ──────────────────────────────────────
class CloudPainter extends CustomPainter {
  final Color color;

  CloudPainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 用多个圆组合出云朵形状
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.55), size.height * 0.35, paint);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.45), size.height * 0.42, paint);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.55), size.height * 0.32, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.65), size.height * 0.3, paint);
  }

  @override
  bool shouldRepaint(covariant CloudPainter oldDelegate) => false;
}

// ── 主页面 ──────────────────────────────────────
class HelloHomePage extends StatefulWidget {
  const HelloHomePage({super.key});

  @override
  State<HelloHomePage> createState() => _HelloHomePageState();
}

class _HelloHomePageState extends State<HelloHomePage>
    with TickerProviderStateMixin {
  int completedTasks = 0;
  double _rocketWobble = 0;
  double _waveAnimation = 0;
  List<StarParticle> _stars = [];
  bool _showCelebration = false;

  late AnimationController _rocketController;
  late AnimationController _waveController;
  late AnimationController _celebrationController;

  @override
  void initState() {
    super.initState();

    _rocketController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _rocketController.addListener(() {
      setState(() {
        _rocketWobble = sin(_rocketController.value * 2 * pi) * 3;
      });
    });

    _waveController.addListener(() {
      setState(() {
        _waveAnimation = _waveController.value;
      });
    });

    _celebrationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showCelebration = false;
          _stars.clear();
        });
      }
    });
  }

  @override
  void dispose() {
    _rocketController.dispose();
    _waveController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  void _spawnStars(Size screenSize) {
    final random = Random();
    final colors = [
      const Color(0xFFFFD54F),
      const Color(0xFFCE93D8),
      const Color(0xFF81D4FA),
      const Color(0xFFFFAB91),
      const Color(0xFFA5D6A7),
    ];

    _stars = List.generate(12, (index) {
      return StarParticle(
        x: screenSize.width / 2,
        y: screenSize.height / 2 + 50,
        size: random.nextDouble() * 6 + 4,
        speedX: (random.nextDouble() - 0.5) * 200,
        speedY: -(random.nextDouble() * 150 + 80),
        opacity: 1.0,
        color: colors[random.nextInt(colors.length)],
        rotation: random.nextDouble() * 2 * pi,
      );
    });
  }

  void finishOneTask() {
    setState(() {
      completedTasks += 1;
      _showCelebration = true;
    });

    final box = context.findRenderObject() as RenderBox;
    _spawnStars(box.size);
    _celebrationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 4),
            Text(
              '🚀 唐三的创新实验室',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                color: const Color(0xFF5D4037),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFF3E0).withValues(alpha: 0.85),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 波浪背景
          Positioned.fill(
            child: CustomPaint(
              painter: WaveBackgroundPainter(
                color1: const Color(0xFFFFCCBC).withValues(alpha: 0.5),
                color2: const Color(0xFFFFAB91).withValues(alpha: 0.4),
                animationValue: _waveAnimation,
              ),
            ),
          ),

          // 装饰云朵 - 左上
          Positioned(
            top: 80,
            left: -20,
            child: Opacity(
              opacity: 0.6,
              child: CustomPaint(
                size: const Size(100, 50),
                painter: CloudPainter(color: Colors.white.withValues(alpha: 0.8)),
              ),
            ),
          ),

          // 装饰云朵 - 右上
          Positioned(
            top: 120,
            right: -10,
            child: Opacity(
              opacity: 0.5,
              child: CustomPaint(
                size: const Size(80, 40),
                painter: CloudPainter(color: Colors.white.withValues(alpha: 0.7)),
              ),
            ),
          ),

          // 主内容
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 卡通火箭
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.elasticOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: CustomPaint(
                          painter: CartoonRocketPainter(wobble: _rocketWobble),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 气泡问候卡片
                    _buildBubbleCard(
                      child: Column(
                        children: [
                          const Text(
                            '🎉 Hello Flutter！',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFFE91E63),
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '我已经完成第14周入门任务啦！',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF8D6E63),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      color: const Color(0xFFFFF9C4),
                    ),

                    const SizedBox(height: 16),

                    // 个人信息卡片
                    _buildBubbleCard(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildInfoChip('👤', '唐三'),
                          const SizedBox(width: 12),
                          _buildInfoChip('🔢', '0061'),
                          const SizedBox(width: 12),
                          _buildInfoChip('👥', '2组'),
                        ],
                      ),
                      color: const Color(0xFFE1F5FE),
                    ),

                    const SizedBox(height: 20),

                    // 打卡计数卡片
                    _buildBubbleCard(
                      child: Column(
                        children: [
                          Text(
                            '🌟 今日打卡',
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0xFF8D6E63),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '$completedTasks',
                                style: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFFF6B9D),
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '次',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: const Color(0xFFFF8A65),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      color: const Color(0xFFFCE4EC),
                    ),

                    const SizedBox(height: 24),

                    // 卡通打卡按钮
                    _buildCartoonButton(),
                  ],
                ),
              ),
            ),
          ),

          // 星星庆祝效果
          if (_showCelebration)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedBuilder(
                  animation: _celebrationController,
                  builder: (context, _) {
                    return CustomPaint(
                      painter: CelebrationPainter(
                        stars: _stars,
                        progress: _celebrationController.value,
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBubbleCard({required Widget child, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: child,
    );
  }

  Widget _buildInfoChip(String emoji, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFFE0B2),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5D4037),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartoonButton() {
    return GestureDetector(
      onTapDown: (_) => setState(() {}),
      onTapUp: (_) => finishOneTask(),
      onTapCancel: () => setState(() {}),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B9D), Color(0xFFFF8A65)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            const BoxShadow(
              color: Color(0xFFFF6B9D),
              blurRadius: 16,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '✨',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(width: 8),
            Text(
              '完成一次打卡',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '✨',
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}

// ── 庆祝动画绘制 ──────────────────────────────────────
class CelebrationPainter extends CustomPainter {
  final List<StarParticle> stars;
  final double progress;

  CelebrationPainter({required this.stars, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final currentX = star.x + star.speedX * progress;
      final currentY = star.y + star.speedY * progress + 150 * progress * progress;
      final currentOpacity = (1 - progress) * star.opacity;
      final currentSize = star.size * (1 - progress * 0.5);

      if (currentOpacity <= 0) continue;

      final paint = Paint()
        ..color = star.color.withValues(alpha: currentOpacity.clamp(0.0, 1.0));

      canvas.save();
      canvas.translate(currentX, currentY);
      canvas.rotate(star.rotation + progress * 4);

      // 绘制五角星
      final path = Path();
      for (int i = 0; i < 5; i++) {
        final outerAngle = -pi / 2 + (2 * pi * i / 5);
        final innerAngle = outerAngle + pi / 5;
        if (i == 0) {
          path.moveTo(cos(outerAngle) * currentSize, sin(outerAngle) * currentSize);
        } else {
          path.lineTo(cos(outerAngle) * currentSize, sin(outerAngle) * currentSize);
        }
        path.lineTo(cos(innerAngle) * currentSize * 0.4, sin(innerAngle) * currentSize * 0.4);
      }
      path.close();
      canvas.drawPath(path, paint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CelebrationPainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
