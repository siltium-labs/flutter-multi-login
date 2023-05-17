
------------------------------------------
# **S-MultiLogin: Siltium Component for Social Media Login**<br> ![](https://img.shields.io/badge/Dart-Flutter-blue) ![](https://img.shields.io/badge/iOS-Android-green) ![](https://img.shields.io/badge/Email&Pass-yellow) ![](https://img.shields.io/badge/Google-red) ![](https://img.shields.io/badge/Facebook-blue) ![](https://img.shields.io/badge/en%20test-Apple-black)


## **Descripción**
Plugin para incluir en proyectos que permite utilizar el componente SMultiLogin para inicio de sesión con firebase a través de correo y contraseña, como así también a través de las redes sociales.
<br>
<br>

## **Versión**
0.1.0 - **Version inicial -** Inicio de sesión con Email & Contraseña, Google y Facebook para Android.
<br>
0.2.0 - Inicio de sesión con Email & Contraseña, Google y Facebook para Android & iOS. Inicios de sesión con iOS y Apple en testing.
<br>
0.3.0 - Inicios de sesión con Email & Contraseña, Google y Facebook para Android & iOS. Inicio de sesión con Apple en testing.
<br>
<br>

## **Instalación (Android y iOS)**
EN FLUTTER:

1) Agregar la libreria en `pubspec.yaml`:
```yaml
dependencies:
  s_multi_login:
    git:
      url: https://github.com/YamiTeyssier/s-multilogin-plug.git
      ref: development
```
Nota: Si se realizan cambios en la rama de dicho repositorio, es necesario realizar un `flutter pub get` para ver reflejados dichos cambios en un proyecto externo.

PARA ANDROID:

2) Modificar el compileSdkVersion a 33 en `project_name\android\app\build.gradle`:
```gradle
android {
    compileSdkVersion 33
    ...
}
```

3) Modificar el minSdkVersion a 21 `project_name\android\app\build.gradle`:
```gradle
android {
    defaultConfig {
        minSdkVersion 21
    }
}
```

PARA IOS:

4) Correr el comando `flutter pub get` y, a continuación, en el archivo `project_name\ios\Podfile` modificar la version de la plataforma ios a 12:
```ruby
# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
```
5) Luego correr el comando `pod install` y, finalmente, podrás correr el comando `flutter run`.


EN FIREBASE:

