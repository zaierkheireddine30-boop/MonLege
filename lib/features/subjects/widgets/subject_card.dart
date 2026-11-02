import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  Color _getMatiereColor(String titre) {
    String t = titre.toLowerCase();
    if (t.contains('math')) return Colors.blue;
    if (t.contains('physique') || t.contains('العلوم الفيزيائية')) return Colors.orange;
    if (t.contains('vie') || t.contains('svt') || t.contains('الحياة')) return Colors.green;
    if (t.contains('arabe') || t.contains('العربية')) return Colors.red;
    if (t.contains('français') || t.contains('francais') || t.contains('الفرنسية')) return Colors.indigo;
    if (t.contains('english') || t.contains('anglais') || t.contains('الإنجليزية')) return Colors.purple;
    if (t.contains('techno')) return Colors.teal;
    if (t.contains('info')) return Colors.cyan;
    if (t.contains('histoire') || t.contains('géo') || t.contains('التاريخ')) return Colors.amber;
    return Colors.grey;
  }

  IconData _getMatiereIcon(String titre) {
    String t = titre.toLowerCase();
    if (t.contains('math')) return Icons.calculate;
    if (t.contains('physique') || t.contains('العلوم الفيزيائية')) return Icons.science;
    if (t.contains('vie') || t.contains('svt') || t.contains('الحياة')) return Icons.eco;
    if (t.contains('arabe') || t.contains('العربية')) return Icons.translate;
    if (t.contains('français') || t.contains('francais') || t.contains('الفرنسية')) return Icons.menu_book;
    if (t.contains('english') || t.contains('anglais') || t.contains('الإنجليزية')) return Icons.language;
    if (t.contains('techno')) return Icons.build;
    if (t.contains('info')) return Icons.computer;
    if (t.contains('histoire') || t.contains('géo') || t.contains('التاريخ')) return Icons.public;
    return Icons.book;
  }

  @override
  Widget build(BuildContext context) {
    final Color color = _getMatiereColor(title);
    final IconData icon = _getMatiereIcon(title);
    
    // Détecte automatiquement si le titre est en arabe pour changer le sens de lecture
    final bool estArabe = title.contains(RegExp(r'[\u0600-\u06FF]'));

    return Directionality(
      textDirection: estArabe ? TextDirection.rtl : TextDirection.ltr, // S'aligne à droite pour l'arabe !
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0), // Marges propres sur les côtés
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent, // Laisse passer le fond blanc du Container
            child: InkWell(
              onTap: onTap, // Le détecteur de clic englobe parfaitement le contenu
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(18.0), // Padding déplacé à l'intérieur pour maximiser la zone cliquable
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: color.withOpacity(0.1),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    // La petite flèche pointe dans le bon sens selon la langue
                    Icon(
                      estArabe ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios, 
                      size: 16, 
                      color: Colors.grey.shade400
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
