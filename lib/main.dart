import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void main() {
  runApp(const WorldFitnessApp());
}

class AppColors {
  static const Color primaryRed = Color(0xFFC81D25);
  static const Color deepNavy = Color(0xFF142864);
  static const Color backgroundDark = Color(0xFF0B0F19);
  static const Color surfaceDark = Color(0xFF131A29);
  static const Color surfaceElevated = Color(0xFF1A2336);
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFA0AAB8);
  static const Color borderDark = Color(0xFF232E47);
  static const Color whatsappGreen = Color(0xFF25D366);
  static const Color instagramPink = Color(0xFFE1306C);
}

class WorldFitnessApp extends StatelessWidget {
  const WorldFitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academia World Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        primaryColor: AppColors.primaryRed,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryRed,
          secondary: AppColors.deepNavy,
          surface: AppColors.surfaceDark,
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
  final GlobalKey _estruturaKey = GlobalKey();
  final GlobalKey _modalidadesKey = GlobalKey();
  final GlobalKey _planoKey = GlobalKey();
  final GlobalKey _contatoKey = GlobalKey();

  static const String _whatsappUrl =
      'https://wa.me/558281053187?text=Ol%C3%A1!%20Gostaria%20de%20mais%20informa%C3%A7%C3%B5es%20sobre%20a%20World%20Fitness.';
  static const String _instagramUrl =
      'https://www.instagram.com/academiaworldfitnesss';