5) En Firebase, Ir a la [Consola Firebase](https://firebase.google.com) y crear un nuevo proyecto.

6) Luego, añadir Firebase a tu aplicación: NuevoProyectoFirebase -> Agregar app -> Flutter<br>
A continuación, seguir los pasos de la documentación oficial que se muestran en pantalla.<br>
Nota: Si es la primera vez que usas Firebase con Flutter, sigue todos lo pasos desde el primero. Si ya lo usaste anteriormente, puedes seguir desde el paso 2 (y desde el comando `flutterfire configure`) en adelante.<br>
También puedes seguir la guía de la [Documentación oficial para Agregar Firebase en una app de Flutter](https://firebase.google.com/docs/flutter/setup?hl=es-419&platform=android)<br>
(Una vez terminada esta guía, también es necesario ir a NuevoProyectoFirebase -> Agregar app -> Flutter)

<br>

## **Habilitar los Inicio de sesión (Android y iOS)**
### **LOGIN CON CORREO Y CONTRASEÑA:**
Con los pasos anteriores, se habilita el uso del login con correo y contraseña, tanto para Android como para iOS. Habilitarlo desde Firebase.<br>
Nota: Crear también un usuario de prueba.

~

### **LOGIN CON CUENTA DE GOOGLE:**
EN ANDROID:

Con los pasos anteriores, se habilita el uso del login con cuenta de google para Android. Habilitarlo desde Firebase y agregar la huella digital SHA1 de tu computadora, en "Configuración del proyecto" y seleccionando la app.<br>
Como obtener la huella digital SHA1: [Google docs sobre SHA1](https://developers.google.com/android/guides/client-auth?hl=es-419).<br>
- Resumen: En el cmd (consola de comandos) posicionarse dentro del directorio bin del jdk instalado, y ejecutar:
```
keytool -list -v -alias androiddebugkey -keystore %Path_a_tu_usuario%\.android\debug.keystore
password: android
```
- Copiar el SHA1 en la consola de Firebase.

EN IOS:

Con los pasos anteriores, se habilita el uso del login con cuenta de google para iOS, a través de la generación del archivo `GoogleService-Info.plist`. Como tal, dicho archivo esta deprecado y ya no funciona como tal.<br>
Por lo tanto, es necesario realizar los siguientes pasos para iOS:

1) Del archivo `GoogleService-Info.plist` obtener el `CLIENT_ID` y el `REVERSED_CLIENT_ID`.
2) Copiar el `CLIENT_ID` y colocarlo como parte del método `SMultiLogin().multiLoginInit()`, como se detalla más adelante en el uso de la librería (paso 2 de "Uso").
3) Luego, en el archivo `Info.plist` agregar el siguiente código dentro de `<dict>...</dict>`, agregando el campo `REVERSED_CLIENT_ID` obtenido del archivo `GoogleService-Info.plist`:
```plist
<!-- Google config-->
		<key>CFBundleURLTypes</key>
		<array>
			<dict>
				<key>CFBundleTypeRole</key>
				<string>Editor</string>
				<key>CFBundleURLSchemes</key>
				<array>
					<string>TU_REVERSED_CLIENT_ID</string>
				</array>
			</dict>
		</array>
```
4) Eliminar el archivo `GoogleService-Info.plist`.

~

### **LOGIN CON FACEBOOK:**
Entrar en la [Consola de Facebook Developers](https://developers.facebook.com/) e iniciar sesión (o registrarse).

Crear una nueva app y seguir la guía de inicio rápido según la plataforma que corresponda (Android y iOS):<br>
[Documentación oficial](https://developers.facebook.com/quickstarts/3399391376980505/?platform=android)<br>
[Desde la consola de Facebook Devs](https://developers.facebook.com/apps/766439921742770/fb-login/quickstart/)<br>
[Documentacion extra](https://defold.com/extension-facebook/)<br>

Nota: Hay problemas con los nombres de paquetes en la guia de inicio rápido, hacerlo por aparte probando hasta que pueda agregarse mediante los hash.

Habilitar el inicio de sesión de Facebook desde Firebase. Copiar el App ID y el App Secret dados en Facebook Devs y luego copiar la URI en la Consola de Facebook Devs, en "Inicio de sesión con Facebook -> Configurar -> URI de redireccionamiento de OAuth válidos".

EN FLUTTER

PARA ANDROID:

Resumen:
1) En el archivo `project_name\android\app\build.gradle` importar el SDK de Facebook y agregar un par de strings, con el `fbAppID` y el `fbClientToken` (Secret App) respectivamente y con esos nombres de variable:
```
defaultConfig {
        ...

        resValue "string", "fbAppID", "\"TU_FB_APP_ID\""
        resValue "string", "facebook_client_token", "\"TU_FB_CLIENT_TOKEN\""
    }

dependencies {
    implementation 'com.facebook.android:facebook-android-sdk:latest.release'
}
```
Nota: Es necesario escapar las comillas para que el archivo `build.gradle` lo tome como un string.<br>
~

Para IOS:

Resumen:
1) En el archivo `Info.plist` agregar el siguiente código dentro de `<dict>...</dict>`, agregando los campos correspondientes. Es decir, el AppID y el Client Token (SecretApp) de tu app de facebook:
```plist
<!-- Facebook iOS config -->
		<key>CFBundleURLTypes</key>
		<array>
			<dict>
				<key>CFBundleURLSchemes</key>
				<array>
					<string>fbTU_FB_APP_ID</string>
				</array>
			</dict>
		</array>
		<key>FacebookAppID</key>
		<string>TU_FB_APP_ID</string>
		<key>FacebookClientToken</key>
		<string>TU_FB_CLIENT_TOKEN</string>
		<key>FacebookDisplayName</key>
		<string>TU_APP_NAME</string>
		<key>LSApplicationQueriesSchemes</key>
		<array>
			<string>fbapi</string>
			<string>fb-messenger-share-api</string>
			<string>fbauth2</string>
			<string>fbshareextension</string>
		</array>
```
Nota: En `CFBundleURLSchemes` en necesario colocar el texto "fb" antes del `FB_APP_ID` para que funcione correctamente.

~
### **LOGIN CON APPLE:** Pendiente de configuración en Apple Dev.
<br>

## **Uso**
1) Importar el paquete en `main.dart`:
```dart
// Package import
import 'package:s_multiloginp/s_multiloginp.dart';
```

2) Inicializar el paquete en `main.dart` con `SMultiLogin().multiLoginInit()` pasando como parámetro un FirebaseOptions, que se encuentra en el archivo `firebase_options.dart` generado anteriormente con la intalación/configuración de firebase en el proyecto:
```dart
import 'firebase_options.dart';

void main() async {
  // Add package init (for Android)
  await SMultiLogin().multiLoginInit(
    DefaultFirebaseOptions.currentPlatform,
    "CLIENT_ID",
  );
  runApp(const MyApp());
}
```

