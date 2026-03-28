import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AboutLeadFormPage extends StatefulWidget {
  const AboutLeadFormPage({super.key});

  @override
  State<AboutLeadFormPage> createState() => _AboutLeadFormPageState();
}

class _AboutLeadFormPageState extends State<AboutLeadFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController businessController = TextEditingController();

  String? enquiryType;
  String? usingBillingSoftware;
  String? billingRequirement;
  String? planTimeframe;
  String? businessSize;
  String? language;

  final List<String> enquiryOptions = [
    'Product Demo',
    'Pricing',
    'Support',
    'Partnership',
  ];

  final List<String> timeframeOptions = [
    'Immediately',
    'Within 1 month',
    'Within 3 months',
    'Just exploring',
  ];

  final List<String> languageOptions = [
    'English',
    'Hindi',
    'Bengali',
    'Tamil',
    'Telugu',
  ];

  InputDecoration customInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF7C3AED), width: 1.5),
      ),
    );
  }

  Widget sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildRadioGroup({
    required String label,
    required List<String> options,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionLabel(label),
        ...options.map(
          (option) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => onChanged(option),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: groupValue,
                    activeColor: const Color(0xFF7C3AED),
                    onChanged: onChanged,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        option,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Form submitted successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xFF7C3AED),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (usingBillingSoftware == null ||
          billingRequirement == null ||
          businessSize == null ||
          enquiryType == null ||
          planTimeframe == null ||
          language == null) {
        Fluttertoast.showToast(
          msg: "Please fill all required fields.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return;
      }

      showSuccessToast();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    businessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFF4C1D95)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 420 : double.infinity,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'MyBillBook',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF5B21B6),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          sectionLabel("Your Name *"),
                          TextFormField(
                            controller: nameController,
                            decoration:
                                customInputDecoration("Enter your name"),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Your name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          sectionLabel("Mobile Number *"),
                          TextFormField(
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            decoration: customInputDecoration(
                              "Enter your 10-digit mobile number",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Mobile number is required';
                              }
                              if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                                return 'Enter a valid 10-digit mobile number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          sectionLabel("Business Name *"),
                          TextFormField(
                            controller: businessController,
                            decoration: customInputDecoration(
                              "Enter your business name",
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Business name is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          sectionLabel("Nature of your Enquiry *"),
                          DropdownButtonFormField<String>(
                            value: enquiryType,
                            decoration:
                                customInputDecoration("Select enquiry type"),
                            items: enquiryOptions
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                enquiryType = value;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'Please select enquiry type' : null,
                          ),
                          const SizedBox(height: 16),

                          buildRadioGroup(
                            label:
                                "Are you currently using any billing software? *",
                            options: const ['Yes', 'No'],
                            groupValue: usingBillingSoftware,
                            onChanged: (value) {
                              setState(() {
                                usingBillingSoftware = value;
                              });
                            },
                          ),
                          const SizedBox(height: 8),

                          buildRadioGroup(
                            label: "Select your billing requirement *",
                            options: const [
                              'Basic billing on android app',
                              'Billing, Stock keeping, Collections on laptop & app',
                            ],
                            groupValue: billingRequirement,
                            onChanged: (value) {
                              setState(() {
                                billingRequirement = value;
                              });
                            },
                          ),
                          const SizedBox(height: 8),

                          sectionLabel(
                            "When are you planning to get new billing software? *",
                          ),
                          DropdownButtonFormField<String>(
                            value: planTimeframe,
                            decoration:
                                customInputDecoration("Select timeframe"),
                            items: timeframeOptions
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                planTimeframe = value;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'Please select timeframe' : null,
                          ),
                          const SizedBox(height: 16),

                          buildRadioGroup(
                            label: "Size of your business? *",
                            options: const [
                              'More Than 5 crore',
                              '1 crore to 5 crore',
                              '40 lakhs to 1 crore',
                              'Less than 40 lakhs',
                            ],
                            groupValue: businessSize,
                            onChanged: (value) {
                              setState(() {
                                businessSize = value;
                              });
                            },
                          ),
                          const SizedBox(height: 8),

                          sectionLabel("What language do you like to talk in? *"),
                          DropdownButtonFormField<String>(
                            value: language,
                            decoration:
                                customInputDecoration("Select language"),
                            items: languageOptions
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                language = value;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'Please select language' : null,
                          ),
                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF7C3AED), Color(0xFF8B5CF6)],
                                ),
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: handleSubmit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chat, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Chat with us',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}