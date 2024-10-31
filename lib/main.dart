import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(Penyewaa());
}

class Penyewaa extends StatelessWidget {
  Penyewaa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forklift Rental UMKM',
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _testimonialKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey(); // New GlobalKey for About Us

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'PT. Central Trans Banua',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 187, 137, 0),
        elevation: 0,
        actions: [
          _navButton('Home', () => _scrollToSection(_homeKey)),
          _navButton('Layanan', () => _scrollToSection(_servicesKey)),
          _navButton('Testimoni', () => _scrollToSection(_testimonialKey)),
          _navButton('Kontak', () => _scrollToSection(_contactKey)),
          _navButton('Tentang Kami', () => _scrollToSection(_aboutKey)), // New button
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(onContactButtonPressed: () => _scrollToSection(_contactKey), key: _homeKey),
            AboutUsSection(), // Add About Us section here
            ServicesSection(key: _servicesKey),
            TestimonialSection(key: _testimonialKey),
            ContactSection(key: _contactKey),
            FooterSection(),
          ],
        ),
      ),
    );
  }

  Widget _navButton(String title, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}

class HeroSection extends StatelessWidget {
  final VoidCallback onContactButtonPressed;

  HeroSection({
    Key? key,
    required this.onContactButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/77d41a1a-8742-429a-a7a8-9b5402c4f2f5.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sewa Forklift Cepat dan Terpercaya',
              style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Solusi terbaik untuk kebutuhan pengangkutan dan pengangkatan barang berat Anda.',
              style: TextStyle(fontSize: 18, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: onContactButtonPressed,
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromARGB(255, 187, 137, 0),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Text('Hubungi Kami', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
class AboutUsSection extends StatelessWidget {
  const AboutUsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(
            'Tentang Kami',
            style: TextStyle(fontSize: MediaQuery.of(context).size.width/45, fontWeight: FontWeight.bold,),
          ),),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Image.network(
                'https://www.ssents.com/hubfs/forklift-types.jpg',
                width: MediaQuery.of(context).size.width/2,
              ),
              SizedBox(width: 40,),
              Expanded( 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PT. Central Trans Banua adalah penyedia layanan sewa forklift yang berdedikasi untuk memenuhi kebutuhan transportasi dan pengangkatan barang berat Anda. Kami berkomitmen untuk memberikan pelayanan terbaik dengan armada forklift berkualitas tinggi dan dukungan pelanggan yang responsif.',
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width/55),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Kami percaya bahwa setiap proyek adalah unik, dan kami siap untuk memberikan solusi yang tepat untuk setiap pelanggan. Dengan pengalaman dan profesionalisme, kami memastikan bahwa setiap transaksi berjalan lancar dan memuaskan.',
                      style: TextStyle(fontSize: MediaQuery.of(context).size.width/55),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class ServicesSection extends StatelessWidget {
  ServicesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Layanan Kami',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildServiceCard(Icons.today, 'Sewa Harian', 'Fleksibel untuk kebutuhan mendesak dengan waktu sewa harian.'),
              _buildServiceCard(Icons.calendar_today, 'Sewa Mingguan', 'Paket ekonomis untuk kebutuhan jangka menengah.'),
              _buildServiceCard(Icons.calendar_view_month, 'Sewa Bulanan', 'Pilihan terbaik untuk proyek jangka panjang dengan harga lebih terjangkau.'),
            ],
          ),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildServiceCard(Icons.today, 'Sewa Forklift 3 Ton', 'Ideal untuk proyek kecil dan pengangkutan barang ringan.'),
              _buildServiceCard(Icons.calendar_today, 'Sewa Forklift 5 Ton', 'Cocok untuk penggunaan sedang dan pengangkutan barang yang lebih berat.'),
              _buildServiceCard(Icons.calendar_view_month, 'Sewa Forklift 7 Ton', 'Dirancang untuk tugas berat, sempurna untuk industri dan proyek besar.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String description) {
    return SizedBox(
      width: 280,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Color.fromARGB(255, 187, 137, 0)),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class TestimonialSection extends StatelessWidget {
  TestimonialSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      color: Colors.grey[200],
      child: Column(
        children: [
          Text(
            'Testimoni Pelanggan',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          _buildTestimonialCard('Pelayanan cepat dan forklift dalam kondisi prima!', 'Andi, Pengusaha Logistik'),
          _buildTestimonialCard('Harga bersaing dengan kualitas terbaik, sangat recommended!', 'Siti, Manajer Proyek'),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String text, String author) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '"$text"',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text('- $author', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  ContactSection({Key? key}) : super(key: key);

  void _launchWhatsApp() {
    final Uri whatsappUrl = Uri.parse('https://wa.me/62123456789');
    launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
  }

  void _launchGoogleMaps() {
    final Uri mapsUrl = Uri.parse('https://www.bing.com/maps?osid=497b7b80-eedd-4122-91f2-35d61ceb43d8&cp=-3.350175~114.559947&lvl=17&pi=0&v=2&sV=2&form=S00027');
    launchUrl(mapsUrl, mode: LaunchMode.externalApplication);
  }

  void _launchGmail() {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'random@gmail.com',
    );
    launchUrl(emailUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          Text(
            'Kontak Kami',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Alamat: Jl. Kasturi II Blok B No 53 RT 22 Perumahan Mantuil Raya. Banjarmasin Kalimantan Selatan\nEmail: com\nTelepon/Whatsapp: +62 123 456 789',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _launchWhatsApp,
                icon: Icon(Icons.chat),
                label: Text("WhatsApp"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _launchGoogleMaps,
                icon: Icon(Icons.map),
                label: Text("Lihat di Maps"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _launchGmail,
                icon: Icon(Icons.email),
                label: Text("Email"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 187, 137, 0),
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Text(
        '© 2024 PT. Central Trans Banua. All rights reserved.',
        style: TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
