import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart'
    show
        FilteringTextInputFormatter,
        LengthLimitingTextInputFormatter,
        rootBundle;
import 'package:sizer/sizer.dart';

import '../../../../main_barrel.dart';

String? countryCode;

class CountryPickerWidget extends StatefulWidget {
  final Function(String) onPhoneNumberChanged;

  const CountryPickerWidget({
    super.key,
    required this.onPhoneNumberChanged,
  });

  @override
  State<CountryPickerWidget> createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  final _controller = TextEditingController();
  final _searchController = TextEditingController();
  Country? selectedCountry;
  List<Country> countries = [];
  List<Country> filteredCountries = [];

  Future<List<dynamic>> loadCountries() async {
    String data = await rootBundle.loadString('assets/countries.json');
    return json.decode(data);
  }

  Future<List<Country>> loadCountriesFromFile() async {
    List<dynamic> jsonList = await loadCountries();
    return jsonList.map((json) => Country.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadCountriesFromFile().then((value) {
        setState(() {
          countries = value;
          filteredCountries = countries;

          selectedCountry =
              countries.firstWhere((country) => country.dialCode == "+964");
          countryCode = selectedCountry?.dialCode;
        });
      });
      _searchController.addListener(_filterCountries);
    });
  }

  void _filterCountries() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      filteredCountries = countries
          .where((country) =>
              country.name.toLowerCase().contains(searchText) ||
              country.dialCode.contains(searchText))
          .toList();
    });
  }

  void showCountryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectCountry.tr()),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: search.tr(),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setStateDialog(() {
                        filteredCountries = countries
                            .where((country) =>
                                country.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                country.dialCode.contains(value))
                            .toList();
                      });
                    },
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                height: 400,
                child: filteredCountries.isNotEmpty
                    ? ListView.builder(
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          Country country = filteredCountries[index];
                          return ListTile(
                            leading: Image.asset(country.flag, width: 30),
                            title: Text(country.name),
                            subtitle: Text(country.dialCode),
                            onTap: () {
                              setState(() {
                                selectedCountry = country;
                                _controller.clear();
                                countryCode = country.dialCode;

                                // _controller.text = '${country.dialCode} ';
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      )
                    : Center(
                        child: Text(noCountriesFound.tr()),
                      ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          phone.tr(),
          style: CustomFontStyle.regularText.copyWith(fontSize: 13),
        ),
        SizedBox(height: 0.8.h),
        Container(
          decoration: BoxDecoration(
            color: Palette.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showCountryDialog();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Row(
                    children: [
                      selectedCountry != null
                          ? Image.asset(selectedCountry!.flag, width: 22)
                          : const Icon(Icons.flag),
                      const SizedBox(width: 8),
                      Text(
                        selectedCountry?.dialCode ?? "+964",
                        style: CustomFontStyle.regularText,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    widget.onPhoneNumberChanged(value);
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(
                      selectedCountry?.dialMaxLength,
                    ),
                  ],
                  style: CustomFontStyle.regularText,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    hintText: phoneNumber.tr(),
                    hintStyle: CustomFontStyle.regularText
                        .copyWith(color: Palette.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Country {
  final String dialCode;
  final String name;
  final String code;
  final String flag;
  final int dialMinLength;
  final int dialMaxLength;

  Country({
    required this.dialCode,
    required this.name,
    required this.code,
    required this.flag,
    required this.dialMinLength,
    required this.dialMaxLength,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      dialCode: json['dial_code'],
      name: json['name'],
      code: json['code'],
      flag: json['flag'],
      dialMinLength: json['dial_min_length'],
      dialMaxLength: json['dial_max_length'],
    );
  }
}
