import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

void main() {
  runApp(const WorldFitnessApp());
}

class AppColors {
  // Paleta Principal (Extraída do Logo)
  static const Color primaryRed = Color(0xFFC82333); // Vermelho Intenso
  static const Color deepNavy = Color(0xFF1E2E7A); // Azul Marinho
  static const Color metallicGray = Color(0xFF9EA3A8); // Cinza Metálico
  static const Color pureWhite = Color(0xFFFFFFFF); // Branco Puro

  // Cores Complementares
  static const Color lightGrayBg = Color(0xFFF4F6F9); // Cinza Muito Claro
  static const Color darkGraphite = Color(0xFF1A1D24); // Grafite Escuro
  static const Color softLightBlue = Color(0xFFE8EEF7); // Azul Claro Suave
  static const Color textMuted = Color(0xFF525866); // Texto secundário legível
  static const Color borderLight = Color(0xFFDDE2EB); // Bordas sutis

  // Redes Sociais
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
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.pureWhite,
        primaryColor: AppColors.deepNavy,
        colorScheme: const ColorScheme.light(
          primary: AppColors.deepNavy,
          secondary: AppColors.primaryRed,
          surface: AppColors.pureWhite,
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
  final GlobalKey _inicioKey = GlobalKey();
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
        backgroundColor: AppColors.deepNavy,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        toolbarHeight: 72,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : 8),
          child: Row(
            children: [
              // Container adaptado ao formato oval da logo1.png com fundo branco limpo
              Container(
                width: 68,
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.metallicGray, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/logo1.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (ctx, err, st) => const Icon(
                      Icons.fitness_center,
                      color: AppColors.deepNavy,
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
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
        ),
        actions: isDesktop
            ? [
                _NavButton(
                  title: 'Início',
                  onTap: () => _scrollToSection(_inicioKey),
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
                      foregroundColor: AppColors.pureWhite,
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
            Container(
              key: _inicioKey,
              child: _HeroSection(
                isDesktop: isDesktop,
                onWhatsAppTap: () => _openUrl(_whatsappUrl),
                onContactTap: () => _scrollToSection(_contatoKey),
              ),
            ),

            // Rodapé / Contato (Azul Marinho #1E2E7A)
            Container(
              key: _contatoKey,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.deepNavy,
                border: Border(
                  top: BorderSide(color: AppColors.metallicGray, width: 1.5),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    children: [
                      // Logo oval em destaque no rodapé com fundo branco limpo
                      Container(
                        width: 126,
                        height: 88,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(44),
                          border: Border.all(
                              color: AppColors.metallicGray, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/logo1.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                            errorBuilder: (ctx, err, st) => const Icon(
                              Icons.fitness_center,
                              color: AppColors.deepNavy,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'ACADEMIA WORLD FITNESS',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.pureWhite,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Segunda a Sexta: 05h30 às 22h00  •  Sábado: 08h00 às 14h00',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.pureWhite.withValues(alpha: 0.85),
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
                              foregroundColor: AppColors.pureWhite,
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
                              foregroundColor: AppColors.deepNavy,
                              backgroundColor: AppColors.pureWhite,
                              side: const BorderSide(
                                  color: AppColors.metallicGray, width: 1.5),
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
                      Divider(
                        color: AppColors.pureWhite.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '© 2026 Academia World Fitness. Todos os direitos reservados.',
                        style: TextStyle(
                          color: AppColors.pureWhite.withValues(alpha: 0.75),
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
        foregroundColor: AppColors.pureWhite,
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
  final VoidCallback onContactTap;

  const _HeroSection({
    required this.isDesktop,
    required this.onWhatsAppTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.pureWhite,
            AppColors.softLightBlue.withValues(alpha: 0.65),
          ],
        ),
        border: const Border(
          bottom: BorderSide(color: AppColors.borderLight, width: 1),
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
                        color: AppColors.primaryRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primaryRed.withValues(alpha: 0.35),
                        ),
                      ),
                      child: const Text(
                        'SAÚDE • BEM-ESTAR • RESULTADOS',
                        style: TextStyle(
                          color: AppColors.primaryRed,
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
                        color: AppColors.deepNavy,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'A Academia World Fitness oferece um ambiente acolhedor, equipamentos modernos e acompanhamento dedicado para você cuidar do corpo e da mente.',
                      textAlign: isDesktop ? TextAlign.left : TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.6,
                        color: AppColors.darkGraphite,
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
                            foregroundColor: AppColors.pureWhite,
                            elevation: 2,
                            shadowColor:
                                AppColors.primaryRed.withValues(alpha: 0.35),
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
                            foregroundColor: AppColors.deepNavy,
                            backgroundColor: AppColors.pureWhite,
                            side: const BorderSide(
                                color: AppColors.deepNavy, width: 1.5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: onContactTap,
                          child: const Text(
                            'Horários e Contato',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isDesktop)
                const SizedBox(width: 48)
              else
                const SizedBox(height: 40),
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: Container(
                  height: 360,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.deepNavy, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.deepNavy.withValues(alpha: 0.14),
                        blurRadius: 28,
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
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: AppColors.pureWhite,
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Exibição fiel da logo1.png em formato oval sem cortes
                                  Expanded(
                                    child: Center(
                                      child: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: 280,
                                          maxHeight: 210,
                                        ),
                                        child: Image.asset(
                                          'assets/images/logo1.png',
                                          fit: BoxFit.contain,
                                          errorBuilder: (ctx, err, st) =>
                                              Image.asset(
                                            'assets/images/logo.png',
                                            fit: BoxFit.contain,
                                            errorBuilder: (c, e, s) =>
                                                const Icon(
                                              Icons.fitness_center,
                                              color: AppColors.deepNavy,
                                              size: 72,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'ACADEMIA WORLD FITNESS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.deepNavy,
                                      letterSpacing: 1.4,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
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
            color: AppColors.deepNavy,
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
              color: AppColors.darkGraphite,
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
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.metallicGray.withValues(alpha: 0.6),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withValues(alpha: 0.08),
            blurRadius: 14,
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
                    color: AppColors.softLightBlue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.pureWhite,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:
                                  AppColors.metallicGray.withValues(alpha: 0.6),
                            ),
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColors.deepNavy,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.pureWhite,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.deepNavy.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Text(
                            label.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.deepNavy,
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
                      color: AppColors.deepNavy,
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
        color: AppColors.lightGrayBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.metallicGray.withValues(alpha: 0.55),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withValues(alpha: 0.1),
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
              color: AppColors.deepNavy,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.darkGraphite,
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
                color: AppColors.darkGraphite,
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