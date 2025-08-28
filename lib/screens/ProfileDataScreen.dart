import 'package:comicsans/global_constants.dart';
import 'package:comicsans/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:comicsans/components/ComicSansButton.dart';
import 'package:comicsans/components/ComicSansAppBar.dart';
import 'package:comicsans/components/ComicSansTextInput.dart';
import 'package:comicsans/user.dart';
import 'package:provider/provider.dart';



class ProfileDataScreen extends StatefulWidget{
  const ProfileDataScreen({super.key});

  @override
  State<ProfileDataScreen> createState() => _ProfileDataScreenState();
}



class _ProfileDataScreenState extends State<ProfileDataScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;
  late TextEditingController _birthdayController;
  late TextEditingController _usernameController;
  late Gender? selectedGender;

  List<String> getAllGenderLabels(){
    return Gender.values.map((gender) => gender.label).toList();
  }

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _genderController = TextEditingController();
    _birthdayController = TextEditingController();
    _usernameController = TextEditingController();
    selectedGender = Gender.maschio;

    // Safe access to provider without triggering rebuilds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      setState(() {
        _nameController = TextEditingController(text: userProvider.loggedInUser!.name);
        _lastNameController = TextEditingController(text: userProvider.loggedInUser!.lastName);
        _genderController = TextEditingController(text: userProvider.loggedInUser!.gender?.label ?? '');
        _birthdayController = TextEditingController(text: userProvider.loggedInUser!.birthday);
        _usernameController = TextEditingController(text: userProvider.loggedInUser!.username);
        selectedGender = userProvider.loggedInUser!.gender;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _birthdayController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final userProviderRead = context.read<UserProvider>();

    void updateProfileData(){
      userProviderRead.loggedInUser!.name = _nameController.text;
      userProviderRead.loggedInUser!.lastName = _lastNameController.text;
      userProviderRead.loggedInUser!.gender = selectedGender;
      userProviderRead.loggedInUser!.birthday = _birthdayController.text;
      userProviderRead.loggedInUser!.username = _usernameController.text;
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
        key: formKey,
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

              ComicSansTextInput(
                title: 'Username',
                controller: _usernameController,
              ),
              const SizedBox(height: 10),

              Text("Sesso", style: Theme.of(context).textTheme.labelMedium),
              ListTile(
                title: Text("Maschio", style: Theme.of(context).textTheme.headlineMedium),
                leading: Radio<Gender>(
                  value: Gender.maschio,
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
                title: Text("Femmina", style: Theme.of(context).textTheme.headlineMedium),
                leading: Radio<Gender>(
                  value: Gender.femmina,
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
                  value: Gender.altro,
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