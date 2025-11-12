import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'getX_controller.dart'; // keep your existing controllers here

// ----------------- Translations -----------------
class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'app_title': 'GetX Demo',
      'hello': 'Hello!',
      'show_snack': 'Show Snackbar',
      'show_dialog': 'Show Dialog',
      'show_sheet': 'Show Bottom Sheet',
      'change_theme': 'Toggle Theme',
      'to_urdu': 'Switch to Urdu',
      'to_english': 'Switch to English',
      'deleted': 'Deleted',
      'delete_success': 'Item deleted successfully',
      'bottom_text': 'This is a bottom sheet',
      'close': 'Close',
      'dark_on': 'Dark mode is ON',
      'dark_off': 'Dark mode is OFF',
    },
    'ur_PK': {
      'app_title': 'GetX ڈیمو',
      'hello': 'سلام!',
      'show_snack': 'سناک بار دکھائیں',
      'show_dialog': 'ڈائیلاگ دکھائیں',
      'show_sheet': 'بوٹم شیٹ دکھائیں',
      'change_theme': 'تھیم تبدیل کریں',
      'to_urdu': 'اردو پر جائیں',
      'to_english': 'انگریزی پر جائیں',
      'deleted': 'حذف ہوگیا',
      'delete_success': 'آئٹم کامیابی سے حذف ہوگیا',
      'bottom_text': 'یہ بوٹم شیٹ ہے',
      'close': 'بند کریں',
      'dark_on': 'ڈارک موڈ فعال ہے',
      'dark_off': 'ڈارک موڈ بند ہے',
    },
  };
}

// ----------------- App Entry -----------------
class getXStateScreen extends StatelessWidget {
  const getXStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Demo',
      debugShowCheckedModeBanner: false,
      translations: MyTranslations(), // add translations here
      locale: Locale('en', 'US'), // starting locale
      fallbackLocale: Locale('en', 'US'),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // keep your existing controllers (registers them)
  final CounterController c = Get.put(CounterController()); // register
  final sc = Get.put(SimpleController());

  @override
  Widget build(BuildContext context) {
    // reactive check for theme — Get.isDarkMode reads current theme state
    final isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(title: Text('app_title'.tr), backgroundColor: Colors.blue),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 12),

            // simple greeting (translated)
            Text('hello'.tr, style: TextStyle(fontSize: 24)),

            SizedBox(height: 18),

            // Show SimpleController count via GetBuilder
            GetBuilder<SimpleController>(
              builder: (controller) => Text(
                'Count for method B: ${controller.count}',
                style: TextStyle(fontSize: 20),
              ),
            ),

            SizedBox(height: 8),

            // FloatingActionButton-like button for SimpleController (kept inline)
            ElevatedButton.icon(
              onPressed: sc.increment,
              icon: Icon(Icons.add),
              label: Text('Increment B'),
            ),

            SizedBox(height: 20),

            // Snackbar button (uses translation)
            ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  'hello'.tr, // title translated
                  'This is a snackbar', // message (you can also translate)
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 2),
                );
              },
              child: Text('show_snack'.tr),
            ),

            SizedBox(height: 12),

            // Dialog button (inline onConfirm uses snackbar to show action)
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Delete?",
                  middleText: "Are you sure you want to delete this?",
                  textConfirm: "Yes",
                  textCancel: "No",
                  onConfirm: () {
                    // action on confirm — show translated snackbar
                    Get.back(); // close the dialog
                    Get.snackbar('deleted'.tr, 'delete_success'.tr);
                  },
                  onCancel: () {},
                );
              },
              child: Text('show_dialog'.tr),
            ),

            SizedBox(height: 12),

            // Bottom sheet button
            ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                  Container(
                    // make sure sheet respects theme (white for light, grey for dark)
                    color: Get.isDarkMode ? Colors.grey[900] : Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('bottom_text'.tr, style: TextStyle(fontSize: 16)),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          child: Text('close'.tr),
                        ),
                      ],
                    ),
                  ),
                  isScrollControlled: false,
                );
              },
              child: Text('show_sheet'.tr),
            ),

            SizedBox(height: 18),

            // Theme toggle (inline)
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(isDark ? 'dark_on'.tr : 'dark_off'.tr),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        if (Get.isDarkMode) {
                          Get.changeTheme(ThemeData.light());
                          Get.snackbar('Theme', 'Switched to Light Theme');
                        } else {
                          Get.changeTheme(ThemeData.dark());
                          Get.snackbar('Theme', 'Switched to Dark Theme');
                        }
                      },
                      child: Text('change_theme'.tr),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 12),

            // Language switch buttons (inline)
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text('change_lang'.tr),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.updateLocale(Locale('ur', 'PK'));
                            Get.snackbar('Info', 'Language switched to Urdu');
                          },
                          child: Text('to_urdu'.tr),
                        ),
                        SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            Get.updateLocale(Locale('en', 'US'));
                            Get.snackbar(
                              'Info',
                              'Language switched to English',
                            );
                          },
                          child: Text('to_english'.tr),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Reactive counter from CounterController (Obx)
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Obx(
                () => Text(
                  'Clicks: ${c.count.value}',
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ),
          ],
        ),
      ),

      // FloatingActionButton for main counter
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