  void _openUrl(String url) {
    try {
      html.window.open(url, '_blank');
    } catch (e) {
      debugPrint('Erro ao abrir URL: $e');
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 850;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark.withValues(alpha: 0.92),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.borderDark, height: 1),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderDark, width: 1.5),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 40,
                      height: 40,
                      color: AppColors.deepNavy,
                      child: const Icon(Icons.fitness_center,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                  children: [
                    TextSpan(
                      text: 'WORLD ',
                      style: TextStyle(color: AppColors.textPrimary),
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
        ),
        actions: isDesktop
            ? [
                _NavButton(
                  title: 'Estrutura',
                  onTap: () => _scrollToSection(_estruturaKey),
                ),
                _NavButton(
                  title: 'Modalidades',
                  onTap: () => _scrollToSection(_modalidadesKey),
                ),
                _NavButton(
                  title: 'Mensalidade',
                  onTap: () => _scrollToSection(_planoKey),
                ),
                _NavButton(
                  title: 'Contato',
                  onTap: () => _scrollToSection(_contatoKey),
                ),
                const SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whatsappGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => _openUrl(_whatsappUrl),
                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                    label: const Text(
                      'WhatsApp',
                      style: TextStyle(fontWeight: FontWeight.w600),
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
            _HeroSection(
              isDesktop: isDesktop,
              onWhatsAppTap: () => _openUrl(_whatsappUrl),
              onExploreTap: () => _scrollToSection(_estruturaKey),
            ),

            Container(
              key: _estruturaKey,
              width: double.infinity,
              color: AppColors.surfaceDark.withValues(alpha: 0.65),
              padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    children: [
                      const _SectionHeader(
                        subtitle: 'CONHEÇA O AMBIENTE',
                        title: 'Nossa Estrutura',
                        description:
                            'Um espaço pensado para o seu conforto, bem-estar e evolução diária.',
                      ),
                      const SizedBox(height: 48),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: const [
                          _PhotoSlotCard(
                            label: 'ft1',
                            caption: 'Área de Musculação',
                            imagePath: 'assets/images/ft1.jpg',
                          ),
                          _PhotoSlotCard(
                            label: 'ft2',
                            caption: 'Equipamentos Modernos',
                            imagePath: 'assets/images/ft2.jpg',
                          ),
                          _PhotoSlotCard(
                            label: 'ft3',
                            caption: 'Espaço Cardio & Funcional',
                            imagePath: 'assets/images/ft3.jpg',
                          ),
                          _PhotoSlotCard(
                            label: 'ft4',
                            caption: 'Ambiente Climatizado e Amplo',
                            imagePath: 'assets/images/ft4.jpg',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              key: _modalidadesKey,
              width: double.infinity,
              color: AppColors.backgroundDark,
              padding: const EdgeInsets.symmetric(vertical: 72, horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    children: [
                      const _SectionHeader(
                        subtitle: 'O QUE OFERECEMOS',
                        title: 'Modalidades e Acompanhamento',
                        description:
                            'Treinos completos para todos os objetivos, do iniciante ao avançado.',
                      ),
                      const SizedBox(height: 48),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: const [
                          _ModalityCard(
                            icon: Icons.fitness_center_rounded,
                            title: 'Musculação',
                            description:
                                'Aparelhos completos e pesos livres para hipertrofia, força e definição.',
                          ),
                          _ModalityCard(
                            icon: Icons.directions_run_rounded,
                            title: 'Cardio & Condicionamento',
                            description:
                                'Esteiras e equipamentos aeróbicos para melhorar sua resistência e saúde.',
                          ),
                          _ModalityCard(
                            icon: Icons.assignment_turned_in_outlined,
                            title: 'Ficha Personalizada',
                            description:
                                'Instrutores atenciosos para montar seu treino de acordo com seus objetivos.',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              key: _planoKey,
              width: double.infinity,
              color: AppColors.surfaceDark.withValues(alpha: 0.4),
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    children: [
                      const _SectionHeader(
                        subtitle: 'TRANSPARÊNCIA E SIMPLICIDADE',
                        title: 'Valor da Mensalidade',
                        description:
                            'Sem taxas escondidas ou burocracia. Um plano único com acesso completo.',
                      ),
                      const SizedBox(height: 48),
                      Container(
                        width: 420,
                        padding: const EdgeInsets.all(36),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.surfaceElevated,
                              AppColors.surfaceDark,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.deepNavy,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.deepNavy.withValues(alpha: 0.25),
                              blurRadius: 30,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.primaryRed.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.primaryRed.withValues(alpha: 0.4),
                                ),
                              ),
                              child: const Text(
                                'PLANO ÚNICO • ACESSO LIVRE',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(top: 8, right: 4),
                                  child: Text(
                                    'R\$',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                Text(
                                  '80',
                                  style: TextStyle(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w900,
                                    height: 1,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8, left: 2),
                                  child: Text(
                                    ',00',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'por mês',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 28),
                            const Divider(color: AppColors.borderDark),
                            const SizedBox(height: 24),
                            const _BenefitItem(
                                text: 'Acesso livre a toda a academia'),
                            const _BenefitItem(
                                text: 'Acompanhamento de instrutores'),
                            const _BenefitItem(
                                text: 'Montagem de treino personalizada'),
                            const _BenefitItem(
                                text: 'Sem fidelidade ou multas'),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundDark.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.borderDark),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.info_outline,
                                      size: 20, color: AppColors.textSecondary),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Matrícula realizada diretamente na recepção da academia.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              key: _contatoKey,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.backgroundDark,
                    AppColors.deepNavy.withValues(alpha: 0.45),
                  ],
                ),
                border: const Border(
                  top: BorderSide(color: AppColors.borderDark, width: 1),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.borderDark, width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 68,
                            height: 68,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 68,
                              height: 68,
                              color: AppColors.deepNavy,
                              child: const Icon(Icons.fitness_center,
                                  color: Colors.white, size: 30),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'ACADEMIA WORLD FITNESS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Segunda a Sexta: 05h30 às 22h00  •  Sábado: 08h00 às 14h00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.whatsappGreen,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => _openUrl(_whatsappUrl),
                            icon: const Icon(Icons.chat_rounded),
                            label: const Text(
                              '+55 82 8105-3187',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              backgroundColor: AppColors.surfaceDark,
                              side: const BorderSide(
                                  color: AppColors.borderDark, width: 1.5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => _openUrl(_instagramUrl),
                            icon: const Icon(Icons.camera_alt_outlined,
                                color: AppColors.instagramPink),
                            label: const Text(
                              '@academiaworldfitnesss',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      const Divider(color: AppColors.borderDark),
                      const SizedBox(height: 20),
                      const Text(
                        '© 2026 Academia World Fitness. Todos os direitos reservados.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
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
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onExploreTap;

  const _HeroSection({
    required this.isDesktop,
    required this.onWhatsAppTap,
    required this.onExploreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.6, -0.2),
          radius: 1.2,
          colors: [
            AppColors.deepNavy.withValues(alpha: 0.45),
            AppColors.backgroundDark,
          ],
        ),
        border: const Border(
          bottom: BorderSide(color: AppColors.borderDark, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 80 : 48,
        horizontal: 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: isDesktop ? 6 : 0,
                child: Column(
                  crossAxisAlignment: isDesktop
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryRed.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primaryRed.withValues(alpha: 0.35),
                        ),
                      ),
                      child: const Text(
                        'SAÚDE • BEM-ESTAR • RESULTADOS',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Treine com qualidade no seu ritmo.',
                      textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                      style: TextStyle(
                        fontSize: isDesktop ? 46 : 34,
                        fontWeight: FontWeight.w900,
                        height: 1.15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'A Academia World Fitness oferece um ambiente acolhedor, equipamentos modernos e acompanhamento dedicado para você cuidar do corpo e da mente.',
                      textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.6,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      alignment: isDesktop
                          ? WrapAlignment.start
                          : WrapAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryRed,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: onWhatsAppTap,
                          icon: const Icon(Icons.chat_rounded, size: 20),
                          label: const Text(
                            'Falar no WhatsApp',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            backgroundColor: AppColors.surfaceDark.withValues(alpha: 0.6),
                            side: const BorderSide(
                                color: AppColors.borderDark, width: 1.5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: onExploreTap,
                          child: const Text(
                            'Conhecer o Espaço',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isDesktop) const SizedBox(width: 48) else const SizedBox(height: 40),
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: Container(
                  height: 360,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceDark,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.borderDark, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.deepNavy.withValues(alpha: 0.25),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.asset(
                          'assets/images/ft_capa.jpg',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.textPrimary, width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryRed
                                            .withValues(alpha: 0.35),
                                        blurRadius: 28,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder: (ctx, err, st) => Container(
                                        width: 150,
                                        height: 150,
                                        color: AppColors.deepNavy,
                                        child: const Icon(
                                          Icons.fitness_center,
                                          color: Colors.white,
                                          size: 60,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                const Text(
                                  'ACADEMIA WORLD FITNESS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String subtitle;
  final String title;
  final String description;

  const _SectionHeader({
    required this.subtitle,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.primaryRed,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _PhotoSlotCard extends StatelessWidget {
  final String label;
  final String caption;
  final String imagePath;

  const _PhotoSlotCard({
    required this.label,
    required this.caption,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderDark),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
            child: SizedBox(
              height: 190,
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.surfaceElevated,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.borderDark),
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColors.textPrimary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.deepNavy.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.borderDark,
                            ),
                          ),
                          child: Text(
                            label.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.photo_library_outlined,
                    size: 16, color: AppColors.primaryRed),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    caption,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
      width: 330,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryRed.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(icon, color: AppColors.primaryRed, size: 28),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              height: 1.5,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final String text;

  const _BenefitItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.whatsappGreen,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}