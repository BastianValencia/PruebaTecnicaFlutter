import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:enm/features/profile/presentation/widgets/profile_menu_tile.dart';
import 'package:sizer/sizer.dart';
import '../../../../shared/theme/theme_provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final asyncState = ref.watch(profileProvider);
    return Scaffold(
      body: SafeArea(
        child: asyncState.when(
          data: (state) {
             final user = state.originalUser;
             return ListView(
               children: [
                 // Header similar to ProductsListScreen
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [
                           // Usamos una imagen de placeholder o iniciales si no hay foto real en la entidad
                           CircleAvatar(
                             radius: 6.w,
                             backgroundColor: Colors.grey[200],
                             backgroundImage: const NetworkImage('https://i.pravatar.cc/150?u=juan'), // Placeholder,
                           ),
                           SizedBox(width: 3.w),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('Hola, ${user.name}', style: TextStyle(color: Colors.grey, fontSize: 16.sp)),
                               SizedBox(height: 0.5.h),
                               Text(user.email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: Colors.grey.shade600)),
                             ],
                           ),
                         ],
                       ),
                       FloatingActionButton(
                         heroTag: 'profile_edit_btn',
                         shape: const CircleBorder(),
                         backgroundColor: Colors.white,
                         elevation: 2,
                         onPressed: () => context.push('/profile/edit'), 
                         child: const Icon(Icons.edit, color: Colors.black)
                       )
                     ],
                   ),
                 ),
               Padding(
                 padding: const EdgeInsets.all(16),
                 child: Row(
                   children: [
                     Expanded(child: _buildQuickAction('Mis Pedidos')),
                     const SizedBox(width: 12),
                     Expanded(child: _buildQuickAction('Comprar de nuevo')),
                   ],
                 ),
               ),
               
               const Divider(height: 1, color: Colors.grey),
               
               // Account Settings List
               _buildSectionTitle('Configuración de Cuenta'),
               ProfileMenuTile(
                 icon: Icons.person_outline,
                 title: 'Datos Personales',
                 subtitle: user.name,
                 textColor: colors.onSurface,
                 onTap: () => context.push('/profile/edit'),
               ),
               ProfileMenuTile(
                 icon: Icons.security,
                 title: 'Inicio de Sesión y Seguridad',
                 subtitle: '*******',
                 textColor: colors.onSurface,
               ),
               ProfileMenuTile(
                 icon: Icons.badge_outlined,
                 title: 'Rol de Usuario',
                 subtitle: user.roleDisplayName,
                 textColor: colors.onSurface,
               ),
               
               _buildSectionTitle('Preferencias'),
               ProfileMenuTile(
                 icon: Icons.language,
                 title: 'Idioma',
                 subtitle: 'Español',
                 textColor: colors.onSurface,
               ),
                // Switch de Tema
               Consumer(
                 builder: (context, ref, child) {
                   final themeMode = ref.watch(themeProvider);
                   final isDark = themeMode == ThemeMode.dark;
                   return SwitchListTile(
                     secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode, color: Colors.grey),
                     title: const Text('Modo Oscuro', style: TextStyle(fontWeight: FontWeight.w500)),
                     value: isDark,
                     onChanged: (val) {
                       ref.read(themeProvider.notifier).setDarkMode(val);
                     },
                     activeColor: Theme.of(context).colorScheme.secondary,
                   );
                 },
               ),
               ProfileMenuTile(
                 icon: Icons.notifications_none,
                 title: 'Notificaciones',
                 subtitle: 'Activadas',
                 textColor: colors.onSurface,
               ),
             ],
           );
        },
        error: (err, stack) => Center(child: Text('Error: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    ));
  }

  Widget _buildQuickAction(String label) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      child: Text(label, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black)),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}