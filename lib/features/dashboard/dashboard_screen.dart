import 'package:flutter/material.dart';
import 'package:monlege/features/subjects/screens/subjects_list_screen.dart';
import 'package:monlege/features/content_view/focus_timer_screen.dart';
import 'package:monlege/features/dashboard/pilot_space_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'MonLege 🎓',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_rounded, color: Colors.white70, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 📊 1. SECTION SUIVI DE L'ÉLÈVE
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'متابعة التقدّم 📈',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildStatCard(context, 'الدروس المشاهدة', '12 / 45', Icons.play_circle_fill_rounded, const Color(0xFF8B5CF6)),
                  const SizedBox(width: 12),
                  _buildStatCard(context, 'معدل الكويز', '16 / 20', Icons.bolt_rounded, const Color(0xFF06B6D4)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildStatCard(context, 'الفروض المنجزة', '5 فروض', Icons.assignment_turned_in_rounded, const Color(0xFF10B981)),
                  const SizedBox(width: 12),
                  _buildStatCard(context, 'مؤقت التركيز', 'اضغط للبدء ⏱️', Icons.timer_rounded, const Color(0xFFF59E0B), isTimer: true),
                ],
              ),
              const SizedBox(height: 28),

              // 👑 2. SECTION PHARE : ESPACE PILOTE (فضاء النموذجي)
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'المسار المتميز 👑',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFFF59E0B).withValues(alpha: 0.15), const Color(0xFFD97706).withValues(alpha: 0.05)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.3), width: 1.5),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PilotSpaceScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.amber, size: 18),
                        const Spacer(),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'فضاء أقسام النموذجي',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'تمارين معمقة، أولمبياد وإعداد للمناظرات الوطنية',
                              style: TextStyle(color: Colors.amber, fontSize: 11, fontFamily: 'sans-serif'),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 28),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 🏫 3. SECTION SÉLECTION DE LA CLASSE CLASSIQUE
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'التعليم الأساسي العام 📚',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 16),

              _buildGradeButton(context, 'السابعة من التعليم الأساسي', const Color(0xFF8B5CF6), 'السنة السابعة'),
              const SizedBox(height: 12),
              _buildGradeButton(context, 'الثامنة من التعليم الأساسي', const Color(0xFF3B82F6), 'السنة الثامنة'),
              const SizedBox(height: 12),
              _buildGradeButton(context, 'التاسعة من التعليم الأساسي 🏆', const Color(0xFFEF4444), 'السنة التاسعة'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color, {bool isTimer = false}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E22),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isTimer ? () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FocusTimerScreen()),
            );
          } : null,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: color, size: 20),
                    Text(title, style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12, fontFamily: 'sans-serif')),
                  ],
                ),
                const SizedBox(height: 8),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'sans-serif')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradeButton(BuildContext context, String title, Color color, String gradeParam) {
    String niveauId = "7eme";
    if (gradeParam.contains('الثامنة')) niveauId = "8eme";
    if (gradeParam.contains('التاسعة')) niveauId = "9eme";

    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubjectsListScreen(
                niveauId: niveauId,
                niveauNom: title,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E1E22),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: color.withValues(alpha: 0.3), width: 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white.withValues(alpha: 0.5), size: 16),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'sans-serif',
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
