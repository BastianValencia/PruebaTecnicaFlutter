# Flutter Marketplace App 🛍️

Aplicación robusta de marketplace en Flutter desarrollada para una prueba técnica.

- **Arquitectura escalable** 
- **Patrones de gestión de estado** 
- **Implementación de UI**.

## 🚀 Funcionalidades

### **Feature 1: Marketplace de Productos**
- **Carga de Datos Asíncrona:** Obtiene productos de un datasource remoto simulado (con latencia de red y simulación de errores).
- **Manejo de Datos Inconsistentes:** Maneja productos faltantes, precios desactualizados y errores 404 en las vistas de detalle.
- **UI:** Diseño de cuadrícula estilo Amazon con búsqueda (simulada), calificaciones y badges de estado.
- **Arquitectura:** Capas de Clean Architecture (Dominio, Datos, Presentación).

### **Feature 2: Perfil de Usuario**
- **UI Optimista:** Actualizaciones instantáneas en la UI mientras se guarda en segundo plano.
- **Resolución de Conflictos:** Simula "conflictos de guardado" (30% de probabilidad) y proporciona un mecanismo para **Descartar** o **Reintentar** los cambios.
- **Componentes:** UI modular con `ProfileMenuTile` y `ProfileSnackBar` reutilizables.
- **Tema:** Cambio de modo Oscuro/Claro con persistencia instantánea en el estado de la app.

### **Utilidades Core**
- **Formateo de Moneda:** Formateador personalizado que refleja estándares chilenos/internacionales (ej., `$ 125.000 USD`).
- **Theming:** `AppTheme` centralizado con soporte para ColorScheme - ThemeDark y ThemeLight.
- **Robustez de Datos:** Sistema de serialización "Blindado" (`RobustStringConverter`, `RobustDoubleConverter`) que evita crasheos por datos inconsistentes (nulls, tipos erróneos) con impacto de rendimiento despreciable (0.24µs por item).

---

## 📊 Diagramas Técnicos

### **1. Arquitectura & Componentes**
Estructura de Clean Architecture + Riverpod.

```mermaid
graph TD
    subgraph Presentation ["Capa de Presentación (UI & State)"]
        UI_List["ProductsListScreen"]
        UI_Detail["ProductDetailScreen"]
        Provider["ProductsNotifier (Riverpod)"]
        State["ProductsState"]
        
        UI_List -->|Watch| Provider
        UI_Detail -->|Watch| Provider
        Provider -->|Emit| State
        State -->|Render| UI_List
        State -->|Render| UI_Detail
    end

    subgraph Domain ["Capa de Dominio (Business Rules)"]
        Entity["Product Entity"]
        RepoInterface["ProductsRepository (Abstract)"]
        
        Provider -->|Call| RepoInterface
        RepoInterface -->|Return| Entity
    end

    subgraph Data ["Capa de Datos (Implementation)"]
        RepoImpl["ProductsRepositoryImpl"]
        DataSource["ProductsRemoteDatasource"]
        Model["ProductModel (DTO)"]
        
        RepoImpl -.->|Implements| RepoInterface
        RepoImpl -->|Call| DataSource
        DataSource -->|Return JSON| Model
        Model -->|Map to| Entity
    end
    
    subgraph External ["Sistema Externo"]
       API["Simulated Backend API"]
       DataSource -- "HTTP / Delay" --> API
    end
```

### **2. Diagrama de Secuencia: Flujo de Detalle e Inconsistencia**
Muestra cómo se manejan los errores de consistencia (producto "missing" o 404).

```mermaid
sequenceDiagram
    actor User
    participant UI as ProductDetailScreen
    participant Notifier as ProductsNotifier
    participant Repo as ProductsRepository
    participant DS as RemoteDatasource

    User->>UI: Toca un producto
    activate UI
    UI->>Notifier: refreshProduct(id)
    activate Notifier
    
    Notifier->>Repo: getProductDetail(id)
    activate Repo
    Repo->>DS: getProductDetail(id)
    activate DS
    
    alt Producto Existe (Happy Path)
        DS-->>Repo: ProductModel
        Repo-->>Notifier: Product (Entity)
        Notifier-->>UI: State Change (Data)
        UI-->>User: Muestra Detalle
    
    else Inconsistencia (Producto no encontrado / 404)
        DS-->>Repo: Throw ProductNotFoundException
        deactivate DS
        Repo-->>Notifier: Throw ProductNotFoundException
        deactivate Repo
        
        Note over Notifier: Catch Exception & markAsMissing(id)
        Notifier-->>UI: State Change (Status: missing)
        
        UI-->>User: Muestra Pantalla de Error "No disponible"
    end
    
    deactivate Notifier
    deactivate UI
```

