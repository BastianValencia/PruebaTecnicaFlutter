enum ProductStatus {
  valid,      // Producto OK
  missing,    // Existe en lista pero no en detalle
  stale,      // Precio o datos cambiaron
  unknown;    // Estado inicial
  
  bool get hasIssue => this != valid && this != unknown;
  
  String get displayMessage {
    switch (this) {
      case ProductStatus.valid:
        return 'Disponible';
      case ProductStatus.missing:
        return 'No disponible';
      case ProductStatus.stale:
        return 'Precio actualizado';
      case ProductStatus.unknown:
        return '';
    }
  }
}