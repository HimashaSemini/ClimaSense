import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alert_provider.dart';
import '../weather/business/providers/weather_provider.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    /// Load smart alerts
    Provider.of<AlertProvider>(context, listen: false)
        .loadSmartAlerts(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Weather Alerts"),
      ),

      /// --------------------------
      /// BODY (Column)
      /// --------------------------
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg2.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
        children: [
          /// ALERT LIST
          Expanded(
            child: Consumer<AlertProvider>(
              builder: (context, provider, child) {
                if (provider.alerts.isEmpty) {
                  return const Center(
                    child: Text(
                      "No alerts for now...😊",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.alerts.length,
                  itemBuilder: (context, index) {
                    final alert = provider.alerts[index];

                    return Card(
                      color: const Color.fromARGB(108, 3, 22, 43),
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListTile(
                        leading: Icon(alert.icon,
                            color: alert.color, size: 32),
                        title: Text(
                          alert.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: alert.color,
                          ),
                        ),
                        subtitle: Text(alert.message,
                            style: const TextStyle(color: Colors.white)
                        ),


                      ),
                    );
                  },
                );
              },
            ),
          ),

          /// --------------------------
          /// BOTTOM IMAGE
          /// --------------------------
          Padding(
            padding: const EdgeInsets.only(),
            child: Image.asset(
              "assets/images/alert_bg.png",
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),   
      ),
    );
  }
}