---

## 🏗️ Arquitectura

El proyecto sigue **Clean Architecture** combinada con **Riverpod 2.0 (Generator)**.

### **Estructura de Carpetas**
```
lib/
├── core/               # Lógica compartida (Errores, Tema, Utils)
├── features/           # Módulos por funcionalidad (Feature-first)
│   ├── products/
│   │   ├── data/       # Implementación de Repositorios y Datasources
│   │   ├── domain/     # Entidades e Interfaces de Repositorios
│   │   └── presentation/ # Pantallas, Providers (Notifiers), Widgets
│   └── profile/        # (Misma estructura)
├── shared/             # Componentes UI reutilizables y Tema
└── main.dart           # Punto de entrada de la App
```

### **Gestión de Estado: Riverpod**
- **Notifiers:** `StateNotifier` configura la lógica para gestionar estados complejos (`ProductsState`, `ProfileEditState`).
- **AsyncValue:** Se usa intensivamente para manejar correctamente los estados de Carga/Error/Data en la UI.
- **Inyección de Dependencias:** Los repositorios se inyectan en los Notifiers a través de providers de Riverpod.

---

## 🧠 Decisiones Técnicas y Trade-offs

### **1. Justificación de Arquitectura**
Se eligió **Clean Architecture** para garantizar la separación de responsabilidades, facilitando el testing y la escalabilidad.
- **¿Por qué Riverpod?** Se prefirió sobre BLoC por su simplicidad, menor boilerplate y manejo de dependencias seguro y declarativo (sin `context`). Se prefirió sobre GetX para mantener un flujo de datos unidireccional estricto y seguro en tiempo de compilación.

### **2. Trade-offs Asumidos**
- **Dependencia de Generación de Código (`build_runner`):** Se asume el costo de tiempo extra en generación de código (Freezed/Riverpod) a cambio de obtener **Inmutabilidad** garantizada, `copyWith` automático y **Null Safety** robusta en toda la app.
- **Complejidad Inicial:** Implementar capas (Domain/Data/Presentation) añade archivos extra para una app pequeña, pero protege el proyecto contra deuda técnica futura.

### **3. Solución a Escenarios de Inconsistencia**
- **Sanitización de Datos:** Se implementaron `RobustJsonConverters` que interceptan la respuesta del API. Si el backend envía tipos incorrectos (ej. precio como String) o nulos, el app los corrige al vuelo en lugar de fallar.
- **Manejo de Estados:** Si un producto desaparece (404) o cambia de precio, el sistema de estados (`ProductsNotifier`) captura el error y actualiza el estado del item específico a `missing` o `stale`, permitiendo que la UI muestre mensajes amigables ("Producto no disponible") en lugar de pantallas de error genéricas.

### **4. Límites Conocidos y Riesgos**
- **Persistencia Volátil:** Al no existir un backend real ni base de datos local completa (SQLite/Hive), todos los cambios se pierden al cerrar la app.
- **Mock Data:** Toda la data es generada en memoria.

### **5. Mejoras Futuras (Next Steps)**
- **Persistencia Real:** Implementar backend o base de datos local para guardar cambios permanentemente.
- **Internacionalización (l10n):** Soporte multi-idioma.
- **Notificaciones Push:** Para avisos de ofertas o cambios de estado.

---

## 🛠️ Configuración y Ejecución

1.  **Prerrequisitos:** Flutter SDK instalado.
2.  **Dependencias:**
    ```bash
    flutter pub get
    ```
3.  **Generación de Código (Freezed/Riverpod):**
    > Nota: Este proyecto usa generación de código. Si cambias modelos o providers, ejecuta:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  **Ejecutar App:**
    ```bash
    flutter run
    ```
5.  **Ejecutar Tests:**
    ```bash
    flutter test
    ```

## 🧪 Testing

- **Unit Tests:** Ubicados en `test/features/`. Cubren la lógica de los Repositorios y Modelos.
- **Robustness Tests:** `product_model_test.dart` verifica la resiliencia ante datos corruptos.
- **Benchmarks:** `performance_benchmark_test.dart` mide el impacto del parsing (Clean vs Dirty Data).
- **Widget Tests:** Cubren el renderizado de la UI e interacciones (En progreso).

---

Desarrollado por Bastian Valencia Jopia. 
Linkedin: https://www.linkedin.com/in/bastian-valencia/
Yotube: https://www.youtube.com/@papayasconcrema333 canal propio dedicado a enseñar flutter.
