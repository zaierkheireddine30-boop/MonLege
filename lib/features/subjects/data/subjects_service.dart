import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SubjectsService {
  // 🔗 CORRECTION DE L'URL : Intégration de la passerelle opensheet avec l'ID réel de votre tableau Monlege_Data
  final String googleSheetUrl = "https://elk.sh";

  // Base de données locale de secours (Si l'élève lance l'appli pour la toute première fois sans internet)
  final Map<String, dynamic> _fallbackJsonData = {
    "niveaux": [
      {
        "id": "7eme",
        "nom": "السابعة من التعليم الأساسي",
        "matieres": [
          {"id": "7_math", "nom": "الرياضيات", "est_math": true},
          {"id": "7_ar", "nom": "العربية", "est_math": false},
          {"id": "7_fr", "nom": "Français", "est_math": false},
          {"id": "7_en", "nom": "English", "est_math": false},
          {"id": "7_svt", "nom": "علوم الحياة والأرض", "est_math": false},
          {"id": "7_phys", "nom": "العلوم الفيزيائية", "est_math": false},
          {"id": "7_hg", "nom": "التاريخ والجغرافيا", "est_math": false},
          {"id": "7_isl", "nom": "التربية الإسلامية", "est_math": false},
          {"id": "7_tech", "nom": "التكنولوجيا", "est_math": false},
          {"id": "7_info", "nom": "الإعلامية", "est_math": false}
        ]
      },
      {
        "id": "8eme",
        "nom": "الثامنة من التعليم الأساسي",
        "matieres": [
          {"id": "8_math", "nom": "الرياضيات", "est_math": true},
          {"id": "8_ar", "nom": "العربية", "est_math": false},
          {"id": "8_fr", "nom": "Français", "est_math": false},
          {"id": "8_en", "nom": "English", "est_math": false},
          {"id": "8_svt", "nom": "علوم الحياة والأرض", "est_math": false},
          {"id": "8_phys", "nom": "العلوم الفيزيائية", "est_math": false},
          {"id": "8_hg", "nom": "التاريخ والجغرافيا", "est_math": false},
          {"id": "8_isl", "nom": "التربية الإسلامية", "est_math": false},
          {"id": "8_tech", "nom": "التكنولوجيا", "est_math": false},
          {"id": "8_info", "nom": "الإعلامية", "est_math": false}
        ]
      },
      {
        "id": "9eme",
        "nom": "التاسعة من التعليم الأساسي 🏆",
        "matieres": [
          {"id": "9_math", "nom": "الرياضيات", "est_math": true},
          {"id": "9_ar", "nom": "العربية", "est_math": false},
          {"id": "9_fr", "nom": "Français", "est_math": false},
          {"id": "9_en", "nom": "English", "est_math": false},
          {"id": "9_svt", "nom": "علوم الحياة والأرض", "est_math": false},
          {"id": "9_phys", "nom": "العلوم الفيزيائية", "est_math": false},
          {"id": "9_hg", "nom": "التاريخ والجغرافيا", "est_math": false},
          {"id": "9_isl", "nom": "التربية الإسلامية", "est_math": false},
          {"id": "9_tech", "nom": "التكنولوجيا", "est_math": false},
          {"id": "9_info", "nom": "الإعلامية", "est_math": false}
        ]
      }
    ]
  };

  Future<List<Map<String, dynamic>>> getMatieresParNiveau(String niveauId) async {
    final prefs = await SharedPreferences.getInstance();

    // 📡 Étape A : Synchronisation Internet (Télécharge le Google Sheet)
    try {
      final response = await http.get(Uri.parse(googleSheetUrl)).timeout(const Duration(seconds: 4));
      if (response.statusCode == 200) {
        // Écrase et sauvegarde la nouvelle version sur la mémoire du téléphone
        await prefs.setString('cache_programme_monlege', response.body);
      }
    } catch (e) {
      debugPrint("Mode hors-connexion activé (Lecture depuis le cache) : $e");
    }

    // 💾 Étape B : Lecture du Cache local (Marche 100% hors-ligne)
    final String? cachedData = prefs.getString('cache_programme_monlege');
    if (cachedData != null) {
      try {
        final List<dynamic> lignesSheet = jsonDecode(cachedData);
        
        // Convertit les lignes plates du tableau Google Sheets en liste de matières
        List<Map<String, dynamic>> matieres = [];
        Set<String> matieresAjoutees = {};

        for (var ligne in lignesSheet) {
          if (ligne['niveauId'] == niveauId) {
            String mId = ligne['matiereId'] ?? '';
            if (!matieresAjoutees.contains(mId)) {
              matieresAjoutees.add(mId);
              matieres.add({
                "id": mId,
                "nom": ligne['matiereNom'] ?? '',
                "est_math": (ligne['est_math'] == 'true' || mId.contains('math')),
              });
            }
          }
        }
        if (matieres.isNotEmpty) return matieres;
      } catch (_) {}
    }

    // 🚨 Étape C : Secours Absolu (Si aucun cache et aucune connexion)
    final niveauxFallback = _fallbackJsonData['niveaux'] as List;
    for (var niveau in niveauxFallback) {
      if (niveau['id'] == niveauId) {
        return List<Map<String, dynamic>>.from(niveau['matieres']);
      }
    }
    return [];
  }
}
