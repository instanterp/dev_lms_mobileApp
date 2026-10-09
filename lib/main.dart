import 'package:flutter/material.dart';

void main() {
  runApp(const GreenValleyApp());
}

class GreenValleyApp extends StatelessWidget {
  const GreenValleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Valley Public School',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7FAFC),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1479D5)),
        fontFamily: 'Arial',
      ),
      home: const LoginPage(),
    );
  }
}

const blue = Color(0xFF1479D5);
const navy = Color(0xFF1D3F5C);
const muted = Color(0xFF8299AB);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String role = 'Student';
  bool otpMode = false;
  bool obscurePassword = true;
  String error = '';
  final username = TextEditingController(text: 'student@greenvalley.edu');
  final password = TextEditingController(text: 'demo123');
  final otp = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    otp.dispose();
    super.dispose();
  }

  void signIn() {
    final valid = otpMode ? otp.text == '123456' : password.text == 'demo123';
    if (!valid) {
      setState(() => error = otpMode ? 'Use the preview code 123456.' : 'Use the preview password demo123.');
      return;
    }
    setState(() => error = '');
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const SchoolShell()));
  }

  InputDecoration decoration(String hint, IconData icon) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9AABBA), fontSize: 14),
        prefixIcon: Icon(icon, size: 19, color: const Color(0xFF88A0B7)),
        suffixIcon: hint == 'Enter your password'
            ? IconButton(onPressed: () => setState(() => obscurePassword = !obscurePassword), icon: Icon(obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 19, color: muted))
            : null,
        filled: true,
        fillColor: const Color(0xFFFBFDFF),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD7E5EE))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFD7E5EE))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: blue, width: 1.4)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFEEF8FF), Color(0xFFF7FBFF), Colors.white], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [Container(width: 40, height: 40, decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(13)), child: const Icon(Icons.auto_awesome, color: Colors.white, size: 20)), const SizedBox(width: 10), const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('GREEN VALLEY', style: TextStyle(color: navy, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.7)), Text('PUBLIC SCHOOL', style: TextStyle(color: Color(0xFF7190AD), fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1.5))]), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7), decoration: BoxDecoration(color: const Color(0xFFE5F2FF), borderRadius: BorderRadius.circular(20)), child: const Row(children: [Icon(Icons.verified_user_outlined, color: blue, size: 14), SizedBox(width: 5), Text('Secure access', style: TextStyle(color: blue, fontSize: 11, fontWeight: FontWeight.w700))]))]),
                  const SizedBox(height: 42),
                  const Text('ONE SCHOOL. ONE SMARTER DAY.', style: TextStyle(color: blue, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.8)),
                  const SizedBox(height: 12),
                  const Text('Your school life,\nall in one place.', style: TextStyle(color: navy, fontSize: 38, height: 1.15, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 14),
                  const Text('A simple, connected space for learning, family and school teams.', style: TextStyle(color: Color(0xFF62819D), fontSize: 15, height: 1.5)),
                  const SizedBox(height: 30),
                  Card(elevation: 5, shadowColor: const Color(0x203C83B7), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)), child: Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Welcome back', style: TextStyle(color: Color(0xFF1B3F60), fontSize: 24, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6), const Text('Choose your access and sign in securely.', style: TextStyle(color: Color(0xFF7891A7), fontSize: 13)), const SizedBox(height: 20),
                    Row(children: ['Student', 'Parent', 'Staff'].map((item) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 8), child: _RoleButton(label: item, selected: role == item, onTap: () => setState(() => role = item))))).toList()),
                    const SizedBox(height: 20),
                    Container padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFFF3F7FA), borderRadius: BorderRadius.circular(12)), child: Row(children: [Expanded(child: _ModeButton(icon: Icons.lock_outline, label: 'Username & password', selected: !otpMode, onTap: () => setState(() { otpMode = false; error = ''; }))), Expanded(child: _ModeButton(icon: Icons.sms_outlined, label: 'Mobile OTP', selected: otpMode, onTap: () => setState(() { otpMode = true; error = ''; }))) ])),
                    const SizedBox(height: 8),
                    Text(otpMode ? 'Mobile number' : 'Username or email', style: const TextStyle(color: Color(0xFF3E5C76), fontSize: 12, fontWeight: FontWeight.w700)), const SizedBox(height: 7),
                    TextField(controller: username, keyboardType: otpMode ? TextInputType.phone : TextInputType.emailAddress, decoration: decoration(otpMode ? '+91 98765 43210' : 'you@school.edu', otpMode ? Icons.sms_outlined : Icons.mail_outline)),
                    const SizedBox(height: 14),
                    Text(otpMode ? 'Verification code' : 'Password', style: const TextStyle(color: Color(0xFF3E5C76), fontSize: 12, fontWeight: FontWeight.w700)), const SizedBox(height: 7),
                    TextField(controller: otpMode ? otp : password, obscureText: !otpMode && obscurePassword, keyboardType: otpMode ? TextInputType.number : TextInputType.visiblePassword, decoration: decoration(otpMode ? 'Enter 123456 for preview' : 'Enter your password', otpMode ? Icons.verified_user_outlined : Icons.lock_outline)),
                    if (error.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 12), child: Text(error, style: const TextStyle(color: Color(0xFFC84E50), fontSize: 12))),
                    const SizedBox(height: 20),
                    SizedBox(width: double.infinity, height: 52, child: FilledButton(onPressed: signIn, style: FilledButton.styleFrom(backgroundColor: blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13))), child: Text(otpMode ? 'Verify & continue' : 'Sign in securely', style: const TextStyle(fontWeight: FontWeight.w800)))),
                    const SizedBox(height: 14), const Center(child: Text('Preview access: password demo123 · OTP 123456', style: TextStyle(color: Color(0xFF92A6B7), fontSize: 10))),
                  ]))),
                  const SizedBox(height: 22), const Center(child: Text('Need help signing in? Contact school support', style: TextStyle(color: Color(0xFF8299AC), fontSize: 12))),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  const _RoleButton({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => OutlinedButton(onPressed: onTap, style: OutlinedButton.styleFrom(backgroundColor: selected ? blue : Colors.white, foregroundColor: selected ? Colors.white : const Color(0xFF53708E), side: BorderSide(color: selected ? blue : const Color(0xFFD8E5EE)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)), padding: const EdgeInsets.symmetric(vertical: 14)), child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)));
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({required this.icon, required this.label, required this.selected, required this.onTap});
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => TextButton.icon(onPressed: onTap, icon: Icon(icon, size: 16, color: selected ? blue : muted), label: Text(label, style: TextStyle(color: selected ? blue : muted, fontSize: 11, fontWeight: FontWeight.w700)), style: TextButton.styleFrom(backgroundColor: selected ? Colors.white : Colors.transparent, padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))));
}

