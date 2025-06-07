import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speedometer/pages/about.dart';
import 'package:speedometer/pages/settings.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  static String path = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double maxSpeed = 0;
  bool locationIsEnabled = false;
  LocationPermission? permission;

  Future<void> checkLocation() async {
    locationIsEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationIsEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      setState(() {});
    }
  }

  Widget getLocationWidget() {
    return StreamBuilder(
      stream: Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.best,
              distanceFilter: 0
          )
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator()
          );
        }

        final double mps = snapshot.data!.speed;
        final double kph = mps * 60 * 60 / 1000;
        if (kph > maxSpeed) {
          maxSpeed = kph;
        }

        final Brightness brightness = Theme
            .of(context)
            .brightness;

        final Widget gauge = SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 120,
              axisLineStyle: AxisLineStyle(
                  color: brightness == Brightness.light ? Colors.black : Colors
                      .white),
              axisLabelStyle: GaugeTextStyle(
                  color: brightness == Brightness.light ? Colors.black : Colors
                      .white),
              ranges: [
                GaugeRange(startValue: 0,
                    endValue: 50,
                    color: Colors.green,
                    startWidth: 10,
                    endWidth: 10),
                GaugeRange(startValue: 50,
                    endValue: 100,
                    color: Colors.orange,
                    startWidth: 10,
                    endWidth: 10),
                GaugeRange(startValue: 100,
                    endValue: 120,
                    color: Colors.red,
                    startWidth: 10,
                    endWidth: 10)
              ],
              pointers: [
                NeedlePointer(
                    value: kph, lengthUnit: GaugeSizeUnit.factor,
                    needleLength: 0.75, needleColor: Colors.red),
                MarkerPointer(value: maxSpeed,
                    enableDragging: false,
                    markerOffset: -15,
                    color: Colors.indigo)
              ],
              annotations: [
                GaugeAnnotation(
                    widget: Text(
                        '${kph.toStringAsFixed(2)} Km/h',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold
                        )
                    ),
                    angle: 90, positionFactor: 0.5
                )
              ],
            ),
          ],
        );

        final List<Widget> items = [
          ListTile(
            title: const Text('Maximum speed'),
            subtitle: Text('${maxSpeed.toStringAsFixed(2)} Km/h'),
            leading: const Icon(Icons.speed),
          ),
          ListTile(
            title: const Text('Altitude'),
            subtitle: Text('${snapshot.data!.altitude.toStringAsFixed(2)} Mts'),
            leading: const Icon(Icons.height),
          ),
          ListTile(
            title: const Text('Location'),
            subtitle: Text(
                '${snapshot.data!.latitude} ${snapshot.data!.longitude}'),
            leading: const Icon(Icons.location_pin),
            onTap: () async {
              final Uri uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${snapshot.data!.latitude},${snapshot.data!.longitude}');
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
          )
        ];

        return OrientationBuilder(
            builder: (context, orientation) {
              if (orientation == Orientation.portrait) {
                return Column(
                    children: [
                      Flexible(child: gauge),
                      ...items
                    ]
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(child: gauge),
                    Flexible(child: Column(
                        children: items
                    ))
                  ],
                );
              }
            }
        );
      },
    );
  }

  @override
  void initState() {
    checkLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) =>
              [
                const PopupMenuItem(
                    value: 0,
                    child: Text('About')
                ),
                const PopupMenuItem(
                    value: 1,
                    child: Text('Settings')
                ),
              ],
              onSelected: (int value) async {
                if (value == 0) {
                  Navigator.pushNamed(context, AboutPage.path);
                } else if (value == 1) {
                  Navigator.pushNamed(context, SettingsPage.path);
                }
              },
            )
          ],
        ),
        body: !locationIsEnabled ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Location service isn\'t enabled'),
              ElevatedButton(
                  onPressed: checkLocation, child: const Text('Retry'))
            ],
          ),
        ) : permission == LocationPermission.denied ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Location permission isn\'t granted'),
              ElevatedButton(
                  onPressed: checkLocation, child: const Text('Retry'))
            ],
          ),
        ) : permission == LocationPermission.deniedForever ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Location permission is denied forever'),
              ElevatedButton(
                  onPressed: checkLocation, child: const Text('Retry'))
            ],
          ),
        ) : getLocationWidget()
    );
  }
}
