import 'package:flutter/material.dart';

class TrimesterMenuScreen extends StatelessWidget {
  final String niveauId;
  final Map<String, dynamic> matiereData;
  final String trimestreId;

  const TrimesterMenuScreen({
    super.key,
    required this.niveauId,
    required this.matiereData,
    required this.trimestreId,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Détecte si la matière est de type Mathématiques d'après votre clé JSON
    final bool estMath = matiereData['est_math'] ?? false;
    
    // 2. Extrait le bloc complet du trimestre sélectionné (ex: "trimestre_1")
    final Map<String, dynamic> donneesTrimestre = 
        matiereData['trimestres']?[trimestreId] ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0C),
      appBar: AppBar(
        title: Text(
          "${matiereData['nom']} - الثلاثي الأول",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            // 🟥 BOUTON 1 : COURS VIDÉO
            _buildMenuButton(
              context,
              title: "Cours Vidéo\nدروس فيديو",
              icon: Icons.play_circle_fill_rounded,
              color: Colors.red,
              onTap: () {
                if (estMath) {
                  _afficherDialogueMath(context, "Cours / دروس فيديو", donneesTrimestre['cours'] ?? {});
                } else {
                  _ouvrirListeContenus(context, "Cours / دروس فيديو", donneesTrimestre['cours'] ?? []);
                }
              },
            ),
            
            // 🟦 BOUTON 2 : RÉSUMÉS PDF
            _buildMenuButton(
              context,
              title: "Résumés PDF\nملخصات",
              icon: Icons.picture_as_pdf_rounded,
              color: Colors.blue,
              onTap: () {
                if (estMath) {
                  _afficherDialogueMath(context, "Résumés / ملخصات", donneesTrimestre['resumes'] ?? {});
                } else {
                  _ouvrirListeContenus(context, "Résumés / ملخصات", donneesTrimestre['resumes'] ?? []);
                }
              },
            ),
            
            // 🟩 BOUTON 3 : QCM EVALUATION
            _buildMenuButton(
              context,
              title: "QCM Évaluation\nتمارين كويز",
              icon: Icons.quiz_rounded,
              color: Colors.green,
              onTap: () {
                _ouvrirListeContenus(context, "QCM / تمارين كويز", donneesTrimestre['qcm'] ?? []);
              },
            ),
            
            // 🟨 BOUTON 4 : DEVOIRS CONTRÔLE
            _buildMenuButton(
              context,
              title: "Devoirs Contrôle\nفروض مراقبة",
              icon: Icons.assignment_rounded,
              color: Colors.orange,
              onTap: () {
                _ouvrirListeContenus(context, "Devoirs Contrôle / فروض مراقبة", donneesTrimestre['devoir_controle'] ?? []);
              },
            ),
            
            // 🟪 BOUTON 5 : DEVOIRS SYNTHÈSE
            _buildMenuButton(
              context,
              title: "Devoirs Synthèse\nفروض تأليفية",
              icon: Icons.analytics_rounded,
              color: Colors.purple,
              onTap: () {
                _ouvrirListeContenus(context, "Devoirs Synthèse / فروض تأليفية", donneesTrimestre['synthese'] ?? []);
              },
            ),
            
            // 🟩 BOUTON 6 : SÉRIES RÉVISION
            _buildMenuButton(
              context,
              title: "Séries Révision\nسلاسل تمارين",
              icon: Icons.format_list_bulleted_rounded,
              color: Colors.teal,
              onTap: () {
                _ouvrirListeContenus(context, "Séries / سلاسل تمارين", donneesTrimestre['serie'] ?? []);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, {required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13, fontFamily: 'sans-serif'),
            ),
          ],
        ),
      ),
    );
  }

  // 👑 FEUILLE DE DIALOGUE MATHÉMATIQUES (Algèbre / Géométrie)
  void _afficherDialogueMath(BuildContext context, String categorieNom, Map<String, dynamic> branchesData) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E22),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "اختر فرع الرياضيات - $categorieNom",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'sans-serif'),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: CircleAvatar(backgroundColor: Colors.blue.withValues(alpha: 0.1), child: const Icon(Icons.calculate, color: Colors.blue)),
                title: const Text("Algèbre / جبر", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context); // Ferme la feuille
                  _ouvrirListeContenus(context, "$categorieNom - Algèbre", branchesData['algebre'] ?? []);
                },
              ),
              const Divider(color: Colors.white10),
              ListTile(
                leading: CircleAvatar(backgroundColor: Colors.orange.withValues(alpha: 0.1), child: const Icon(Icons.change_history, color: Colors.orange)),
                title: const Text("Géométrie / هندسة", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context); // Ferme la feuille
                  _ouvrirListeContenus(context, "$categorieNom - Géométrie", branchesData['geometrie'] ?? []);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 📝 REDIRECTION INTERNE VERS LA LISTE DES CHAPITRES (Affiche vos titres en arabe)
  void _ouvrirListeContenus(BuildContext context, String title, dynamic listeData) {
    final List<dynamic> chapitres = listeData is List ? listeData : [];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFF0B0B0C),
          appBar: AppBar(
            title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: chapitres.isEmpty
              ? const Center(
                  child: Text("لم يتم إضافة دروس بعد لهذا القسم", style: TextStyle(color: Colors.white54, fontFamily: 'sans-serif')),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: chapitres.length,
                  itemBuilder: (context, index) {
                    final item = chapitres[index];
                    return Card(
                      color: const Color(0xFF1E1E22),
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(
                          item['titre'] ?? 'درس بدون عنوان',
                          textAlign: TextAlign.right, // Alignement parfait à droite pour l'arabe !
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'sans-serif'),
                        ),
                        trailing: const Icon(Icons.menu_book_rounded, color: Color(0xFF8B5CF6), size: 20),
                        onTap: () {
                          debugPrint("Ouverture du document ID: ${item['id']}");
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