class SchoolShell extends StatefulWidget {
  const SchoolShell({super.key});
  @override
  State<SchoolShell> createState() => _SchoolShellState();
}

class _SchoolShellState extends State<SchoolShell> {
  int selected = 0;
  final pages = const [HomePage(), AcademicsPage(), ProgressPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) => Scaffold(body: IndexedStack(index: selected, children: pages), bottomNavigationBar: NavigationBar(selectedIndex: selected, onDestinationSelected: (value) => setState(() => selected = value), backgroundColor: Colors.white, indicatorColor: const Color(0xFFE8F4FF), destinations: const [NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'), NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Academics'), NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'Progress'), NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile')]));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => _PageScaffold(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const _TopBar(), const _HeroCard(), const _SectionTitle(title: 'Your overview', action: 'This week'), const Row(children: [_StatCard(value: '92%', label: 'Attendance', hint: '+2.4% this term', icon: Icons.trending_up, color: blue), SizedBox(width: 9), _StatCard(value: '3', label: 'Pending tasks', hint: 'Due this week', icon: Icons.schedule, color: Color(0xFFE46A38)), SizedBox(width: 9), _StatCard(value: '8.6', label: 'Average grade', hint: 'Top 15% of class', icon: Icons.groups_outlined, color: Color(0xFF19A582))]), const _SectionTitle(title: 'Quick access', action: ''), Wrap(spacing: 9, runSpacing: 9, children: [ _QuickCard(label: 'Timetable', icon: Icons.calendar_month, color: blue), _QuickCard(label: 'Assignments', icon: Icons.assignment_outlined, color: Color(0xFFE46A38)), _QuickCard(label: 'Messages', icon: Icons.chat_bubble_outline, color: Color(0xFF19A582)), _QuickCard(label: 'My courses', icon: Icons.menu_book_outlined, color: Color(0xFF8B54D8))]), const _SectionTitle(title: 'Today’s timetable', action: 'See all'), const _ScheduleCard()]));
}

class _PageScaffold extends StatelessWidget { const _PageScaffold({required this.child}); final Widget child; @override Widget build(BuildContext context) => SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(20, 18, 20, 30), child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 720), child: child)))); }
class _TopBar extends StatelessWidget { const _TopBar(); @override Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Good morning, Aarav', style: TextStyle(color: navy, fontSize: 21, fontWeight: FontWeight.w800)), SizedBox(height: 4), Text('Tuesday, 26 August 2025', style: TextStyle(color: muted, fontSize: 12))]), Row(children: [IconButton(onPressed: null, icon: Icon(Icons.notifications_none, color: Color(0xFF41657E))), Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFD4EAFE), borderRadius: BorderRadius.circular(14)), child: const Center(child: Text('AS', style: TextStyle(color: Color(0xFF176CB9), fontWeight: FontWeight.w800, fontSize: 12))))])]); }
class _HeroCard extends StatelessWidget { const _HeroCard(); @override Widget build(BuildContext context) => Container(width: double.infinity, margin: const EdgeInsets.only(top: 22), padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(22)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('YOUR LEARNING SNAPSHOT', style: TextStyle(color: Color(0xFFBFE2FF), fontSize: 10, letterSpacing: 1.4, fontWeight: FontWeight.w800)), const SizedBox(height: 10), const Text('Keep going, Aarav.', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800)), const SizedBox(height: 7), const Text('You are building a strong week. Stay curious and make today count.', style: TextStyle(color: Color(0xFFDCEFFF), fontSize: 12, height: 1.5)), const SizedBox(height: 15), FilledButton(onPressed: null, style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xFF0E64B5)), shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))), child: Text('View my progress', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)))]); }
class _SectionTitle extends StatelessWidget { const _SectionTitle({required this.title, required this.action}); final String title; final String action; @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(top: 27, bottom: 13), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(color: Color(0xFF294B66), fontWeight: FontWeight.w800, fontSize: 16)), if (action.isNotEmpty) Text(action, style: const TextStyle(color: blue, fontSize: 12, fontWeight: FontWeight.w700))])); }
class _StatCard extends StatelessWidget { const _StatCard({required this.value, required this.label, required this.hint, required this.icon, required this.color}); final String value, label, hint; final IconData icon; final Color color; @override Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFE4EDF3))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 29, height: 29, decoration: BoxDecoration(color: color.withAlpha(25), borderRadius: BorderRadius.circular(9)), child: Icon(icon, size: 17, color: color)), const SizedBox(height: 9), Text(value, style: const TextStyle(color: Color(0xFF21445F), fontSize: 19, fontWeight: FontWeight.w800)), Text(label, style: const TextStyle(color: Color(0xFF627E95), fontSize: 10, fontWeight: FontWeight.w700)), const SizedBox(height: 7), Text(hint, style: const TextStyle(color: Color(0xFF92A5B4), fontSize: 9))]))); }
class _QuickCard extends StatelessWidget { const _QuickCard({required this.label, required this.icon, required this.color}); final String label; final IconData icon; final Color color; @override Widget build(BuildContext context) => SizedBox(width: 160, child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE4EDF3))), child: Row(children: [Icon(icon, size: 19, color: color), const SizedBox(width: 9), Expanded(child: Text(label, style: const TextStyle(color: Color(0xFF3F5D75), fontSize: 12, fontWeight: FontWeight.w700)), const Icon(Icons.chevron_right, size: 15, color: Color(0xFFA2B1BD))]))); }
class _ScheduleCard extends StatelessWidget { const _ScheduleCard(); @override Widget build(BuildContext context) { final classes = [('08:00', 'Mathematics', 'Algebra & Functions', blue), ('09:15', 'Science', 'Cell Structure', Color(0xFF19A582)), ('11:00', 'English', 'Creative Writing', Color(0xFFE46A38))]; return Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFE4EDF3))), child: Column(children: classes.map((item) => ListTile(leading: SizedBox(width: 48, child: Text(item.$1, style: const TextStyle(color: Color(0xFF7891A7), fontSize: 10, fontWeight: FontWeight.w700))), title: Text(item.$2, style: const TextStyle(color: Color(0xFF34546E), fontSize: 13, fontWeight: FontWeight.w800)), subtitle: Text(item.$3, style: const TextStyle(color: Color(0xFF8BA0AF), fontSize: 10)), trailing: CircleAvatar(radius: 14, backgroundColor: item.$4, child: const Icon(Icons.play_arrow, color: Colors.white, size: 14))).toList())); } }