3) Llamar a `SMultiLoginComponent()`. Nota: Se puede elegir uno de entre 4 "modos" de diseño por defecto, que son:
```dart
// Dos modos, uno minimalista y otro con más detalle respectivamente, encerrados en una Card con un estilo el cual es personalizable:
SMultiLoginComponent.simpleCardMode();
SMultiLoginComponent.complexCardMode();

// Dos modos, uno minimalista y otro con más detalle respectivamente, sin la Card mencionada anteriormente:
SMultiLoginComponent.simpleMode();
SMultiLoginComponent.complexMode();
```
Cada uno de estos "modos", a su vez, también es personalizable.

4) Especificar los parametros deseados:
	- `onResultEmailLogin` - para incluir en inicio de sesión con correo y contraseña
	- `onResultGoogleLogin` - para incluir en inicio de sesión con una cuenta de Google
	- `onResultFacebookLogin` - para incluir en inicio de sesión con Facebook (por el momento, solo con android)
	- `onResultAppleLogin` - para incluir en inicio de sesión con Apple (pendiente)

Nota: para contar con un metodo de inicio de sesión, incluir el metodo onResult deseado. En caso contrario, no incluirlo.<br>
El resto de parametros son opcionales para personalizar el diseño del componente, de ser necesario.

5) Otros Metodos disponibles:
```dart
// Para cerrar sesión en la instancia Firebase.
// LLamarlo al cerrar sesión en la app
SMultiLogin().logout();
// Para obtener el correo o el nombre del
// usuario que inició sesión.
// Se puede usar para verificar el login
SMultiLogin().userData(),
```

