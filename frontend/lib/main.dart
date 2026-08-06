import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/downloader_screen.dart';
import 'screens/upscaler_screen.dart';
import 'screens/background_screen.dart';

void main() {
  runApp(const MyToolsApp());
}

class MyToolsApp extends StatelessWidget {
  const MyToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyTools',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}

/// Root scaffold containing the BottomNavigationBar and page body.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(
        onToolTap: (index) => setState(() => _currentIndex = index),
      ),
      const DownloaderScreen(),
      const UpscalerScreen(),
      const BackgroundScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Use different app bar styles for Home vs. tool screens.
    final isHome = _currentIndex == 0;

    return Scaffold(
      appBar: AppBar(
        leading: isHome
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: AppSpacing.md),
                child: Icon(
                  Icons.apps,
                  color: AppColors.onSurfaceVariant,
                  size: 22,
                ),
              ),
        title: Text(
          'MyTools',
          style: AppTypography.headlineSm.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: !isHome,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: open settings
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download_outlined),
              activeIcon: Icon(Icons.download),
              label: 'Downloader',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_size_select_large_outlined),
              activeIcon: Icon(Icons.photo_size_select_large),
              label: 'Upscaler',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_fix_high_outlined),
              activeIcon: Icon(Icons.auto_fix_high),
              label: 'Background',
            ),
          ],
        ),
      ),
    );
  }
}
