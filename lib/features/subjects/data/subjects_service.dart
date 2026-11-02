import 'dart:convert';
import 'package:flutter/material.dart';

class SubjectsService {
  // Vos données officielles issues de votre fichier JSON
  final Map<String, dynamic> _staticJsonData = {
    "pays": "Tunisie",
    "cycle": "Enseignement de base",
    "trimestre": "1er Trimestre",
    "niveaux": [
      {
        "id": "7eme",
        "nom": "السابعة من التعليم الأساسي",
        "matieres": [
          {
            "id": "7_math",
            "nom": "الرياضيات",
            "est_math": true,
            "trimestres": {
              "trimestre_1": {
                "cours": {
                  "algebre": [
                    { "id": "7_m_t1_c_alg1", "titre": "الدرس 1: الحساب - القابلية القسمة على 2 و 5 و 3 و 9" },
                    { "id": "7_m_t1_c_alg2", "titre": "الدرس 2: الحساب - القابلية القسمة على 4 و 25" },
                    { "id": "7_m_t1_c_alg3", "titre": "الدرس 3: الكسور - الكتابة والمقارنة" }
                  ],
                  "geometrie": [
                    { "id": "7_m_t1_c_geo1", "titre": "الدرس 1: الوضعيات النسبية لمستقيمين" },
                    { "id": "7_m_t1_c_geo2", "titre": "الدرس 2: الزوايا - قيس وبناء" },
                    { "id": "7_m_t1_c_geo3", "titre": "الدرس 3: التناظر المحوري - تقديم" }
                  ]
                },
                "resumes": {
                  "algebre": [{ "id": "7_m_t1_r_alg1", "titre": "ملخص: قواعد قابلية القسمة" }],
                  "geometrie": [{ "id": "7_m_t1_r_geo1", "titre": "ملخص: العلاقات بين الزوايا والمستقيمات" }]
                },
                "qcm": [{ "id": "7_m_t1_q1", "parent_lecon_id": "7_m_t1_c_alg1", "titre": "تطبيق: قابلية القسمة" }],
                "devoir_controle": [{ "id": "7_m_t1_dc1", "titre": "فرض مراقبة عدد 1 في الرياضيات" }],
                "synthese": [{ "id": "7_m_t1_ds1", "titre": "فرض تأليفي عدد 1 في الرياضيات" }],
                "serie": [{ "id": "7_m_t1_s1", "titre": "سلسلة تمارين دعم: الأعداد والكسور" }]
              }
            }
          },
          {
            "id": "7_ar",
            "nom": "العربية",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [
                  { "id": "7_ar_t1_c1", "titre": "شرح نص: المحور 1 - الأسرة والطفولة" },
                  { "id": "7_ar_t1_c2", "titre": "قواعد اللغة: المبتدأ والخبر ونواسخهما" }
                ],
                "resumes": [{ "id": "7_ar_t1_r1", "titre": "ملخص: أحكام الجملة الاسمية" }],
                "qcm": [{ "id": "7_ar_t1_q1", "parent_lecon_id": "7_ar_t1_c2", "titre": "تطبيق: إعراب النواسخ" }],
                "devoir_controle": [{ "id": "7_ar_t1_dc1", "titre": "فرض مراقبة عدد 1 في العربية" }],
                "synthese": [{ "id": "7_ar_t1_ds1", "titre": "فرض تأليفي عدد 1 في العربية" }],
                "serie": [{ "id": "7_ar_t1_s1", "titre": "تمارين إنتاج كتابي وتعبير" }]
              }
            }
          },
          {
            "id": "7_svt",
            "nom": "علوم الحياة والأرض",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [
                  { "id": "7_svt_t1_c1", "titre": "الدرس 1: الوسط الطبيعي - تنوعه ومكوناته" },
                  { "id": "7_svt_t1_c2", "titre": "الدرس 2: الخلية - وحدة بناء الكائن الحي" }
                ],
                "resumes": [{ "id": "7_svt_t1_r1", "titre": "رسم بياني: مكونات الخلية" }],
                "qcm": [{ "id": "7_svt_t1_q1", "parent_lecon_id": "7_svt_t1_c1", "titre": "تطبيق: الكائنات الحية" }],
                "devoir_controle": [{ "id": "7_svt_t1_dc1", "titre": "فرض مراقبة عدد 1 في العلوم" }],
                "synthese": [{ "id": "7_svt_t1_ds1", "titre": "فرض تأليفي عدد 1 في العلوم" }],
                "serie": [{ "id": "7_svt_t1_s1", "titre": "سلسلة تمارين: الأوساط البيئية" }]
              }
            }
          },
          {
            "id": "7_phys",
            "nom": "العلوم الفيزيائية",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [
                  { "id": "7_phys_t1_c1", "titre": "الدرس 1: الحالات الفيزيائية للمادة" },
                  { "id": "7_phys_t1_c2", "titre": "الدرس 2: قيس الحجوم والكتل" }
                ],
                "resumes": [{ "id": "7_phys_t1_r1", "titre": "بطاقة مراجعة: الوحدات الفيزيائية" }],
                "qcm": [{ "id": "7_phys_t1_q1", "parent_lecon_id": "7_phys_t1_c1", "titre": "تطبيق: الانصهار والتبخر" }],
                "devoir_controle": [{ "id": "7_phys_t1_dc1", "titre": "فرض مراقبة عدد 1 في الفيزياء" }],
                "synthese": [{ "id": "7_phys_t1_ds1", "titre": "فرض تأليفي عدد 1 في الفيزياء" }],
                "serie": [{ "id": "7_phys_t1_s1", "titre": "تمارين قيس الحجم والكثافة" }]
              }
            }
          }
        ]
      }
    ]
  };

  // Chargement instantané en mémoire locale sécurisée
  Future<List<Map<String, dynamic>>> getMatieresParNiveau(String niveauId) async {
    try {
      if (!_staticJsonData.containsKey('niveaux')) return [];
      final niveaux = _staticJsonData['niveaux'] as List;
      
      final niveauTrouve = niveaux.firstWhere(
        (niveau) => niveau['id'] == niveauId,
        orElse: () => null,
      );

      if (niveauTrouve != null && niveauTrouve['matieres'] != null) {
        return List<Map<String, dynamic>>.from(niveauTrouve['matieres']);
      }
    } catch (e) {
      debugPrint("Erreur lors de l'extraction : $e");
    }
    return [];
  }
}
