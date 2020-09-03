import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class OwnerChangePetAppBar extends StatefulWidget implements PreferredSizeWidget {
  OwnerChangePetAppBar({Key key, this.actions}) : super(key: key);
  final List<Widget> actions;

  @override
  _OwnerChangePetAppBarState createState() => _OwnerChangePetAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _OwnerChangePetAppBarState extends State<OwnerChangePetAppBar> {
  CurrentPetProvider _currentPetProvider;
  PetService _petService;

  @override
  Widget build(BuildContext context) {
    _currentPetProvider = Provider.of<CurrentPetProvider>(context);
    _petService = Provider.of<PetService>(context);
    List<DropdownMenuItem<Pet>> dropdownMenuItems =
    new List<DropdownMenuItem<Pet>>();
    for (int i = 0; i < _petService.allPets.length; i++) {
      print(_petService.allPets[i].pid);
      dropdownMenuItems.add(
        DropdownMenuItem<Pet>(
            child: Text(
              _petService.allPets[i].name,
              style: StyleConstants.whiteDescriptionText,
            ),
            value: _petService.allPets[i]),
      );
    }

    print(_currentPetProvider.currentPet.pid);
    return AppBar(
      backgroundColor: StyleConstants.blue,
      centerTitle: true,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      /*
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0),
        )
      ),
      */
      title: new Theme(
        child: new DropdownButtonHideUnderline(
          child: new DropdownButton<Pet>(
            iconEnabledColor: Colors.white,
            dropdownColor: StyleConstants.blue,
            value: _currentPetProvider.currentPet,
            items: dropdownMenuItems,
            onChanged: (Pet pet) {
              print(pet.name);
              _currentPetProvider.setCurrentPet(pet);
            },
          ),
        ),
        data: ThemeData.light(),
      ),
      actions: widget.actions,
    );
  }
}