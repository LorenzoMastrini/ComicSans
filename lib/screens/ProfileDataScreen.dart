import 'package:flutter/material.dart';
import '../Components/ComicSansButton.dart';
import '../GlobalConstants.dart';
import '../components/ComicSansAppBar.dart';
import '../components/ComicSansRadioButtons.dart';
import '../components/ComicSansTextInput.dart';
import '../user.dart';

class ProfileDataScreen extends StatefulWidget{
  User user;
  ProfileDataScreen({super.key, required this.user});

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}

class _ProfileDataScreenState extends State<ProfileDataScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;
  late TextEditingController _birthdayController;
  Gender? selectedGender;

  List<String> getAllGenderLabels(){
    return Gender.values.map((gender) => gender.label).toList();
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _genderController = TextEditingController(text: widget.user.gend?.label ?? '');
    _birthdayController = TextEditingController(text: widget.user.birthday);

    selectedGender = widget.user.gend;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    void updateProfileData(){
      widget.user.name = _nameController.text;
      widget.user.lastName = _lastNameController.text;
      widget.user.gend = selectedGender;
      widget.user.birthday = _birthdayController.text;

      Navigator.pop(context, true);
    }

    return Scaffold(
      appBar: ComicSansAppBar(
        title: "Dati profilo",
        showBackButton: true,
        backgroundColor: Colors.transparent,
      ),
      body:
      Form (
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: GestureDetector(
                    onTap: (){},
                    child: Icon(Icons.account_circle, color: Colors.black, size: 100)
                  )
              ),
              ComicSansTextInput(
                title: 'Nome',
                controller: _nameController,
              ),
              const SizedBox(height: 10),

              ComicSansTextInput(
                title: 'Cognome',
                controller: _lastNameController,
              ),
              const SizedBox(height: 10),

              Text("Sesso", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListTile(
                  title: Text("Maschio", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  leading: Radio<Gender>(
                      value: Gender.Maschio,
                      groupValue: selectedGender,
                      onChanged: (Gender? value) {
                        setState(() {
                          selectedGender = value;
                          _genderController.text = value?.label ?? '';
                        });
                      }
                  )
              ),
              ListTile(
                title: Text("Femmina", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                leading: Radio<Gender>(
                    value: Gender.Femmina,
                    groupValue: selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        selectedGender = value;
                        _genderController.text = value?.label ?? '';
                      });
                    }
                ),
              ),
              ListTile(
                title: Text("Altro", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                leading: Radio<Gender>(
                    value: Gender.Altro,
                    groupValue: selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        selectedGender = value;
                        _genderController.text = value?.label ?? '';
                      });
                    }
                ),
              ),
              const SizedBox(height: 10),

              ComicSansTextInput(
                title: 'Data di nascita',
                controller: _birthdayController,
              ),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ComicSansButton (
                  text: 'Conferma',
                  onPressed: updateProfileData,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}