EJEMPLOS:
```dart
// Ejemplo de SMultiLoginComponent.simpleCardMode(), diseño por defecto e inicio de sesión a través de correo, google y facebook:
SMultiLoginComponent.simpleCardMode(
  footerText: "O podés ingresar con:",
  onResultEmailLogin: (data) {
    // código onResult Email
  },
  onErrorEmailLogin: (error) {
    // código onError Email
  },
  onResultGoogleLogin: (data) {
    // código onResult Google
  },
  onErrorGoogleLogin: (error) {
    // código onError Google
  },
  onResultFacebookLogin: (data) {
    // código onResult Facebook
  },
  onErrorFacebookLogin: (error) {
    // código onError Facebook
  },
);

// Ejemplo de SMultiLoginComponent.complexCardMode(), diseño personalizado e inicio de sesión a través de correo, google y facebook:
SMultiLoginComponent.complexCardMode(
  // Parametros para personalizar la Card que encierra al login (en los diseños CardMode)
  cardDecoration: BoxDecoration(
    color: const Color.fromARGB(255, 158, 192, 231),
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Color(0x40666666),
        spreadRadius: -3,
        blurRadius: 20,
        offset: Offset(0, 10),
      ),
    ],
  ),
  cardInnerPadding: const EdgeInsets.all(15),
  // Parametros para personalizar los estilos de los inputs de correo y contraseña
  emailInputDecoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    fillColor: const Color(0xFFFFFFFF),
    filled: true,
    hintStyle: const TextStyle(
      color: Color(0xFF000000),
      fontWeight: FontWeight.w400,
      fontSize: 13,
      fontStyle: FontStyle.italic,
    ),
    hintText: 'Correo electrónico...',
  ),
  emailInputTextStyle: const TextStyle(
    fontSize: 15,
    color: Color(0xFF0230C5),
    fontStyle: FontStyle.italic,
  ),
  passwordInputDecoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    fillColor: const Color(0xFFFFFFFF),
    filled: true,
    hintStyle: const TextStyle(
      color: Color(0xFF000000),
      fontWeight: FontWeight.w400,
      fontSize: 13,
      fontStyle: FontStyle.italic,
    ),
    hintText: 'Contraseña...',
  ),
  passwordInputTextStyle: const TextStyle(
    fontSize: 15,
    color: Color(0xFF0230C5),
    fontStyle: FontStyle.italic,
  ),
  // Parametros para personalizar los estilos de los botones de:
  // Correo
  emailButtonStyle: ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll<Color>(
        Color(0xFF0230C5)),
    maximumSize: const MaterialStatePropertyAll<Size>(
      Size(double.infinity, 100),
    ),
    minimumSize: const MaterialStatePropertyAll<Size>(
      Size(100, 40),
    ),
    shape: MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
  emailButtonIcon: const Icon(
    Icons.mail,
    color: Color(0xFFFFDA00),
    size: 30,
  ),
  emailButtonText: "Iniciar sesión con correo",
  // Google
  googleButtonStyle: ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll<Color>(
        Color(0xFF0230C5)),
    maximumSize: const MaterialStatePropertyAll<Size>(
      Size(double.infinity, 100),
    ),
    minimumSize: const MaterialStatePropertyAll<Size>(
      Size(100, 40),
    ),
    shape: MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
  googleButtonIcon: Image.asset(
    "assets/icon_google_default.png",
    height: 30,
    color: const Color(0xFFFFDA00),
  ),
  googleButtonText: "Iniciar sesión con Google",
  // Facebook
  facebookButtonStyle: ButtonStyle(
    backgroundColor: const MaterialStatePropertyAll<Color>(
        Color(0xFF0230C5)),
    maximumSize: const MaterialStatePropertyAll<Size>(
      Size(double.infinity, 100),
    ),
    minimumSize: const MaterialStatePropertyAll<Size>(
      Size(100, 40),
    ),
    shape: MaterialStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  ),
  facebookButtonIcon: const Icon(
    Icons.facebook,
    color: Color(0xFFFFDA00),
    size: 30,
  ),
  facebookButtonText: "Iniciar sesión con Facebook",
  footerText: "O podés ingresar con:",
  // Metodos onResult y onError:
  onResultEmailLogin: (data) {
    // código onResult Email
  },
  onErrorEmailLogin: (error) {
    // código onError Email
  },
  onResultGoogleLogin: (data) {
    // código onResult Google
  },
  onErrorGoogleLogin: (error) {
    // código onError Google
  },
  onResultFacebookLogin: (data) {
    // código onResult Facebook
  },
  onErrorFacebookLogin: (error) {
    // código onError Facebook
  },
),
```
