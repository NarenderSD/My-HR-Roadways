import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrroadways/colors.dart';
import 'package:hrroadways/models/bus_route_model.dart';
import 'package:hrroadways/widgets/bus_route_card.dart';
import 'package:provider/provider.dart';
import 'package:hrroadways/providers/routes_search_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController from;
  late TextEditingController to;

  @override
  void initState() {
    super.initState();
    from = TextEditingController();
    to = TextEditingController();
  }

  @override
  void dispose() {
    from.dispose();
    to.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          backgroundColor: AppColors.background,
          title: Text("HR - Roadways"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// search container
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.dark,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From",
                          style: TextStyle(
                            color: AppColors.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: from,
                            decoration: InputDecoration(
                              hintText: "From",
                              fillColor: AppColors.background,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "To",
                          style: TextStyle(
                            color: AppColors.background,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: to,
                            decoration: InputDecoration(
                              hintText: "To",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<RoutesSearchProvider>().searchRoutes(
                                from.text.trim(),
                                to.text.trim(),
                              );
                            },
                            child: const Text("Search"),
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  Positioned(
                    left: -12,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(color: AppColors.background,shape: BoxShape.circle),
                    ),
                  ),
      
                  Positioned(
                    right: -12,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(color: AppColors.background,shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
      
              const SizedBox(height: 16),
      
              Expanded(
                child: Consumer<RoutesSearchProvider>(
                  builder: (context, routesProvider, child) {
                    if (routesProvider.isLoading) {
                      return const Center(child: CupertinoActivityIndicator());
                    }
      
                    if (routesProvider.searchResult.isEmpty) {
                      return const Center(child: Text("No routes found"));
                    }
      
                    return ListView.builder(
                      itemCount: routesProvider.searchResult.length,
                      itemBuilder: (context, index) {
                        final BusRoute route = routesProvider.searchResult[index];
                        return BusRouteCard(route: route);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
