import 'package:flutter/material.dart';
import 'about_lead_form_page.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainNavigationPage(),
    );
  }
}

/// Main page that controls bottom navigation.
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    AboutLeadFormPage(),
    ProfilePage(),
    HelpPage(),
  ];

  final List<String> _titles = const [
    "Home Page",
    "About Page",
    "Profile Page",
    "Help Page",
  ];

  final List<Color> _appBarColors = const [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: _appBarColors[_selectedIndex],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "About",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: "Help",
          ),
        ],
      ),
    );
  }
}

/// Home page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Welcome to Home Page",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// About page
// class AboutLeadFormPage extends StatelessWidget {
//   const AboutLeadFormPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         "This is the About Page",
//         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

/// Profile page with form and photo
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /// Form key for managing form state
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      debugPrint("Name: ${_nameController.text}");
      debugPrint("Email: ${_emailController.text}");
      debugPrint("Phone: ${_phoneController.text}");
      debugPrint("Bio: ${_bioController.text}");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile submitted successfully"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// Profile photo
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?img=12',
              ),
            ),

            const SizedBox(height: 12),

            TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Change photo clicked")),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text("Change Photo"),
            ),

            const SizedBox(height: 20),

            /// Name field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            /// Email field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your email";
                }
                if (!value.contains('@')) {
                  return "Please enter a valid email";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            /// Phone field
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your phone number";
                }
                if (value.length < 10) {
                  return "Phone number must be at least 10 digits";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            /// Bio field
            TextFormField(
              controller: _bioController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Bio",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.info_outline),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your bio";
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Submit Profile",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Help page
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "This is the Help Page",
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}