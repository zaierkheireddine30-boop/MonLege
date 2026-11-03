import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart'; // Nécessaire pour ouvrir les fichiers Drive

class DocumentsListScreen extends StatelessWidget {
  final String categoryTitle; // 'cours', 'resumes', 'devoir_controle', etc.
  final String subjectName;    // Récupéré depuis l'Écran 3 (ex: 'الرياضيات')
  final String trimesterName;  // Récupéré depuis l'Écran 4 (ex: 'الثلاثي الأول')
  final String niveauId;       // Nécessaire pour filtrer le Sheets
  final String matiereId;      // Nécessaire pour filtrer le Sheets
  final String trimestreId;    // Nécessaire pour filtrer le Sheets

  const DocumentsListScreen({
    super.key,
    required this.categoryTitle,
    required this.subjectName,
    required this.trimesterName,
    required this.niveauId,
    required this.matiereId,
    required this.trimestreId,
  });

  // 📡 Charge et filtre à la demande les lignes du Google Sheets enregistrées en cache
  Future<List<Map<String, dynamic>>> _chargerDocumentsDynamiques() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString('cache_programme_monlege');
    
    if (cachedData != null) {
      final List<dynamic> lignesSheet = jsonDecode(cachedData);
      
      // Filtrage chirurgical selon le niveau, la matière, le trimestre et le type de bouton cliqué
      return lignesSheet.where((ligne) {
        final String lNiveau = ligne['NiveauId'] ?? ligne['niveauId'] ?? '';
        final String lMatiere = ligne['MatiereId'] ?? ligne['matiereId'] ?? '';
        final String lTrimestre = ligne['TrimestreId'] ?? ligne['trimestreId'] ?? '';
        final String lType = ligne['TypeContenu'] ?? ligne['typeContenu'] ?? '';

        return lNiveau == niveauId &&
               lMatiere == matiereId &&
               lTrimestre == trimestreId &&
               lType.toLowerCase().contains(_convertirCategorieEnType(categoryTitle));
      }).cast<Map<String, dynamic>>().toList();
    }
    return [];
  }

  // Permet de mapper le titre du bouton arabe avec la valeur de la colonne TypeContenu de votre Sheets
  String _convertirCategorieEnType(String titreArabe) {
    if (titreArabe.contains('ملخص') || titreArabe.contains('الملخصات')) return 'resume';
    if (titreArabe.contains('مراقبة') || titreArabe.contains('فروض')) return 'devoir';
    if (titreArabe.contains('تأليفي')) return 'synthese';
    return 'cours'; // Par défaut
  }

  // 🔓 Ouvre le vrai lien Google Drive converti en mode externe
  void _ouvrirFichierDrive(BuildContext context, String urlString) async {
    if (urlString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرابط غير متوفر', textAlign: TextAlign.right)),
      );
      return;
    }
    
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Impossible de lancer';
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تعذر فتح المستند. تأكد من اتصالك بالإنترنت أو صحة رابط الـ Drive.', textAlign: TextAlign.right),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _chargerDocumentsDynamiques(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.red));
                    }

                    if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          "لا توجد وثائق متوفرة حالياً في هذا القسم.",
                          style: TextStyle(color: Colors.white38, fontSize: 15, fontFamily: 'sans-serif'),
                        ),
                      );
                    }

                    final documents = snapshot.data!;

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        return _buildDocumentCard(context, doc);
                      },
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

  Widget _buildDocumentCard(BuildContext context, Map<String, dynamic> doc) {
    final String titre = doc['TitreCours'] ?? doc['titreCours'] ?? 'مستند بدون عنوان';
    final String lien = doc['LienFichier'] ?? doc['lienFichier'] ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05), width: 1.2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _ouvrirFichierDrive(context, lien), // Déclenche l'ouverture du vrai Drive
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text("📥 فتح", style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
              const Spacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      titre,
                      textAlign: Alignment.right == Alignment.right ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'تحديث مباشر عبر السحابة',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.greenAccent, fontSize: 11, fontFamily: 'sans-serif'),
                    ),
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
}
