import 'package:flutter/material.dart';

void main() {
  runApp(const WorldFitnessApp());
}

// Paleta de cores baseada na logo da World Fitness
class AppColors {
  static const Color primaryRed = Color(0xFFC81D25);
  static const Color deepNavy = Color(0xFF142864);
  static const Color darkBackground = Color(0xFF0B0F19);
  static const Color cardSurface = Color(0xFF151C2C);
  static const Color metallicSilver = Color(0xFFA0AAB8);
  static const Color pureWhite = Color(0xFFFFFFFF);
}

class WorldFitnessApp extends StatelessWidget {
  const WorldFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        primaryColor: AppColors.primaryRed,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryRed,
          secondary: AppColors.deepNavy,
          surface: AppColors.cardSurface,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _modalidadesKey = GlobalKey();
  final GlobalKey _planosKey = GlobalKey();
  final GlobalKey _contatoKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground.withValues(alpha: 0.95),
        elevation: 4,
        shadowColor: AppColors.deepNavy.withValues(alpha: 0.5),
        title: Row(
          children: [
            // Logo circular na barra superior
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.pureWhite, width: 1.5),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
                children: [
                  TextSpan(
                    text: 'WORLD ',
                    style: TextStyle(color: AppColors.pureWhite),
                  ),
                  TextSpan(
                    text: 'FITNESS',
                    style: TextStyle(color: AppColors.primaryRed),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: isDesktop
            ? [
                _NavButton(
                  title: 'MODALIDADES',
                  onTap: () => _scrollToSection(_modalidadesKey),
                ),
                _NavButton(
                  title: 'PLANOS',
                  onTap: () => _scrollToSection(_planosKey),
                ),
                _NavButton(
                  title: 'CONTATO',
                  onTap: () => _scrollToSection(_contatoKey),
                ),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      foregroundColor: AppColors.pureWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _scrollToSection(_planosKey),
                    child: const Text(
                      'MATRICULE-SE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // 1. HERO SECTION (Banner Principal com a Logo em destaque)
            _HeroSection(
              onCtaPressed: () => _scrollToSection(_planosKey),
            ),

            // 2. MODALIDADES
            Container(
              key: _modalidadesKey,
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              child: Column(
                children: [
                  const _SectionHeader(
                    subtitle: 'TREINE DO SEU JEITO',
                    title: 'NOSSAS MODALIDADES',
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: const [
                      _ModalityCard(
                        icon: Icons.fitness_center,
                        title: 'Musculação',
                        description:
                            'Equipamentos modernos e acompanhamento profissional para hipertrofia e definição.',
                      ),
                      _ModalityCard(
                        icon: Icons.directions_run,
                        title: 'Funcional & Cardio',
                        description:
                            'Treinos dinâmicos de alta intensidade para queima calórica e condicionamento físico.',
                      ),
                      _ModalityCard(
                        icon: Icons.sports_martial_arts,
                        title: 'Artes Marciais',
                        description:
                            'Aulas de luta para defesa pessoal, disciplina, agilidade e alívio do estresse.',
                      ),
                      _ModalityCard(
                        icon: Icons.self_improvement,
                        title: 'Avaliação Física',
                        description:
                            'Acompanhamento periódico de bioimpedância e montagem de ficha personalizada.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3. PLANOS
            Container(
              key: _planosKey,
              width: double.infinity,
              color: AppColors.cardSurface.withValues(alpha: 0.5),
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              child: Column(
                children: [
                  const _SectionHeader(
                    subtitle: 'INVISTA NA SUA SAÚDE',
                    title: 'PLANOS E VALORES',
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    alignment: WrapAlignment.center,
                    children: const [
                      _PlanCard(
                        title: 'PLANO MENSAL',
                        price: 'R\$ 89,90',
                        period: '/mês',
                        features: [
                          'Acesso livre à musculação',
                          'Avaliação física inicial',
                          'Sem taxa de fidelidade',
                          'App de treino exclusivo',
                        ],
                        isHighlighted: false,
                      ),
                      _PlanCard(
                        title: 'PLANO ANUAL VIP',
                        price: 'R\$ 69,90',
                        period: '/mês',
                        features: [
                          'Acesso total (Musculação + Aulas)',
                          'Avaliação física a cada 60 dias',
                          'Direito a levar 1 amigo por mês',
                          'Camiseta oficial World Fitness',
                        ],
                        isHighlighted: true,
                      ),
                      _PlanCard(
                        title: 'PLANO TRIMESTRAL',
                        price: 'R\$ 79,90',
                        period: '/mês',
                        features: [
                          'Acesso livre à musculação',
                          'Aulas coletivas inclusas',
                          'Avaliação física inicial',
                          'App de treino exclusivo',
                        ],
                        isHighlighted: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 4. RODAPÉ / CONTATO
            Container(
              key: _contatoKey,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.darkBackground, AppColors.deepNavy],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              child: Column(
                children: [
                  // Logo no rodapé
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.pureWhite, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryRed.withValues(alpha: 0.4),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'ACADEMIA WORLD FITNESS',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Segunda a Sexta: 05h30 às 22h00 | Sábado: 08h00 às 14h00',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.metallicSilver),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    ),
                    onPressed: () {
                      // Ação do WhatsApp
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text(
                      'FALAR NO WHATSAPP',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 16),
                  const Text(
                    '© 2026 World Fitness. Todos os direitos reservados.',
                    style: TextStyle(color: AppColors.metallicSilver, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.pureWhite,
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final VoidCallback onCtaPressed;

  const _HeroSection({required this.onCtaPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.deepNavy,
            AppColors.darkBackground,
            AppColors.primaryRed.withValues(alpha: 0.35),
          ],
        ),
        border: const Border(
          bottom: BorderSide(color: AppColors.primaryRed, width: 3),
        ),
      ),
      child: Column(
        children: [
          // Logo oficial em destaque no centro do Banner Principal
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.pureWhite, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryRed.withValues(alpha: 0.5),
                  blurRadius: 30,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: AppColors.deepNavy.withValues(alpha: 0.8),
                  blurRadius: 40,
                  spreadRadius: 6,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.png',
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primaryRed),
            ),
            child: const Text(
              '★ SUPERE SEUS LIMITES ★',
              style: TextStyle(
                color: AppColors.pureWhite,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'O SEU MUNDO DE\nFORÇA E SAÚDE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              height: 1.1,
              letterSpacing: 1.2,
              color: AppColors.pureWhite,
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: 600,
            child: Text(
              'Estrutura completa, equipamentos de alta performance e profissionais prontos para transformar seus resultados na World Fitness.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.metallicSilver,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 36),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  foregroundColor: AppColors.pureWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onCtaPressed,
                child: const Text(
                  'COMEÇAR AGORA',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.pureWhite,
                  side: const BorderSide(color: AppColors.pureWhite, width: 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onCtaPressed,
                child: const Text(
                  'AGENDAR AULA EXPERIMENTAL',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String subtitle;
  final String title;

  const _SectionHeader({required this.subtitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.primaryRed,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: AppColors.pureWhite,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [AppColors.primaryRed, AppColors.deepNavy],
            ),
          ),
        ),
      ],
    );
  }
}

class _ModalityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _ModalityCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.deepNavy, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryRed, size: 32),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.pureWhite,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.metallicSilver,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final List<String> features;
  final bool isHighlighted;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.period,
    required this.features,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isHighlighted ? AppColors.deepNavy : AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlighted ? AppColors.primaryRed : Colors.white12,
          width: isHighlighted ? 2.5 : 1,
        ),
        boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: AppColors.primaryRed.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isHighlighted)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryRed,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'MAIS ESCOLHIDO',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.pureWhite,
                ),
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.metallicSilver,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: AppColors.pureWhite,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 4),
                child: Text(
                  period,
                  style: const TextStyle(color: AppColors.metallicSilver),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white12),
          const SizedBox(height: 16),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.primaryRed,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(color: AppColors.pureWhite),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isHighlighted ? AppColors.primaryRed : Colors.white10,
                foregroundColor: AppColors.pureWhite,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'ASSINAR PLANO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}