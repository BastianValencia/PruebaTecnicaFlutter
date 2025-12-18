enum UserRole {
  buyer,
  seller,
  admin;

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.name.toUpperCase() == value.toUpperCase(),
      orElse: () => UserRole.buyer,
    );
  }

  String toJson() => name.toUpperCase();
  
  String get displayName {
    switch (this) {
      case UserRole.buyer:
        return 'Comprador';
      case UserRole.seller:
        return 'Vendedor';
      case UserRole.admin:
        return 'Administrador';
    }
  }
}