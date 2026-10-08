import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: Image.asset(
                "assets/images/bg_pattern.png",
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildHeader(),
                    Positioned(
                      top: 130,
                      left: 0,
                      right: 0,
                      child: _buildKehadiranCard(),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                _buildAbsenHariIni(),
                const SizedBox(height: 20),
                Expanded(child: _buildMenuGrid()),
                _buildQuote(),
                const SizedBox(height: 130),
              ],
            ),
          ),
          Positioned(
            left: -20,
            bottom: 10,
            width: 130,
            child: Image.asset(
              "assets/images/siswa_kiri.png",
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: -20,
            bottom: 10,
            width: 150,
            child: Image.asset(
              "assets/images/siswa_kanan.png",
              fit: BoxFit.contain,
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 240),
      decoration: const BoxDecoration(
        color: Color(0xFF123B5D),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            height: 66,
            child: Image.asset("assets/images/prov.png"),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "ABSENSI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
              ),
              Text(
                "SISWA",
                style: TextStyle(
                  color: Color(0xFFFAFF00),
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "SUMATRA UTARA",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          PressableButton(
            onPressed: () => debugPrint("Notifikasi ditekan"),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2A6FB5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE53935),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        "0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKehadiranCard() {
    const days = ["Sen", "Sel", "Rab", "Kam", "Jum"];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "--",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Hari",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Bulan/Tahun",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _legendDot(const Color(0xFF32D800), "Hadir"),
                  const SizedBox(height: 4),
                  _legendDot(const Color(0xFFFFEB3B), "Telat"),
                  const SizedBox(height: 4),
                  _legendDot(const Color(0xFFE53935), "Alpha"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            "Absen minggu ini",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(days.length, (i) {
              return Column(
                children: [
                  Text(
                    days[i],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _statusCircleEmpty(),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.black87, fontSize: 9),
        ),
      ],
    );
  }

  Widget _statusCircleEmpty() {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
      ),
    );
  }

  Widget _buildAbsenHariIni() {
    return PressableButton(
      onPressed: () => debugPrint("Absen hari ini ditekan"),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF3120E0),
              Color(0xFF0888E4),
              Color(0xFF0096FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Text(
              "Absen hari ini",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            const Text(
              "--/--/----",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.white70,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
        children: [
          _menuCard(Icons.history_rounded, "Riwayat Hadir",
              () => debugPrint("Riwayat Hadir ditekan")),
          _menuCard(Icons.menu_book_rounded, "Pelajaran",
              () => debugPrint("Pelajaran ditekan")),
          _menuCard(Icons.assignment_rounded, "Absen",
              () => debugPrint("Absen ditekan")),
          _menuCard(Icons.calendar_month_rounded, "Kalender",
              () => debugPrint("Kalender ditekan")),
        ],
      ),
    );
  }

  Widget _menuCard(IconData icon, String label, VoidCallback onTap) {
    return PressableButton(
      onPressed: onTap,
      scale: 0.93,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF3120E0),
              Color(0xFF0888E4),
              Color(0xFF0096FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0888E4).withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: -8,
                left: -8,
                child: SizedBox(
                  width: 119.05,
                  height: 60,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      "assets/images/bg_pattern.png",
                      fit: BoxFit.cover,
                      alignment: Alignment.topLeft,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -8,
                right: -8,
                child: SizedBox(
                  width: 119.05,
                  height: 60,
                  child: Opacity(
                    opacity: 0.4,
                    child: Image.asset(
                      "assets/images/bg_pattern.png",
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomRight,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.white, size: 55),
                    const SizedBox(height: 10),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
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

  Widget _buildQuote() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 8),
      child: Text(
        "Displin Hari Ini,\nUntuk Masa Depan yang Lebih Baik",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SizedBox(
        height: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xFF123B5D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(60, 35),
                    topRight: Radius.elliptical(60, 35),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              bottom: 20,
              child: PressableButton(
                onPressed: () => debugPrint("Home ditekan"),
                scale: 0.88,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A6FB5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.home_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 40,
              bottom: 20,
              child: PressableButton(
                onPressed: () => debugPrint("Profile ditekan"),
                scale: 0.88,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A6FB5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: PressableButton(
                onPressed: () => debugPrint("Fingerprint ditekan"),
                scale: 0.9,
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A6FB5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.fingerprint,
                    color: Colors.white,
                    size: 44,
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

class PressableButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double scale;
  final bool haptic;

  const PressableButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.scale = 0.92,
    this.haptic = true,
  });

  @override
  State<PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<PressableButton> {
  bool _isPressed = false;

  void _onTapDown(_) {
    setState(() => _isPressed = true);
    if (widget.haptic) {
      HapticFeedback.lightImpact();
    }
  }

  void _onTapUp(_) {
    setState(() => _isPressed = false);
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? widget.scale : 1.0,
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: _isPressed ? 0.75 : 1.0,
          duration: const Duration(milliseconds: 90),
          child: widget.child,
        ),
      ),
    );
  }
}