import 'package:enm/features/profile/presentation/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:enm/features/profile/presentation/widgets/profile_snackbar.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Inicializar controladores con el estado actual
    final state = ref.read(profileProvider).value!;
    _nameController = TextEditingController(text: state.editedUser.name);
    _emailController = TextEditingController(text: state.editedUser.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
       final notifier = ref.read(profileProvider.notifier);
       await notifier.saveChanges();
       
       if (!mounted) return;

       final newState = ref.read(profileProvider).value;
       
       if (newState != null && newState.saveError == null) {
          // Éxito
          ProfileSnackBar.showSuccess(context, 'Perfil actualizado correctamente');
          if (mounted) Navigator.of(context).pop(); 
       } else if (newState?.saveError != null) {
          // Error
          ProfileSnackBar.showError(
            context,
            message: newState!.saveError!,
            onDiscard: () {
               notifier.discardChanges();
               Navigator.of(context).pop();
            },
          );
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        centerTitle: true,
        actions: [
          // Mostrar loading o botón guardar
          if (asyncState.value?.isSaving == true)
             const Center(child: Padding(padding: EdgeInsets.only(right: 16), child: CircularProgressIndicator.adaptive()))
          else
            TextButton(
              onPressed: _save,
              child: const Text('Guardar', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: asyncState.when(
        data: (state) {
          return Form(
            key: _formKey,
            onChanged: () {
               // Actualizar estado local del provider cada vez que cambia el form (Optimistic)
               ref.read(profileProvider.notifier).updateField(
                 name: _nameController.text,
                 email: _emailController.text,
               );
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es requerido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El email es requerido';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Ingrese un email válido (ej: usuario@dominio.com)';
                    }
                    return null;
                  },
                ),
              ],
            ),
          );
        },
        error: (err, _) => Center(child: Text('Error fatal: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}