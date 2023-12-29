import 'package:flutter/material.dart';
import 'package:rakashkh/utils/Data.dart';
class serviceDetail extends StatefulWidget {
  const serviceDetail({super.key});

  @override
  State<serviceDetail> createState() => _serviceDetailState();
}

class _serviceDetailState extends State<serviceDetail> {
  String selectedCity = 'All';
  String selectedOrganization = 'All';

  List<String> cities = ['All', 'Los Angeles', 'New York City', 'Dallas'];
  List<String> organizations = [
    'All',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                  isExpanded: false,
                  value: selectedCity,
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;
                    });
                  },
                  items: Service_data().indianStates.map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                flex: 1,
                child: DropdownButton<String>(
                  isExpanded: false,
                  value: selectedOrganization,
                  onChanged: (value) {
                    setState(() {
                      selectedOrganization = value!;
                    });
                  },
                  items: organizations.map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                ),
              ),

              // Expanded(
              //   flex: 1,
              //   child: DropdownButton<String>(
              //     isExpanded: false,
              //     value: selectedOrganization,
              //     onChanged: (value) {
              //       setState(() {
              //         selectedOrganization = value!;
              //       });
              //     },
              //     items: organizations.map((organization) {
              //       return DropdownMenuItem(
              //         value: organization,
              //         child: Text(organization),
              //       );
              //     }).toList(),
              //   ),
              // ),
            ],
          ),
          // ListView.builder(
          //   itemCount: 5,
          //   itemBuilder: (context, index) {
          //     return ListTile();
          //   },
          // )
        ],
      ),
    );
  }
}
