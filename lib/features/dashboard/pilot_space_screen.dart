import 'package:flutter/material.dart';
import 'annals_list_screen.dart';

class PilotCategoryItem {
  final String title;
  final IconData icon;
  final Color color;
  final String description;

  PilotCategoryItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
  });
}

class PilotSpaceScreen extends StatelessWidget {
  const PilotSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 👑 Les 3 piliers de l'excellence pour le Pilote Tunisien
    final List<PilotCategoryItem> pilotCategories = [
      PilotCategoryItem(
        title: 'مناظرات النوفيام (9ème)',
        icon: Icons.workspace_premium_rounded,
        color: const Color(0xFFF59E0B),
        description: 'إصلاح دقيق وشامل للمناظرات الوطنية السابقة',
      ),
      PilotCategoryItem(
        title: 'أولمبياد الرياضيات والعلوم',
        icon: Icons.emoji_events_rounded,
        color: const Color(0xFF10B981),
        description: 'تحديات ومسائل ذكاء لتنمية التفكير المنطقي',
      ),
      PilotCategoryItem(
        title: 'فخاخ الامتحانات (فكّ العقدة)',
        icon: Icons.psychology_rounded,
        color: const Color(0xFF3B82F6),
        description: 'تجنب الأخطاء الشائعة التي تضيع النقاط',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        automaticallyImplyLeading: false,
        title: const Text(
          'فضاء التميّز والنموذجي',
          style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'مرحباً بك في فضاء النخبة 👑',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'محتوى مخصص ومتقدم للراغبين في النجاح بامتياز عالي',
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 32),

              // Liste verticale des sections Pilotes
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: pilotCategories.length,
                  itemBuilder: (context, index) {
                    final cat = pilotCategories[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E22),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: cat.color.withOpacity(0.2), width: 1.2),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          if (cat.title == 'مناظرات النوفيام (9ème)') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AnnalsListScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('فتح: ${cat.title}', textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'sans-serif')),
                                backgroundColor: const Color(0xFF1E1E22),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back_ios_new_rounded, color: cat.color, size: 16),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    cat.title,
                                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    cat.description,
                                    style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12, fontFamily: 'sans-serif'),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: cat.color.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(cat.icon, color: cat.color, size: 22),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
