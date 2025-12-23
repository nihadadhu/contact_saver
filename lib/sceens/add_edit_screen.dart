import 'dart:io';
import 'package:contact_saver/model/contact_model.dart';
import 'package:contact_saver/provider/contact_form_provider.dart';

import 'package:contact_saver/provider/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AddEditScreen extends StatefulWidget {
  final ContactModel? contact;
  const AddEditScreen({super.key, this.contact});
  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  File? selectedImage;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final form = context.read<ContactFormProvider>();

      if (widget.contact != null) {
        form.loadContact(widget.contact!);
        context.read<ImagePickerProvider>().setImage(widget.contact!.imagePath);
      } else {
        form.clearController();
        context.read<ImagePickerProvider>().clearImage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = context.read<ContactFormProvider>();
    final isEdit = widget.contact != null;

    // var nameController = TextEditingController(
    //   text: widget.contact?.name ?? '',
    // );
    // var phoneController = TextEditingController(
    //   text: widget.contact?.phone ?? '',
    // );
    // var emailController = TextEditingController(
    //   text: widget.contact?.email ?? '',
    // );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text(isEdit ? 'Edit Contact' : 'New Contact')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap(30),
            Consumer<ImagePickerProvider>(
              builder: (context, imageProvider, _) {
                return GestureDetector(
                  onTap: imageProvider.pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: imageProvider.image != null
                        ? FileImage(imageProvider.image!)
                        : null,
                    child: imageProvider.image == null
                        ? const Icon(Icons.camera_alt, size: 30)
                        : null,
                  ),
                );
              },
            ),
            Consumer<ContactFormProvider>(
              builder: (context, form, _) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: form.nameController,
                        onChanged: form.setName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          icon: Icon(Icons.person_search_outlined),
                          labelText: 'Name',
                          errorText: form.nameError,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: form.phoneController,
                        onChanged: form.setPhone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          icon: Icon(Icons.phone_outlined),
                          labelText: 'Phone',
                          errorText: form.phoneError,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: form.emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: form.setEmail,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          icon: Icon(Icons.email_outlined),
                          labelText: 'Email',
                          errorText: form.emailError,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            Gap(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Gap(5),
                GestureDetector(
                  onTap: () {
                    contactProvider.clearController();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final contactProvider = context.read<ContactFormProvider>();
                    final form = context.read<ContactFormProvider>();
                    if (!contactProvider.validateForm()) {
                      return;
                    }
                    form.save(context);
                    final imageprovider = context.read<ImagePickerProvider>();
                    contactProvider.clearController();
                    imageprovider.clearImage();
                    Navigator.pop(context);
                    
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Gap(5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
