import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'list_mahasiswa.dart';
import 'todo_screen.dart';

class DashboardScreen extends StatefulWidget {
  final User user;
  DashboardScreen({required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      HomeScreen(user: widget.user),
      ListMahasiswa(),
      TodoScreen(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.displayName ?? 'Pengguna'),
              accountEmail: Text(widget.user.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: widget.user.photoURL != null
                    ? NetworkImage(widget.user.photoURL!)
                    : null,
                child: widget.user.photoURL == null ? Icon(Icons.person) : null,
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            Divider(),
            ListTile(
              title: Text('Mahasiswa'),
              leading: Icon(Icons.list),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            Divider(),
            ListTile(
              title: Text('To Do'),
              leading: Icon(Icons.check_box),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Mahasiswa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check_box),
          label: 'To Do',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      ),
    );
  }
}
// class DashboardScreen extends StatelessWidget {
//   final User user;
//   const DashboardScreen({Key? key, required this.user}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => LoginScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome, ${user.displayName ?? 'User'}!',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text('Email: ${user.email ?? 'No email'}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
