import 'package:flutter/material.dart';
import '../animations/combined_animation.dart';
import '../animations/explecit_animation.dart';
import '../animations/implicit_animation.dart';
import '../animations/animation_controller_tween.dart';
import '../animations/tween_sequence.dart';
import '../animations/staggered.dart';
import '../animations/transitions.dart';
import '../animations/animated_widget.dart';
import '../animations/custom_painter_anim.dart';
import '../animations/hero_custom.dart';
import '../animations/page_route_builder.dart';
import '../animations/transform_examples.dart';
import '../animations/animated_list.dart';
import '../animations/physics_animation.dart';
import '../animations/custom_shapes.dart';
import '../states/GetX state/getX_example1.dart';
import '../states/inherited_widget_state/inherited_widget.dart';
import '../states/providerState/provider_example1.dart';
import '../states/set_state.dart';

// ---------------- LOGIN SCREEN ----------------
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // List of animation examples
  final List<Map<String, dynamic>> animationExamples = [
    {"title": "AnimationController + Tween", "screen": ACExample(), "color": Colors.blue, "icon": Icons.play_arrow},
    {"title": "TweenSequence", "screen": TweenSequenceExample(), "color": Colors.green, "icon": Icons.timeline},
    {"title": "Staggered Animations", "screen": StaggeredExample(), "color": Colors.purple, "icon": Icons.animation},
    {"title": "Transition Widgets", "screen": TransitionsExample(), "color": Colors.orange, "icon": Icons.swap_horiz},
    {"title": "AnimatedWidget", "screen": AnimatedWidgetExample(), "color": Colors.red, "icon": Icons.widgets},
    {"title": "CustomPainter Animation", "screen": CustomPainterAnim(), "color": Colors.teal, "icon": Icons.brush},
    {"title": "Hero Animation", "screen": HeroList(), "color": Colors.pink, "icon": Icons.flight},
    {"title": "PageRouteBuilder", "screen": First(), "color": Colors.indigo, "icon": Icons.pages},
    {"title": "Transform Examples", "screen": TransformExamples(), "color": Colors.amber, "icon": Icons.transform},
    {"title": "AnimatedList", "screen": AnimatedListDemo(), "color": Colors.cyan, "icon": Icons.list},
    {"title": "Physics Animation", "screen": PhysicsExample(), "color": Colors.deepPurple, "icon": Icons.sports_soccer},
    {"title": "Custom Shapes", "screen": CustomShapes(), "color": Colors.lime, "icon": Icons.shape_line},
    {"title": "Implicit Animation", "screen": AnimatedContainerExample(), "color": Colors.lightGreen, "icon": Icons.auto_awesome},
    {"title": "Explicit Animation", "screen": ExplicitAnimationExample(), "color": Colors.deepOrange, "icon": Icons.settings},
    {"title": "Combined Animation", "screen": CombinedAnimationExample(), "color": Colors.brown, "icon": Icons.blur_on},
  ];

  // List of state management examples
  final List<Map<String, dynamic>> stateManagers = [
    {"title": "Bloc", "route": "/bloc", "color": Colors.redAccent, "icon": Icons.block},
    {"title": "GetX", "screen": getXStateScreen(), "color": Colors.yellowAccent, "icon": Icons.speed},
    {"title": "Provider", "screen": ProviderExample1(), "color": Colors.purpleAccent, "icon": Icons.production_quantity_limits},
    {"title": "Inherited Widget", "screen": InheritedWidgetScreen(), "color": Colors.deepOrangeAccent, "icon": Icons.account_tree},
    {"title": "SetState", "screen": SetStateScreen(), "color": Colors.black, "icon": Icons.refresh},
    {"title": "Riverpod", "screen": SetStateScreen(), "color": Colors.greenAccent, "icon": Icons.water_drop},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Examples Hub"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.login), text: "Login"),
            Tab(icon: Icon(Icons.animation), text: "Animations"),
            Tab(icon: Icon(Icons.settings), text: "State Management"),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade700,
              Colors.cyanAccent,
              Colors.blue.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            // Login Tab
            _buildLoginTab(),
            // Animations Tab
            _buildAnimationsTab(),
            // State Management Tab
            _buildStateManagementTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginTab() {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome Back!",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 30),

          // Email TextField
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.email),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Password TextField
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.lock),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Login Button
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Successful!")),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/signup'),
            child: const Text(
              "Don't have an account? Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Flutter Animation Examples",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: animationExamples.length,
              itemBuilder: (context, index) {
                final item = animationExamples[index];
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item["screen"]),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [item["color"], item["color"].withOpacity(0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item["icon"], size: 40, color: Colors.white),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              item["title"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStateManagementTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "State Management Examples",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: stateManagers.length,
              itemBuilder: (context, index) {
                final item = stateManagers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      onTap: () {
                        if (item.containsKey("route")) {
                          Navigator.pushNamed(context, item["route"]);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => item["screen"]),
                          );
                        }
                      },
                      leading: CircleAvatar(
                        backgroundColor: item["color"],
                        child: Icon(item["icon"], color: Colors.white),
                      ),
                      title: Text(
                        item["title"],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
