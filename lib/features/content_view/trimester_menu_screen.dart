import 'package:flutter/material.dart';
import 'package:monlege/core/widgets/premium_lock_tag.dart'; // Votre widget cadenas officiel

class TrimesterMenuScreen extends StatelessWidget {
  final String niveauId;
  final Map<String, dynamic> matiereData;

  const TrimesterMenuScreen({
    super.key,
    required this.niveauId,
    required this.matiereData,
  });

  // Statut de l'élève (false = non abonné, affiche les cadenas)
  final bool aPayeLApp = false; 

  @override
  Widget build(BuildContext context) {
    final String nomMatiere = matiereData['nom'] ?? 'المادة';

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0C),
      appBar: AppBar(
        title: Text(
          nomMatiere,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                "اختر الثلاثي للبدء في المراجعة 📚",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'sans-serif',
                ),
              ),
              const SizedBox(height: 24),
              
              // Génération des 3 boutons de trimestres payants
              _buildTrimesterButton(context, "الثلاثي الأول", "trimestre_1", Colors.purple),
              const SizedBox(height: 16),
              _buildTrimesterButton(context, "الثلاثي الثاني", "trimestre_2", Colors.blue),
              const SizedBox(height: 16),
              _buildTrimesterButton(context, "الثلاثي الثالث", "trimestre_3", Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrimesterButton(BuildContext context, String title, String trimestreId, Color color) {
    return SizedBox(
      height: 75,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E22),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _gererClicTrimestre(context, trimestreId),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                // CORRECTION 1 : Ajout du paramètre obligatoire requis par votre widget 'PremiumLockTag'
                if (!aPayeLApp) const PremiumLockTag(isLocked: true), 
                if (aPayeLApp) Icon(Icons.arrow_back_ios_new_rounded, color: color, size: 18),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'sans-serif',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Action du clic : Bloque directement l'élève avec le Paywall d'abonnement
  void _gererClicTrimestre(BuildContext context, String trimestreId) {
    _afficherFenetrePaiement(context);
  }

  // Paywall Tunisien Sombre
  void _afficherFenetrePaiement(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E22),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // CORRECTION 2 : Remplacement de l'icône invalide par un cadenas Material standard existant
              const Icon(Icons.lock_outline_rounded, color: Colors.amber, size: 45),
              const SizedBox(height: 16),
              const Text(
                "محتوى مغلق 🔒",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'sans-serif'),
              ),
              const SizedBox(height: 8),
              const Text(
                "هذا المحتوى متاح للمشتركين فقط. اشترك الآن للوصول إلى جميع الدروس والفروض لجميع الثلاثيات.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5, fontFamily: 'sans-serif'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("اشترك الآن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        );
      },
    );
  }
}
