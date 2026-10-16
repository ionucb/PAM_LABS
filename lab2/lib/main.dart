import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class AppColors {
  static const black01 = Color(0xFF191D31);
  static const black03 = Color(0xFF8C8E98);
  static const coralGreen = Color(0xFF2BACBE);
  static const lightGrey02 = Color(0xFFF9F9F9);
  static const lightGrey03 = Color(0xFFFBFBFD);
  static const grey01 = Color(0xFFA7AEC1);
  static const red01 = Color(0xFFE50000);
  // ecranul 2
  static const primary = Color(0xFF0B8FAC);
  static const secondary = Color(0xFF7BC1B7);
  static const gray = Color(0xFF858585);
  static const chip = Color(0x4DD9D9D9); // rgba(217,217,217,0.3)
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const HomeScreen(),
    );
  }
}

/// Imagine din assets, cu fallback gri daca fisierul lipseste.
class AppImage extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final double radius;
  final BoxShape shape;

  const AppImage(
      this.path, {
        super.key,
        required this.width,
        required this.height,
        this.radius = 0,
        this.shape = BoxShape.rectangle,
      });

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(width: width, height: height, color: const Color(0xFFD9D9D9));
    final img = Image.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => placeholder,
    );
    if (shape == BoxShape.circle) return ClipOval(child: img);
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: img);
  }
}

// ---------------------------------------------------------------------------
// ECRAN 1 - Homescreen
// ---------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              const SizedBox(height: 24),
              const _SearchBar(),
              const SizedBox(height: 24),
              const _AppointmentCard(),
              const SizedBox(height: 24 + 25), // 25 = cat iese cardul alb in afara
              const _SectionTitle('Health Services'),
              const SizedBox(height: 16),
              const _HealthServices(),
              const SizedBox(height: 24),
              const _SectionTitle('Nearby Doctor'),
              const SizedBox(height: 16),
              const _DoctorTile(
                image: 'assets/images/doctor1.png',
                name: 'Dr. Emmly Lestiryno',
                specialty: 'General Practitioner',
                address: '3167 Durgan Shores - 500M from you',
              ),
              const SizedBox(height: 16),
              const _DoctorTile(
                image: 'assets/images/doctor2.png',
                name: 'Dr. Sonja Littel',
                specialty: 'Dental Specialist',
                address: '950 Sigrid Port - 753M from you',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const AppImage('assets/images/avatar.png',
                width: 44, height: 44, shape: BoxShape.circle),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hi, Jonathan',
                    style: GoogleFonts.outfit(
                        fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.black01)),
                Text('May you always be healthy',
                    style: GoogleFonts.outfit(fontSize: 10, color: AppColors.black03)),
              ],
            ),
          ],
        ),
        SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(Icons.notifications_none_rounded, size: 24, color: AppColors.black01),
              Positioned(
                top: 13,
                right: 13,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: AppColors.red01, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.lightGrey03,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.lightGrey02),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 24, color: AppColors.grey01),
          const SizedBox(width: 15),
          Expanded(
            child: Text('Search something',
                style: GoogleFonts.outfit(fontSize: 14, color: AppColors.grey01)),
          ),
          const Icon(Icons.tune_rounded, size: 24, color: AppColors.grey01),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  const _AppointmentCard();

  @override
  Widget build(BuildContext context) {
    final white14 = GoogleFonts.outfit(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white, height: 1.3);

    return SizedBox(
      height: 173,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // fundalul turcoaz
          Container(
            decoration: BoxDecoration(
              color: AppColors.coralGreen,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.fromLTRB(21, 23, 21, 0),
            child: Column(
              children: [
                // ===== SINGURUL BUTON FUNCTIONAL =====
                // Apasa pe "Appointment >" pentru a deschide ecranul 2.
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const AppointmentScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Appointment',
                          style: GoogleFonts.outfit(
                              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white)),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.white),
                          const SizedBox(width: 8),
                          Text('22 October, 2023', style: white14),
                        ]),
                        const SizedBox(height: 12),
                        Row(children: [
                          const Icon(Icons.access_time, size: 20, color: Colors.white),
                          const SizedBox(width: 8),
                          Text('08:00 AM - 10.30 AM', style: white14),
                        ]),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.edit_outlined, size: 24, color: AppColors.coralGreen),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // cardul alb cu doctorul, iese 25px in afara
          Positioned(
            left: 22,
            right: 22,
            top: 131,
            child: Container(
              height: 67,
              padding: const EdgeInsets.symmetric(horizontal: 13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Color(0x1C000000), blurRadius: 80, offset: Offset(0, 8)),
                ],
              ),
              child: Row(
                children: [
                  const AppImage('assets/images/doctor3.png', width: 43, height: 43, radius: 8),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dr. Richar Kandowen',
                            style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black01,
                                height: 1.3)),
                        const SizedBox(height: 4),
                        Text('Child Specialist',
                            style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black03,
                                height: 1.3)),
                      ],
                    ),
                  ),
                  const Icon(Icons.chat_outlined, size: 24, color: AppColors.black01),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.outfit(
                fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.black01)),
        Text('See All', style: GoogleFonts.outfit(fontSize: 12, color: AppColors.coralGreen)),
      ],
    );
  }
}

