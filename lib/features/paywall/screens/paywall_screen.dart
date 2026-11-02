import 'package:flutter/material.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090B),
      body: Stack(
        children: [
          // Halo décoratif supérieur
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Bouton fermer
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white60),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Spacer(),
                  
                  // Couronne Premium
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 44),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  const Text(
                    'MonLege Premium 🏆',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'إفتح جميع الدروس، الفروض، الملخصات والاختبارات التفاعلية المصححة وتفوق في دراستك',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'sans-serif', height: 1.5),
                  ),
                  const SizedBox(height: 32),

                  // Avantages
                  _buildFeatureRow('الوصول الكامل لـ 10 مواد دراسية سابعة، ثامنة وتاسعة'),
                  _buildFeatureRow('فروض مراقبة وتأليفية نموذجية مع الإصلاح الدقيق'),
                  _buildFeatureRow('ملخصات ذكية شاملة لجميع المحاور لربح الوقت'),
                  _buildFeatureRow('اختبارات كويز تفاعلية غير محدودة مع احتساب النتيجة'),
                  
                  const Spacer(),

                  // Boîte de prix
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E22),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.amber.withValues(alpha: 0.4), width: 1.5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ثلاثي كامل', style: TextStyle(color: Colors.grey, fontSize: 13, fontFamily: 'sans-serif')),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('10 د.ت / فقط', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'sans-serif')),
                            Text('اشتراك واحد لكل المواد', style: TextStyle(color: Colors.amber, fontSize: 11, fontFamily: 'sans-serif')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Bouton d'action
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('جاري الاتصال ببوابة الدفع التونسية... 💳', textAlign: TextAlign.right, style: TextStyle(fontFamily: 'sans-serif'))),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        'اشترك الآن وفّعّل حسابك',
                        style: TextStyle(color: Color(0xFF09090B), fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'sans-serif'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'sans-serif'), textAlign: TextAlign.right)),
          const SizedBox(width: 12),
          const Icon(Icons.check_circle_rounded, color: Colors.amber, size: 20),
        ],
      ),
    );
  }
}
