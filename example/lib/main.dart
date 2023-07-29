import 'package:flutter/material.dart';
import 'package:swipe_to_complete/swipe_to_complete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Swipe Action Demo'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Swipe Action Widget offers two types of Call to Actions',
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SeabornSunrisePage(),
              ),
            ),
            child: const Text('Horizontal CTA'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const EasternSunrisePage(),
              ),
            ),
            child: const Text('Vertical CTA'),
          ),
        ],
      ),
    );
  }
}

class EasternSunrisePage extends StatefulWidget {
  const EasternSunrisePage({super.key});

  @override
  State<EasternSunrisePage> createState() => _EasternSunrisePageState();
}

class _EasternSunrisePageState extends State<EasternSunrisePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _opacity = Tween<double>(begin: 0, end: 0.65).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(42),
                      ),
                    ),
                    child: Image.asset(
                      'assets/balloon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(42),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Eastern Sunrise Experience',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              '21 July 2023, 09:00 hrs',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Builder(
                builder: (context) {
                  return NewSwiper(
                    type: SwiperType.vertical,
                    callback: () => showBottomSheet(
                      context: context,
                      builder: (context) {
                        return BottomSheetContent(
                          controller: _controller,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 500,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 100],
                    colors: [
                      Colors.black.withOpacity(_opacity.value),
                      Colors.transparent
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeabornSunrisePage extends StatefulWidget {
  const SeabornSunrisePage({super.key});

  @override
  State<SeabornSunrisePage> createState() => _SeabornSunrisePageState();
}

class _SeabornSunrisePageState extends State<SeabornSunrisePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _opacity = Tween<double>(begin: 0, end: 0.65).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(42),
                        ),
                      ),
                      child: Image.asset('assets/ocean.png'),
                    ),
                    const Positioned(
                      left: 24,
                      bottom: 36,
                      child: Text(
                        'Seaborn Sunrise Cruise',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const DetailsRow(
                    dkey: 'Boarding', value: '21 July 2023, 09:00hrs'),
                const DetailsRow(dkey: 'Nos.', value: '2 PAX'),
                const DetailsRow(dkey: 'Seats', value: 'EA22, EA23'),
                const SizedBox(height: 12),
                Builder(builder: (context) {
                  return NewSwiper(
                    callback: () => showBottomSheet(
                      context: context,
                      builder: (context) {
                        return BottomSheetContent(
                          controller: _controller,
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(
            height: 650,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 100],
                    colors: [
                      Colors.black.withOpacity(_opacity.value),
                      Colors.transparent
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key, required this.controller});

  final AnimationController controller;

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  void initState() {
    super.initState();

    widget.controller.forward();
  }

  @override
  void dispose() {
    widget.controller.reverse();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: const Center(
        child: Icon(
          Icons.check_circle,
          color: Colors.black,
        ),
      ),
    );
  }
}

class DetailsRow extends StatelessWidget {
  const DetailsRow({super.key, required this.dkey, required this.value});

  final String dkey;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            dkey,
            style: detailsFontStyle,
          ),
          Text(
            value,
            style: detailsFontStyle.copyWith(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

const detailsFontStyle = TextStyle(
  color: Color(0xff373737),
  fontSize: 16,
  fontWeight: FontWeight.w300,
);
