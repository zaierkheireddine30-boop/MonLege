import 'package:flutter/material.dart';
import 'trimester_menu_screen.dart'; // Importation de l'Écran 4 (les 6 boutons)

class TrimestersScreen extends StatelessWidget {
  final String niveauId; // Reçoit l'ID du niveau (ex: "7eme")
  final Map<String, dynamic> matiereData; // Reçoit toutes les données de la matière filtrée du JSON

  const TrimestersScreen({
    super.key,
    required this.niveauId,
    required this.matiereData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0C), // On conserve le noir premium de votre thème
      appBar: AppBar(
        title: Text(
          "Trimestres : ${matiereData['nom']}",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Sélectionnez un trimestre pour accéder aux cours et examens",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.white54, fontFamily: 'sans-serif'),
            ),
            const SizedBox(height: 40),

            // Bouton 1er Trimestre (Entièrement opérationnel avec vos données)
            _buildTrimestreButton(
              context,
              titre: "1er Trimestre / الثلاثي الأول",
              trimestreId: "trimestre_1",
              color: const Color(0xFF8B5CF6), // Violet assorti à votre Onboarding
              estActif: true,
            ),
            const SizedBox(height: 16),

            // Bouton 2ème Trimestre (Désactivé visuellement pour le moment)
            _buildTrimestreButton(
              context,
              titre: "2ème Trimestre / ...",
              trimestreId: "trimestre_2",
              color: Colors.white12,
              estActif: false,
            ),
            const SizedBox(height: 16),

            // Bouton 3ème Trimestre (Désactivé visuellement pour le moment)
            _buildTrimestreButton(
              context,
              titre: "3ème Trimestre / ...",
              trimestreId: "trimestre_3",
              color: Colors.white12,
              estActif: false,
            ),
          ],
        ),
      ),
    );
  }

  // Widget utilitaire pour générer des boutons harmonieux
  Widget _buildTrimestreButton(
    BuildContext context, {
    required String titre,
    required String trimestreId,
    required Color color,
    required bool estActif,
  }) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: estActif ? const Color(0xFF1E1E22) : const Color(0xFF121214),
          foregroundColor: estActif ? Colors.white : Colors.white30,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: estActif ? color.withValues(alpha: 0.4) : Colors.transparent, 
              width: 1,
            ),
          ),
        ),
        onPressed: estActif ? () {
          // Au clic, on avance vers l'Écran 4 (Le menu des 6 catégories)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrimesterMenuScreen(
                niveauId: niveauId,
                matiereData: matiereData,
                trimestreId: trimestreId, // Transmet "trimestre_1"
              ),
            ),
          );
        } : null, // Désactive l'action si nous n'avons pas encore de données dans le JSON
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded, 
              size: 16, 
              color: estActif ? Colors.white54 : Colors.white10
            ),
            const Spacer(),
            Text(
              titre,
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: estActif ? Colors.white : Colors.white30, // ✅ Correction de 'white20' effectuée ici
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.calendar_today_rounded, 
              size: 20, 
              color: estActif ? color : Colors.white10
            ),
          ],
        ),
      ),
    );
  }
}
