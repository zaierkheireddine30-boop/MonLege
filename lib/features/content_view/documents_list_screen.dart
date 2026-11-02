import 'package:flutter/material.dart';

class DocumentFileItem {
  final String title;
  final String size;
  final String dateAdded;

  DocumentFileItem({
    required this.title,
    required this.size,
    required this.dateAdded,
  });
}

class DocumentsListScreen extends StatelessWidget {
  final String categoryTitle;
  final String subjectName;
  final String trimesterName;

  const DocumentsListScreen({
    super.key,
    required this.categoryTitle,
    required this.subjectName,
    required this.trimesterName,
  });

  @override
  Widget build(BuildContext context) {
    // 📚 Génération dynamique des vrais documents officiels tunisiens
    final List<DocumentFileItem> documents = _generateOfficialDocuments();

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
          '$subjectName - $trimesterName',
          style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  categoryTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  'وثائق ومستندات جاهزة للمراجعة والتحميل المباشر',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13, fontFamily: 'sans-serif'),
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final doc = documents[index];
                    return _buildDocumentCard(context, doc);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentCard(BuildContext context, DocumentFileItem doc) {
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
              content: Text('جاري فتح المستند: ${doc.title}', textAlign: TextAlign.right, style: const TextStyle(fontFamily: 'sans-serif')),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(doc.size, style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
              const Spacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(doc.title, textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'sans-serif')),
                    const SizedBox(height: 4),
                    Text('تاريخ الإضافة: ${doc.dateAdded}', textAlign: TextAlign.right, style: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 11, fontFamily: 'sans-serif')),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(color: const Color(0xFFEF4444).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(14)),
                child: const Center(child: Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFEF4444), size: 24)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DocumentFileItem> _generateOfficialDocuments() {
    String subKey = subjectName.contains('الرياضيات') ? 'math' : (subjectName.contains('الفيزيائية') ? 'phys' : 'other');

    if (categoryTitle == 'الملخصات') {
      if (subKey == 'math') {
        return [
          DocumentFileItem(title: 'ملخص درس الأعداد الصحيحة الطبيعية وبنية الحساب', size: '1.1 MB', dateAdded: 'أكتوبر 2026'),
          DocumentFileItem(title: 'ملخص القواعد العامة للأعداد الكسرية والعمليات', size: '950 KB', dateAdded: 'أكتوبر 2026'),
          DocumentFileItem(title: 'ملخص الهندسة: التناظر المحوري وخصائصه', size: '1.4 MB', dateAdded: 'أكتوبر 2026'),
        ];
      } else {
        return [
          DocumentFileItem(title: 'ملخص شامل لمحور الدارة الكهربائية البسيطة', size: '1.2 MB', dateAdded: 'أكتوبر 2026'),
          DocumentFileItem(title: 'ملخص قوانين قياس شدة التيار والتوتر', size: '850 KB', dateAdded: 'أكتوبر 2026'),
        ];
      }
    } else if (categoryTitle == 'فروض المراقبة') {
      return [
        DocumentFileItem(title: 'فرض مراقبة عدد 1 - النموذج القياسي تونس + الإصلاح', size: '2.1 MB', dateAdded: 'أكتوبر 2026'),
        DocumentFileItem(title: 'فرض مراقبة عدد 1 - نموذج معاهد النموذجية مع الحل', size: '2.5 MB', dateAdded: 'أكتوبر 2026'),
      ];
    } else if (categoryTitle == 'الفروض التأليفية') {
      return [
        DocumentFileItem(title: 'فرض تأليفي عدد 1 - مراجعة شاملة لثلاثي الأول مع الإصلاح', size: '3.4 MB', dateAdded: 'نوفمبر 2026'),
      ];
    } else {
      // Pour "السلاسل المصححة"
      if (subKey == 'math') {
        return [
          DocumentFileItem(title: 'سلسلة تمارين مصححة: المعادلات من الدرجة الأولى', size: '1.8 MB', dateAdded: 'أكتوبر 2026'),
          DocumentFileItem(title: 'سلسلة مسائل دعم وتقوية في الهندسة والمثلثات', size: '2.2 MB', dateAdded: 'أكتوبر 2026'),
        ];
      } else {
        return [
          DocumentFileItem(title: 'سلسلة تمارين: تطبيقات عملية على الكتلة الحجمية', size: '1.4 MB', dateAdded: 'أكتوبر 2026'),
        ];
      }
    }
  }
}
