import 'package:flutter/material.dart';
import 'package:hrroadways/colors.dart';
import 'package:hrroadways/models/bus_route_model.dart';
class BusRouteCard extends StatelessWidget {
  final BusRoute route;

  const BusRouteCard({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.light, // Light background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.temp.withValues(alpha: 0.1), // Soft shadow
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Route Name & Bus Stand**
          Text(
            route.routeName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.dark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            route.busStandName,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.dark.withOpacity(0.7),
            ),
          ),

          const Divider(thickness: 1, height: 16),

          /// **Route Details (From → Via → To)**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// **From**
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.temp.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    route.from,
                    style: TextStyle(fontSize: 16, color: AppColors.dark),
                  ),
                ],
              ),

              /// **Via (if exists)**
              if (route.via.isNotEmpty && route.via != "Unknown")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Via:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.temp.withOpacity(0.8),
                      ),
                    ),
                    Text(
                      route.via,
                      style: TextStyle(fontSize: 16, color: AppColors.dark),
                    ),
                  ],
                ),

              /// **To**
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "To:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.temp.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    route.to,
                    style: TextStyle(fontSize: 16, color: AppColors.dark),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// **Departure Time**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Departure:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.temp.withOpacity(0.8),
                ),
              ),
              Text(
                route.departureTime,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.dark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
