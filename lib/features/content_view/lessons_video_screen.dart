import 'package:flutter/material.dart';

class VideoLessonItem {
  final String title;
  final String duration;
  final String teacherName;

  VideoLessonItem({
    required this.title,
    required this.duration,
    required this.teacherName,
  });
}

class LessonsVideoScreen extends StatelessWidget {
  final String subjectName;
  final String trimesterName;

  const LessonsVideoScreen({
    super.key,
    required this.subjectName,
    required this.trimesterName,
  });

  @override
  Widget build(BuildContext context) {
    // 📚 Chargement dynamique de tous les programmes officiels tunisiens
    final List<VideoLessonItem> dynamicProgram = _getOfficialTunisianProgram();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0C),
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
        title: Text(
          subjectName,
          style: const TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Entête
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'البرنامج الرسمي الكامل 🎥',
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'فيديوهات مصورة لكل دروس $trimesterName',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 28),

              // 📜 Affichage de tous les chapitres du programme
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: dynamicProgram.length,
                  itemBuilder: (context, index) {
                    final lesson = dynamicProgram[index];
                    return _buildVideoCard(context, lesson, index + 1);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(BuildContext context, VideoLessonItem lesson, int chapterNumber) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1.2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('جاري تشغيل فيديو: ${lesson.title}', textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'sans-serif')),
              backgroundColor: const Color(0xFF8B5CF6),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                lesson.duration,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12, fontFamily: 'sans-serif'),
              ),
              const Spacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'الدرس $chapterNumber: ${lesson.title}',
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.teacherName,
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Color(0xFF8B5CF6), fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'sans-serif'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(Icons.play_arrow_rounded, color: Color(0xFF8B5CF6), size: 26),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🇹🇳 Base de données du programme officiel tunisien
  List<VideoLessonItem> _getOfficialTunisianProgram() {
    if (subjectName.contains('الرياضيات')) {
      return [
        VideoLessonItem(title: 'العمليات في مجموعة الأعداد الصحيحة الطبيعية', duration: '18:40 د', teacherName: 'الأستاذ أنيس'),
        VideoLessonItem(title: 'الأعداد الكسرية والعمليات عليها', duration: '22:15 د', teacherName: 'الأستاذ أنيس'),
        VideoLessonItem(title: 'المعادلات من الدرجة الأولى بمجهول واحد', duration: '25:30 د', teacherName: 'الأستاذ أنيس'),
        VideoLessonItem(title: 'الزوايا والتناظر المحوري في الهندسة', duration: '19:45 د', teacherName: 'الأستاذة هالة'),
        VideoLessonItem(title: 'المثلثات والحساب المبرهن للأطوال', duration: '31:10 د', teacherName: 'الأستاذة هالة'),
      ];
    } else if (subjectName.contains('الفيزيائية')) {
      return [
        VideoLessonItem(title: 'الدارة الكهربائية البسيطة وعناصرها', duration: '14:20 د', teacherName: 'الأستاذ مراد'),
        VideoLessonItem(title: 'شدة التيار الكهربائي والتوتر (القياس)', duration: '18:55 د', teacherName: 'الأستاذ مراد'),
        VideoLessonItem(title: 'الكتلة الحجمية للمواد السائلة والصلبة', duration: '21:40 د', teacherName: 'الأستاذة ريم'),
        VideoLessonItem(title: 'الخلائط والتحولات الفيزيائية للمادة', duration: '16:15 د', teacherName: 'الأستاذة ريم'),
      ];
    } else if (subjectName.contains('علوم الحياة')) {
      return [
        VideoLessonItem(title: 'الوسط البيئي ومكوناته الحية وغير الحية', duration: '15:10 د', teacherName: 'الأستاذة سلوى'),
        VideoLessonItem(title: 'العلاقات الغذائية في الوسط البيئي (السلاسل)', duration: '17:45 د', teacherName: 'الأستاذة سلوى'),
        VideoLessonItem(title: 'التنفس عند الكائنات الحية في أوساط مختلفة', duration: '23:20 د', teacherName: 'الأستاذ مكرم'),
      ];
    } else {
      return [
        VideoLessonItem(title: 'الدرس الأول: مدخل تمهيدي عام للمحور الأول', duration: '12:00 د', teacherName: 'مدرس المادة'),
        VideoLessonItem(title: 'الدرس الثاني: التطبيقات والتحاليل الأساسية', duration: '15:30 د', teacherName: 'مدرس المادة'),
        VideoLessonItem(title: 'الدرس الثالث: مراجعة شاملة وإصلاح نموذجي', duration: '20:15 د', teacherName: 'مدرس المادة'),
      ];
    }
  }
}
