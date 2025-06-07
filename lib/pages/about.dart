import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatefulWidget {
  static String path = '/about';

  const AboutPage({super.key});

  @override
  State<StatefulWidget> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  PackageInfo? packageInfo;
  final Color transparentColor = Colors.white54;
  final mainCardHeight = 300;

  @override
  void initState() {
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        packageInfo = value;
      });
    });

    super.initState();
  }

  Widget getMainCard() => Card(
    color: transparentColor,
    clipBehavior: Clip.antiAlias,
    child: SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: mainCardHeight/2,
                width: double.infinity,
                child: ClipRect(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('assets/wallpaper.jpg'),
                  ),
                ),
              ),
              SizedBox(
                height: mainCardHeight/2,
              )
            ],
          ),
          Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 5,
                      child: Image.asset('assets/launcher.png'),
                    ),
                    Text(
                      '${packageInfo!.appName} (${packageInfo!.version})',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    const Text('By Danny Vaca', style: TextStyle(color: Colors.black))
                  ],
                ),
              )
          ),
          Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: TextButton(
                          child: const Text('See more', style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            final Uri uri = Uri.parse('https://play.google.com/store/apps/dev?id=8503747791924376106');
                            launchUrl(uri);
                          },
                        )
                    ),
                    Expanded(
                        child: TextButton(
                          child: const Text('Rate it', style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            LaunchReview.launch(androidAppId: packageInfo!.packageName);
                          },
                        )
                    )
                  ],
                ),
              )
          )
        ],
      ),
    ),
  );

  List<Widget> getSecondaryCards() => [
    getSocialCard(
        title: 'Github',
        image: 'assets/github.png',
        url: 'https://www.github.com/danny270793/'
    ),
    getSocialCard(
        title: 'YouTube',
        image: 'assets/youtube.png',
        url: 'https://www.youtube.com/channel/UC5MAQWU2s2VESTXaUo-ysgg'
    ),
    getSocialCard(
        title: 'LinkedIn',
        image: 'assets/linkedin.png',
        url: 'https://www.linkedin.com/in/danny270793'
    ),
    getSocialCard(
        title: 'Web',
        image: 'assets/web.png',
        url: 'https://danny270793.github.io/#/'
    ),
  ];

  Widget getBody() => MediaQuery.of(context).orientation == Orientation.portrait ? SingleChildScrollView(
    child: Column(
      children: [
        getMainCard(),
        ...getSecondaryCards(),
      ],
    ),
  ) : Row(
    children: [
      Expanded(
        child: getMainCard(),
      ),
      Expanded(
          child: SingleChildScrollView(
            child: Column(
                children: getSecondaryCards()
            ),
          )
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/about-wallpaper.png'),
                fit: BoxFit.cover
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: packageInfo == null ? const Center(child: CircularProgressIndicator()) : getBody(),
        )
      ],
    );
  }

  Widget getSocialCard({
    required String image,
    required String title,
    required String url,
  }) => Card(
    color: transparentColor,
    clipBehavior: Clip.antiAlias,
    child: ListTile(
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
      leading: Image.asset(image),
      title: Center(child: Text(title, style: const TextStyle(color: Colors.black))),
      onTap: () => launchUrlString(url),
    ),
  );
}
