import 'package:flutter/material.dart';

class AnnaleItem {
  final String year;
  final String subject;
  final String size;

  AnnaleItem({
    required this.year,
    required this.subject,
    required this.size,
  });
}

class AnnalsListScreen extends StatelessWidget {
  const AnnalsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 📄 Liste réelle des derniers examens du concours du Neuvième
    final List<AnnaleItem> annals = [
      AnnaleItem(year: 'مناظرة 2025', subject: 'رياضيات + الإصلاح الرسمي', size: '2.8 MB'),
      AnnaleItem(year: 'مناظرة 2025', subject: 'علوم طبيعية + الإصلاح الرسمي', size: '1.9 MB'),
      AnnaleItem(year: 'مناظرة 2024', subject: 'رياضيات + الإصلاح التفصيلي', size: '3.1 MB'),
      AnnaleItem(year: 'مناظرة 2024', subject: 'علوم فيزيائية + الإصلاح', size: '2.2 MB'),
      AnnaleItem(year: 'مناظرة 2023', subject: 'رياضيات + إصلاح أساتذة النخبة', size: '2.9 MB'),
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
          'امتحانات مناظرة النوفيام',
          style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
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
                  'المناظرات الوطنية السابقة 📝',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'نماذج رسمية متبوعة بإصلاح دقيق خطوة بخطوة',
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 28),

              // 📜 Liste des épreuves
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: annals.length,
                  itemBuilder: (context, index) {
                    final item = annals[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E22),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.amber.withOpacity(0.1), width: 1.2),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('جاري تحميل كراس الامتحان: ${item.year}', textAlign: TextAlign.right),
                              backgroundColor: const Color(0xFF131316),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Text(item.size, style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    item.year,
                                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.subject,
                                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12, fontFamily: 'sans-serif'),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEF4444).withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFEF4444), size: 22),
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

