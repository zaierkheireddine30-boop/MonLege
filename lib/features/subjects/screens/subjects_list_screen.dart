import 'package:flutter/material.dart';
import '../data/subjects_service.dart';
import '../widgets/subject_card.dart';
import 'package:monlege/features/content_view/trimesters_screen.dart';

class SubjectsListScreen extends StatefulWidget {
  final String niveauId;   
  final String niveauNom;  

  const SubjectsListScreen({
    Key? key,
    required this.niveauId,
    required this.niveauNom,
  }) : super(key: key);

  @override
  State<SubjectsListScreen> createState() => _SubjectsListScreenState();
}

class _SubjectsListScreenState extends State<SubjectsListScreen> {
  final SubjectsService _subjectsService = SubjectsService();
  late Future<List<Map<String, dynamic>>> _futureMatieres;

  @override
  void initState() {
    super.initState();
    // Appel de la méthode avec la casse exacte attendue par votre service
    _futureMatieres = _subjectsService.getMatieresParNiveau(widget.niveauId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0C), 
      appBar: AppBar(
        title: Text(
          widget.niveauNom, 
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureMatieres,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF8B5CF6)),
            );
          }

          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "Aucune matière trouvée.",
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ),
            );
          }

          final matieres = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            physics: const BouncingScrollPhysics(),
            itemCount: matieres.length,
            itemBuilder: (context, index) {
              final matiere = matieres[index];

              return SubjectCard(
                title: matiere['nom'] ?? 'Matière Inconnue',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrimestersScreen(
                        niveauId: widget.niveauId,
                        matiereData: matiere,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
