import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../controller/user_profile_controller.dart';

class UserProfileFormScreen extends ConsumerStatefulWidget {
  const UserProfileFormScreen({super.key});

  @override
  ConsumerState<UserProfileFormScreen> createState() => _UserProfileFormScreenState();
}

class _UserProfileFormScreenState extends ConsumerState<UserProfileFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  DateTime? _selectedDob;
  String? _gender;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate() || _selectedDob == null || _gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    await ref.read(userProfileController.notifier).createUserProfile(
          name: _nameController.text.trim(),
          dob: _selectedDob!,
          gender: _gender!,
        );

    final state = ref.read(userProfileController);

    state.whenOrNull(
      error: (e, _) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      ),
      data: (_) {
        Navigator.pushReplacementNamed(context, '/home');  // Replace with your app's home screen route.
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(userProfileController);

    return Scaffold(
      appBar: AppBar(title: const Text('Complete Your Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 16),

              ListTile(
                title: Text(
                  _selectedDob == null
                      ? 'Select Date of Birth'
                      : DateFormat('yMMMMd').format(_selectedDob!),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _selectedDob = picked);
                  }
                },
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Male')),
                  DropdownMenuItem(value: 'female', child: Text('Female')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                hint: const Text('Select Gender'),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? 'Please select a gender' : null,
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: profileState is AsyncLoading ? null : _submit,
                child: profileState is AsyncLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
