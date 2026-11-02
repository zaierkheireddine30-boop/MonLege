import 'dart:convert';
import 'package:flutter/material.dart';

class SubjectsService {
  // Base de données complète du programme officiel tunisien
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
            "nom": "الالرياضيات",
            "est_math": true,
            "trimestres": {
              "trimestre_1": {
                "cours": {
                  "algebre": [
                    { "id": "7_m_t1_c_alg1", "titre": "الدرس 1: الحساب - القابلية القسمة على 2 و 5 & 3 و 9" },
                    { "id": "7_m_t1_c_alg2", "titre": "الدرس 2: الحساب - القابلية القسمة على 4 و 25" }
                  ],
                  "geometrie": [
                    { "id": "7_m_t1_c_geo1", "titre": "الدرس 1: الوضعيات النسبية لمستقيمين" },
                    { "id": "7_m_t1_c_geo2", "titre": "الدرس 2: الزوايا - قيس وبناء" }
                  ]
                },
                "resumes": {
                  "algebre": [{ "id": "7_m_t1_r_alg1", "titre": "ملخص: قواعد قابلية القسمة" }],
                  "geometrie": [{ "id": "7_m_t1_r_geo1", "titre": "ملخص: العلاقات بين الزوايا والمستقيمات" }]
                },
                "qcm": [{ "id": "7_m_t1_q1", "titre": "تطبيق: قابلية القسمة" }],
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
                "cours": [{ "id": "7_ar_t1_c1", "titre": "شرح نص: المحور 1 - الأسرة والطفولة" }],
                "resumes": [{ "id": "7_ar_t1_r1", "titre": "ملخص: أحكام الجملة الاسمية ونواسخها" }],
                "qcm": [{ "id": "7_ar_t1_q1", "titre": "تطبيق: إعراب المبتدأ والخبر" }],
                "devoir_controle": [{ "id": "7_ar_t1_dc1", "titre": "فرض مراقبة عدد 1 في العربية" }],
                "synthese": [{ "id": "7_ar_t1_ds1", "titre": "فرض تأليفي عدد 1 في العربية" }],
                "serie": [{ "id": "7_ar_t1_s1", "titre": "تمارين إنتاج كتابي وتعبير" }]
              }
            }
          },
          {
            "id": "7_fr",
            "nom": "Français",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [{ "id": "7_fr_t1_c1", "titre": "Module 1: Famille et Solidarité" }],
                "resumes": [{ "id": "7_fr_t1_r1", "titre": "Résumé: Présent de l'indicatif & types de phrases" }],
                "qcm": [{ "id": "7_fr_t1_q1", "titre": "Quiz: Vocabulaire du Module 1" }],
                "devoir_controle": [{ "id": "7_fr_t1_dc1", "titre": "Devoir de contrôle n°1 - Français" }],
                "synthese": [{ "id": "7_fr_t1_ds1", "titre": "Devoir de synthèse n°1 - Français" }],
                "serie": [{ "id": "7_fr_t1_s1", "titre": "Série: Compréhension de texte" }]
              }
            }
          },
          {
            "id": "7_en",
            "nom": "English",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [{ "id": "7_en_t1_c1", "titre": "Lesson 1: Hello! Introducing myself & family" }],
                "resumes": [{ "id": "7_en_t1_r1", "titre": "Summary: Verb to be & Possessive adjectives" }],
                "qcm": [{ "id": "7_en_t1_q1", "titre": "Quiz: Pronouns and Numbers" }],
                "devoir_controle": [{ "id": "7_en_t1_dc1", "titre": "English Test n°1" }],
                "synthese": [{ "id": "7_en_t1_ds1", "titre": "English Exam n°1" }],
                "serie": [{ "id": "7_en_t1_s1", "titre": "Worksheet: Vocabulary practice" }]
              }
            }
          },
          {
            "id": "7_svt",
            "nom": "علوم الحياة والأرض",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [{ "id": "7_svt_t1_c1", "titre": "الدرس 1: الوسط الطبيعي - تنوعه ومكوناته" }],
                "resumes": [{ "id": "7_svt_t1_r1", "titre": "رسم بياني: مكونات الخلية النباتية والحيوانية" }],
                "qcm": [{ "id": "7_svt_t1_q1", "titre": "تطبيق: تصنيف الكائنات الحية" }],
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
                "cours": [{ "id": "7_phys_t1_c1", "titre": "الدرس 1: الحالات الفيزيائية الثلاث للمادة" }],
                "resumes": [{ "id": "7_phys_t1_r1", "titre": "بطاقة مراجعة: قيس الحجوم والكتل والوحدات" }],
                "qcm": [{ "id": "7_phys_t1_q1", "titre": "تطبيق: نموذج التصلب والانصهار" }],
                "devoir_controle": [{ "id": "7_phys_t1_dc1", "titre": "فرض مراقبة عدد 1 في الفيزياء" }],
                "synthese": [{ "id": "7_phys_t1_ds1", "titre": "فرض تأليفي عدد 1 في الفيزياء" }],
                "serie": [{ "id": "7_phys_t1_s1", "titre": "تمارين قيس حجم السوائل والأجسام الصلبة" }]
              }
            }
          },
          {
            "id": "7_hg",
            "nom": "التاريخ والجغرافيا",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [{ "id": "7_hg_t1_c1", "titre": "تاريخ: بلادنا تونس في العهود القديمة" }],
                "resumes": [{ "id": "7_hg_t1_r1", "titre": "جغرافيا: الأرض في الكون وعناصر الخريطة" }],
                "qcm": [{ "id": "7_hg_t1_q1", "titre": "تطبيق: تحديد الإحداثيات والجهات" }],
                "devoir_controle": [{ "id": "7_hg_t1_dc1", "titre": "فرض مراقبة عدد 1 في التاريخ والجغرافيا" }],
                "synthese": [{ "id": "7_hg_t1_ds1", "titre": "فرض تأليفي عدد 1 في التاريخ والجغرافيا" }],
                "serie": [{ "id": "7_hg_t1_s1", "titre": "دراسة وثائق وخرائط جغرافية" }]
              }
            }
          },
          {
            "id": "7_isl",
            "nom": "التربية الإسلامية",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [{ "id": "7_isl_t1_c1", "titre": "القرآن الكريم: شرح سورة الملك وحفظها" }],
                "resumes": [{ "id": "7_isl_t1_r1", "titre": "ملخص: أركان الإيمان وقيم العمل الصالح" }],
                "qcm": [{ "id": "7_isl_t1_q1", "titre": "اختبار: أحكام الترتيل (النون الساكنة والتنوين)" }],
                "devoir_controle": [{ "id": "7_isl_t1_dc1", "titre": "فرض مراقبة عدد 1 في التربية الإسلامية" }],
                "synthese": [{ "id": "7_isl_t1_ds1", "titre": "فرض تأليفي عدد 1 في التربية الإسلامية" }],
                "serie": [{ "id": "7_isl_t1_s1", "titre": "تطبيقات ودعم: السيرة النبوية العطرة" }]
              }
            }
          },
          {
            "id": "7_tech",
            "nom": "التكنولوجيا",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [{ "id": "7_tech_t1_c1", "titre": "الدرس 1: المنتج التقني وحاجيات الإنسان المعاصر" }],
                "resumes": [{ "id": "7_tech_t1_r1", "titre": "ملخص: قواعد أدوات الرسم التقني والهندسي" }],
                "qcm": [{ "id": "7_tech_t1_q1", "titre": "تطبيق: تمييز المواد الصناعية الأساسية" }],
                "devoir_controle": [{ "id": "7_tech_t1_dc1", "titre": "فرض مراقبة عدد 1 تكنولوجيا" }],
                "synthese": [{ "id": "7_tech_t1_ds1", "titre": "فرض تأليفي عدد 1 تكنولوجيا" }],
                "serie": [{ "id": "7_tech_t1_s1", "titre": "تمارين تطبيقية: التحليل البنيوي للمنتج" }]
              }
            }
          },
          {
            "id": "7_info",
            "nom": "الإعلامية",
            "est_math": false,
            "trimestres": {
              "trimestre_1": {
                "cours": [{ "id": "7_info_t1_c1", "titre": "الدرس 1: مكونات الحاسوب المادية والبرمجية" }],
                "resumes": [{ "id": "7_info_t1_r1", "titre": "ملخص: استخدام نظام التشغيل وترتيب الملفات" }],
                "qcm": [{ "id": "7_info_t1_q1", "titre": "تطبيق: وحدات تخزين الذاكرة والمعالجة" }],
                "devoir_controle": [{ "id": "7_info_t1_dc1", "titre": "فرض مراقبة عدد 1 إعلامية" }],
                "synthese": [{ "id": "7_info_t1_ds1", "titre": "فرض تأليفي عدد 1 إعلامية" }],
                "serie": [{ "id": "7_info_t1_s1", "titre": "تمارين برمجية تطبيقية: معالجة النصوص Word" }]
              }
            }
          }
        ]
      }
    ]
  };

  // Algorithme d'extraction robuste basé sur une recherche par boucle classique
  Future<List<Map<String, dynamic>>> getMatieresParNiveau(String niveauId) async {
    try {
      if (!_staticJsonData.containsKey('niveaux')) return [];
      final niveaux = _staticJsonData['niveaux'] as List;
      
      Map<String, dynamic>? niveauTrouve;
      for (var niveau in niveaux) {
        if (niveau['id'] == niveauId) {
          niveauTrouve = niveau as Map<String, dynamic>;
          break;
        }
      }

      if (niveauTrouve != null && niveauTrouve['matieres'] != null) {
        return List<Map<String, dynamic>>.from(niveauTrouve['matieres']);
      }
    } catch (e) {
      debugPrint("Erreur lors de l'extraction : $e");
    }
    return [];
  }
}