class AcademicsPage extends StatelessWidget { const AcademicsPage({super.key}); @override Widget build(BuildContext context) => const _PageScaffold(child: _PlaceholderPage(title: 'Academics', subtitle: 'Subjects, assignments and study materials', icon: Icons.menu_book_outlined)); }
class ProgressPage extends StatelessWidget { const ProgressPage({super.key}); @override Widget build(BuildContext context) => const _PageScaffold(child: _PlaceholderPage(title: 'My progress', subtitle: 'Learning goals, grades and teacher feedback', icon: Icons.bar_chart_outlined)); }
class ProfilePage extends StatelessWidget { const ProfilePage({super.key}); @override Widget build(BuildContext context) => const _PageScaffold(child: _PlaceholderPage(title: 'My profile', subtitle: 'Personal details, documents and settings', icon: Icons.person_outline)); }
class _PlaceholderPage extends StatelessWidget { const _PlaceholderPage({required this.title, required this.subtitle, required this.icon}); final String title, subtitle; final IconData icon; @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 10), const Text('YOUR SPACE', style: TextStyle(color: blue, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.w800)), const SizedBox(height: 8), Text(title, style: const TextStyle(color: navy, fontSize: 30, fontWeight: FontWeight.w800)), const SizedBox(height: 6), Text(subtitle, style: const TextStyle(color: muted, fontSize: 13)), const SizedBox(height: 25), Container(width: double.infinity, padding: const EdgeInsets.all(25), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE4EDF3))), child: Column(children: [Icon(icon, color: blue, size: 42), const SizedBox(height: 14), Text('$title is ready for your school data.', textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF34546E), fontWeight: FontWeight.w800, fontSize: 15)), const SizedBox(height: 7), const Text('The responsive Flutter foundation is in place for the full role-based experience.', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 12, height: 1.5))]))]); }