class _HealthServices extends StatelessWidget {
  const _HealthServices();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Tooth', 'assets/images/tooth.png'),
      ('Eye', 'assets/images/eye.png'),
      ('Lungs', 'assets/images/lungs.png'),
      ('Ear', 'assets/images/ear.png'),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final (label, asset) in items)
          Column(
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey02,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AppImage(asset, width: 32, height: 32),
              ),
              const SizedBox(height: 8),
              Text(label,
                  style: GoogleFonts.outfit(
                      fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black03)),
            ],
          ),
      ],
    );
  }
}

class _DoctorTile extends StatelessWidget {
  final String image, name, specialty, address;
  const _DoctorTile({
    required this.image,
    required this.name,
    required this.specialty,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppImage(image, width: 46, height: 46, shape: BoxShape.circle),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black01,
                      height: 1.3)),
              Text(specialty,
                  style: GoogleFonts.outfit(fontSize: 12, color: AppColors.black03, height: 1.8)),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 18, color: AppColors.coralGreen),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(address,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                            fontSize: 12, color: AppColors.black01, height: 1.8)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Icon(Icons.favorite_border, size: 20, color: AppColors.black03),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// ECRAN 2 - Appointment details (doar vizual, fara actiuni)
// ---------------------------------------------------------------------------
class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const _AppointmentTopBar(),
                    const SizedBox(height: 24),
                    const _DoctorInfo(),
                    const SizedBox(height: 32),
                    Text('Details',
                        style: GoogleFonts.openSans(
                            fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(height: 12),
                    Text(
                      'Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate '
                          'libero et velit interdum, ac aliquet odio mattis. Class aptent taciti '
                          'sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. '
                          'Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur '
                          'neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.',
                      style: GoogleFonts.openSans(
                          fontSize: 13, height: 1.32, color: AppColors.gray),
                    ),
                    const SizedBox(height: 40),
                    const _ChipSection(
                      title: 'Working Hours',
                      chips: ['10.00 AM', '11.00 AM', '12.00 PM'],
                      selected: 1,
                    ),
                    const SizedBox(height: 26),
                    const _ChipSection(
                      title: 'Date',
                      chips: ['Sun 4', 'Mon 5', 'Tue 6'],
                      selected: 0,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 8, 26, 24),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {}, // doar vizual
                  child: Text('Book an Appointment',
                      style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentTopBar extends StatelessWidget {
  const _AppointmentTopBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).maybePop(),
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 24, color: Colors.black),
            ),
          ),
          Text('Appointment',
              style: GoogleFonts.openSans(
                  fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.primary)),
        ],
      ),
    );
  }
}

class _DoctorInfo extends StatelessWidget {
  const _DoctorInfo();

  @override
  Widget build(BuildContext context) {
    Widget circleIcon(IconData icon) => Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: Colors.black),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppImage('assets/images/doctor_upul.png', width: 132, height: 132, radius: 10),
        const SizedBox(width: 21),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Dr.Upul',
                        style: GoogleFonts.openSans(
                            fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black)),
                    const SizedBox(width: 12),
                    circleIcon(Icons.chat_bubble_outline),
                    const SizedBox(width: 8),
                    circleIcon(Icons.call_outlined),
                    const SizedBox(width: 8),
                    circleIcon(Icons.videocam_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text('Denteeth',
                  style: GoogleFonts.openSans(
                      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.secondary)),
              const SizedBox(height: 22),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Payment',
                        style: GoogleFonts.openSans(
                            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
                    const SizedBox(width: 24),
                    Text('\$120.00',
                        style: GoogleFonts.openSans(
                            fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.secondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChipSection extends StatelessWidget {
  final String title;
  final List<String> chips;
  final int selected;
  const _ChipSection({required this.title, required this.chips, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: GoogleFonts.openSans(
                    fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)),
            Text('See All', style: GoogleFonts.openSans(fontSize: 16, color: Colors.black)),
          ],
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < chips.length; i++) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  decoration: BoxDecoration(
                    color: i == selected ? AppColors.primary : AppColors.chip,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(chips[i],
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          height: 1,
                          color: i == selected ? Colors.white : Colors.black)),
                ),
                if (i != chips.length - 1) const SizedBox(width: 15),
              ],
            ],
          ),
        ),
      ],
    );
  }
}