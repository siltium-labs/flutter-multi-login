
------------------------------------------
# **S-MultiLogin: Siltium Component for Social Media Login**<br> ![](https://img.shields.io/badge/Dart-Flutter-blue) ![](https://img.shields.io/badge/iOS-Android-green) <br> ![](https://img.shields.io/badge/Email&Pass-yellow) ![](https://img.shields.io/badge/Google-DD4B39) ![](https://img.shields.io/badge/Facebook-3B5998) ![](https://img.shields.io/badge/Twitter-00ACED) ![](https://img.shields.io/badge/LinkedIn-007BB6) ![](https://img.shields.io/badge/Microsoft-7cbb00) ![](https://img.shields.io/badge/en%20test-Apple-black)


## **Descripción**
Plugin para incluir en proyectos mobile de Siltium que permite utilizar el componente SMultiLogin para inicio de sesión con la herramienta Firebase, a través de correo y contraseña como así también a través de las redes sociales (Google, Facebook, etc.).
<br>
<br>

## **Versión**
**0.1.0 - Version inicial** - Inicio de sesión con Email & Contraseña, Google y Facebook disponibles para Android.
<br>
**0.2.0** - Inicio de sesión con Email & Contraseña, Google y Facebook disponibles para Android & iOS. Inicio de sesión con iOS y Apple en testing.
<br>
**0.3.0** - Inicio de sesión con Email & Contraseña, Google y Facebook disponibles para Android & iOS. Inicio de sesión con Apple en testing.
<br>
**0.4.0** - Inicio de sesión con Email & Contraseña, Google y Facebook disponibles para Android & iOS. Inicio de sesión con Twitter, LinkedIn y Microsoft disponibles para Android y en testing para iOS. Inicio de sesión con Apple en testing.
<br>
**1.0.0** - Inicio de sesión con Email & Contraseña, Google, Facebook, Twitter, LinkedIn y Microsoft disponibles para Android & iOS. Inicio de sesión con Apple en testing.
<br>
<br>

## **Instalación de la Librería (Android y iOS)**
EN FLUTTER:

1) Agregar la libreria en `pubspec.yaml`:
```yaml
dependencies:
  s_multiloginp:
    git:
      url: https://github.com/YamiTeyssier/s-multilogin-plug.git
      ref: development
```
Nota: Si se realizan cambios en la rama de dicho repositorio, es necesario quitar la librería (comentarla), correr el comando `flutter pub get`, volver a agregar la librería (descomentarla) y finalmente volver a correr el comando `flutter pub get`.

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

4) Ejecutar el comando `flutter clean` y borrar el archivo `project_name\ios\Podfile`.<br>
Nota: Este paso es necesario debido a una mala generación de un fragmento de código en dicho archivo.

5) Correr el comando `flutter pub get` para generar el archivo nuevamente, y a continuación verificar que el siguiente fragmento ya no se encuentre generado en él:

![Agregar email login](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/ios_init_config.png)

y también en el mismo archivo modificar la versión de la plataforma iOS a 12:
```ruby
# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
```
6) Luego correr el comando `pod install` y, finalmente, podrás correr el comando `flutter run`.


EN FIREBASE:

7) En Firebase, Ir a la [Consola Firebase](https://firebase.google.com) y crear un nuevo proyecto:

![Crear nuevo proyecto firebase](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/install_01.png)

Colocarle nombre al nuevo proyecto y continuar:

![Nombrar el nuevo proyecto firebase](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/install_02.png)

También puedes habilitar o deshabilitar Google Analytics. Si lo deshabilitas, seguidamente puedes crear el proyecto. Si no, continúa a la configuración del mismo:

![Habilitar/Deshabilitar google analytics](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/install_03.png)

Al habilitar Google Analytics es necesario configurarlo y aceptar las condiciones de uso. Y finalmente, puedes crear el proyecto:

![Finalizar y crear el proyecto](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/install_04.png)

8) Luego, añadir Firebase a tu aplicación: NuevoProyectoFirebase -> Agregar app -> Flutter<br>

![Crear App de Flutter en Firebase](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/install_05.png)

A continuación, seguir los pasos 1 y 2 de la documentación oficial que se muestran en pantalla.<br>
Nota: Si es la primera vez que usas Firebase con Flutter, realiza los pasos 1 y 2 completos. Si ya lo usaste anteriormente, puedes realizar solo el paso 2 desde el comando `flutterfire configure`.<br>

![Paso 1](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/install_06.png)

![Paso 2](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/install_07.png)

También puedes seguir la guía de la [Documentación oficial para Agregar Firebase en una app de Flutter](https://firebase.google.com/docs/flutter/setup?hl=es-419&platform=android)<br>
(Una vez terminada esta guía, también es necesario ir a NuevoProyectoFirebase -> Agregar app -> Flutter)

<br>

## **Inicialización de la Librería (Android y iOS)**
Para agregar y utilizar en tu proyecto el inicio de sesión de cualquier plataforma, primero debes seguir estos pasos:
1) Importar la librería `s_multiloginp` y el archivo `firebase_options.dart` (generado anteriormente con la intalación/configuración de Firebase) en el archivo `main.dart` de tu proyecto:
```dart
// Package and Firebase options file import
import 'package:s_multiloginp/s_multiloginp.dart';
import 'firebase_options.dart';
```

2) Inicializar la librería en `main.dart` con `SMultiLogin().multiLoginInit()`, pasando a `options` como parámetro un FirebaseOptions, que se encuentra en el archivo `firebase_options.dart`, como se muestra a continuación:
```dart
void main() async {
  // Add package init
  await SMultiLogin().multiLoginInit(
    options: DefaultFirebaseOptions.currentPlatform, // FirebaseOptions de "firebase_options.dart"
  );
  runApp(const MyApp());
}
```
Nota: No olvidar agregar el `async` al `main()`.

Ahora ya puedes agregar el login de diferentes plataformas/proveedores.

<br>

## **Agregar y Usar los Inicio de sesión (Android y iOS)**
Nota: Para habilitar los diferentes proveedores, dirigirse a Authentication -> Sign-in method -> Agregar proveedor nuevo:

![Agregar nuevo proveedor](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/login_01.png)

~

### **LOGIN CON CORREO Y CONTRASEÑA:**
Con los pasos anteriores, se habilita el uso del login con correo y contraseña, tanto para Android como para iOS. Habilitarlo desde Firebase.<br>

![Agregar email login](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/email_01.png)

![Habilitar email login](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/email_02.png)

Nota: Crear también un usuario de prueba (Authentication -> Users -> Agregar usuario):

![Crear nuevo usuario](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/email_03.png)

![Nuevo usuario](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/email_04.png)

~

### **LOGIN CON CUENTA DE GOOGLE:**
EN ANDROID:

Con los pasos anteriores, se habilita el uso del login con cuenta de google para Android. Habilitarlo desde Firebase y agregar la huella digital SHA1 de tu computadora, en "Configuración del proyecto" y seleccionando la app.<br>

![Agregar google login](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/google_01.png)

![Habilitar google login](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/google_02.png)

Como obtener la huella digital SHA1: [Google docs sobre SHA1](https://developers.google.com/android/guides/client-auth?hl=es-419).<br>
- Resumen: En el cmd (consola de comandos) posicionarse dentro del directorio bin del jdk instalado, y ejecutar:
```
keytool -list -v -alias androiddebugkey -keystore %Path_a_tu_usuario%\.android\debug.keystore
password: android
```
- Copiar el SHA1 en la consola de Firebase.

![ir a configuracion del proyecto](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/google_03.png)

![En tu app, huellas digitales](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/google_04.png)

![Agregar tu huella digital](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/google_05.png)

EN IOS:

Con los pasos anteriores, se habilita el uso del login con cuenta de google para iOS, a través de la generación del archivo `GoogleService-Info.plist`. Sin embargo, dicho archivo está deprecado y ya no funciona como tal.<br>
Por lo tanto, es necesario realizar los siguientes pasos para iOS:

1) Del archivo `GoogleService-Info.plist`, ubicado en `project_name\ios\Runner\`, obtener el `CLIENT_ID` y el `REVERSED_CLIENT_ID`.

![Obtener CLIENT_ID y REVERSED_CLIENT_ID](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/google_06.png)

2) Copiar el `CLIENT_ID` y colocarlo como parte del método `SMultiLogin().multiLoginInit()` (anteriormente iniciado en `main.dart`) como se detalla a continuación:
```dart
await SMultiLogin().multiLoginInit(
  ...
  googleIOSClientId: "TU_CLIENT_ID", // CLIENT_ID de "GoogleService-Info.plist"
);
```

3) Luego, en el archivo `project_name\ios\Runner\Info.plist` agregar el siguiente código dentro de `<dict>...</dict>`, agregando el campo `REVERSED_CLIENT_ID` obtenido del archivo `GoogleService-Info.plist`:
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

![Eliminar GoogleService-Info.plist](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/google_07.png)

~

### **LOGIN CON FACEBOOK:**
Entrar en la [Consola de Facebook Developers](https://developers.facebook.com/) e iniciar sesión (o registrarse).

Crear una nueva app y seguir la guía de inicio rápido según la plataforma que corresponda (Android y iOS):<br>
[Documentación oficial](https://developers.facebook.com/quickstarts/3399391376980505/?platform=android)<br>
[Desde la consola de Facebook Devs](https://developers.facebook.com/apps/766439921742770/fb-login/quickstart/)<br>
[Documentacion extra](https://defold.com/extension-facebook/)<br>

Nota: Hay problemas con los nombres de paquetes en la guia de inicio rápido, hacerlo por aparte probando hasta que pueda agregarse mediante los hash.

Habilitar el inicio de sesión de Facebook desde Firebase. Copiar el App ID y el App Secret dados en Facebook Devs y luego copiar la URI en la Consola de Facebook Devs, en "Inicio de sesión con Facebook -> Configurar -> URI de redireccionamiento de OAuth válidos".

![Donde estan el AppID y el App Secret](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/facebook_01.png)

![Agregar facebook login](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/facebook_02.png)

![Habilitar facebook login](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/facebook_03.png)

![Agregar uri en facebook](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/facebook_04.png)

~

EN FLUTTER, resumen:

PARA ANDROID:

1) En el archivo `project_name\android\app\build.gradle` importar el SDK de Facebook y agregar un par de strings, con el `fbAppID` y el `fbClientToken` (Secret App) respectivamente y con esos nombres de variable:
```gradle
defaultConfig {
        ...
        // Facebook Android config
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

1) En el archivo `project_name\ios\Runner\Info.plist` agregar el siguiente código dentro de `<dict>...</dict>`, agregando los campos correspondientes. Es decir, el AppID y el Client Token (SecretApp) de tu app de facebook:
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

~
### **LOGIN CON TWITTER:**
1) Iniciar sesión con una cuenta de twitter, ingresar a [Twitter Developers](https://developer.twitter.com/) e ir a "Developer Portal", para crear un proyecto (o usar el creado por defecto) y una aplicación de twitter.<br>
Nota: si no tienes una cuenta developer, necesitarás activarla enviando las razones de uso de la misma. Finalizado esto te enviará a tu dashboard. Si te generó automáticamente una aplicación por defecto, será necesario borrarla y hacer una nueva app para que asi te den las API Keys y Secret, necesarias para la implementacion del login en flutter.

![Developer Portal](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/twitter_01.png)

![Crear proyecto y app en twitter Devs](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/twitter_02.png)

2) Estas API key y secret, colocarlas en la configuracion de la consola de firebase para habilitar el inicio de sesión con twitter.

![Habilitar twitter login](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/twitter_03.png)

![Agregar keys de twitter](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/twitter_04.png)

3) Configurar la autenticación de usuarios en el Developer Portal, seleccionando la aplicación y desplazandote hasta el fondo, donde deberás hacer clik en "Set up" en la parte "User authentication settings".
Deberás elegir que permisos necesitas para la aplicación (lectura de tuits y perfil, lectura y escritura de tuits, etc.), el tipo de tu app (en este caso, Native App) y te mostrará la información del Client ID. Aqui tambien deberas colocar una URL tipo esquema (sheme//:) que NO sea la que da firebase, sino una custom que tambien será definida en la aplicación para asi poder redirigir desde el navegador a la misma.

![User auth settings en dashboard](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/twitter_05.png)

![User auth settings](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/twitter_06.png)

![App scheme](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/twitter_07.png)

~

EN FLUTTER, resumen:

1) Inicializar el login de twitter en tu proyecto, pasando como parámetros al método `SMultiLogin().multiLoginInit()` (anteriormente iniciado en `main.dart`) tu API Key, API Secret y esquema de redireccionamiento de Twitter, como se detalla a continuación:
```dart
await SMultiLogin().multiLoginInit(
  ...
  twitterApiKey: "TU_API_KEY",
  twitterApiSecretKey: "TU_API_SECRET",
  twitterRedirectURI: "customscheme://",
);
```

PARA ANDROID:

1) En el archivo `project_name\android\app\build.gradle` agregar el mismo esquema de redireccionamiento como un string con el nombre de variable `twRedirectURL`:
```gradle
defaultConfig {
        ...
        // Twitter Android config
         resValue "string", "twRedirectURL", "\"customscheme\""
    }
```
Nota: Es necesario escapar las comillas para que el archivo `build.gradle` lo tome como un string y NO colocar "://" al final del nombre del esquema.<br>
~

Para IOS:

1) En el archivo `project_name\ios\Runner\Info.plist` agregar el siguiente código dentro de `<dict>...</dict>`, agregando también en él tu esquema de redireccionamiento:
```plist
<!-- Twitter iOS config -->
    <key>CFBundleURLTypes</key>
		<array>
			<dict>
				<key>CFBundleTypeRole</key>
				<string>Editor</string>
				<key>CFBundleURLSchemes</key>
				<array>
					<string>customscheme</string>
				</array>
			</dict>
		</array>
```
Nota: NO colocar "://" al final del nombre del esquema.

~
### **LOGIN CON LINKEDIN:**
1) Iniciar sesión con una cuenta de LinkedIn en [LinkedIn Developers](https://developer.linkedin.com/) y entrar en la pestaña "My apps".

![Linkedin devs](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_01.png)

2) Crear una app, indicando nombre de la misma, agregando una foto/logo y vinculandola a una página de LinkedIn existente.
Nota: Vincular una página a la aplicación es Obligatorio.

![Crear app](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_02.png)

![Configurar app 1](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_03.png)

![Configurar app 2](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_04.png)

3) Luego ir a la pestaña "Settings" para verificar la aplicación con la página vinculada anteriormente. Para eso hacemos click en "Verify" el cual nos abrira un popup en el que tenemos que generar una URL para dirigirnos a la página de verificación.

![Verificar app 1](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_05.png)

![Verificar app 2](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_06.png)

4) Una vez generado el URL, lo copiamos y pegamos en una nueva pestaña del navegador y nos redirigirá a una pagina para ahora sí verificar la app con la pagina vinculada en su creación. Una vez hecho esto cerramos esta pestaña, volvemos a nuestra app, ponemos "I'm done" y recargamos la pagina para comprobar que la app ya esta verificada.

![Verificar app 3](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_07.png)

![Verificar app 4](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_08.png)

5) Una vez verificada la app, podemos agregar el inicio de sesión a la misma. En la pestaña "Products" de la app pedir el acceso al inicio de sesion, tanto al "Sign In with LinkedIn" como asi también al "Sign In with LinkedIn v2".

![Agregar login 1](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_09.png)

![Agregar login 2](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_10.png)

![Agregar login 3](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_11.png)

6) Finalmente, obtener los datos que serán utilizados para inicializar la configuración de dicho login en tu proyecto flutter.
Primero, en la pestaña "Auth" de la app, agregar una URL de redireccionamiento para la misma. Esta debe ser exactamente la siguiente: "https://www.linkedin.com/callback"
Y por último, de la misma pestaña "Auth", obtener y copiar el Client ID y Client Secret.

![Obtener redirect Url](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_12.png)

![Obtener keys](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/linkedin_13.png)

EN FLUTTER:

Inicializar el login de linkedin en tu proyecto, pasando como parámetros al método `SMultiLogin().multiLoginInit()` (anteriormente iniciado en `main.dart`) tu Client ID, tu Client Secret y el URI de redireccionamiento de LinkedIn, como se detalla a continuación:
```dart
await SMultiLogin().multiLoginInit(
  linkedinClientId: "TU_CLIENT_ID",
  linkedinClientSecret: "TU_CLIENT_SECRET",
  linkedinRedirectUrl: 'https://www.linkedin.com/callback',
);
```

~
### **LOGIN CON MICROSOFT:**
1) Iniciar sesión con una cuenta de Microsoft en [Microsoft Azure Portal](https://portal.azure.com/#home) y entrar en la pestaña "Azure Active Directory". Se puede entrar allí desde el dashboard o desde el menú lateral, como se muestra a continuación.

![Microsoft inicio](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/microsoft_01.png)

2) Una vez allí, ir a la pestaña "Registro de aplicaciones" y registrar una nueva aplicación. Esta debe tener un nombre y que los tipos de cuentas compatibles sean "Cuentas en cualquier directorio organizativo y cuentas de Microsoft personales". Por último, poner "Registrar".<br>
Nota: Aquí todavía no agregamos una URI de redireccionamiento.

![Ir a registro de app](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/microsoft_02.png)

![Registrar app](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/microsoft_03.png)

3) Luego, en la app, obtenemos los datos necesarios para habilitar el inicio de sesión en Firebase. Primero copiamos el "Id. de aplicación" que lo obtenemos de la pestaña "Información general" y luego, en la pestaña "Certificados y Secretos", generamos un nuevo Secreto de cliente para nuestra app y copiamos su valor.<br>
Nota importante: Copiar el VALOR del secreto, NO el Id.<br>
Además, es necesario copiarlo en ese momento, ya que una vez que salimos de la página el valor de dicho secreto ya no estará visible.

![Obtener Id de la app](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/microsoft_04.png)

![Obtener secret client](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/microsoft_05.png)

4) Ahora, en la [Consola de Firebase](https://firebase.google.com), habilitamos el inicio de sesión con Microsoft y agregamos los datos obtenidos, es decir, el Id de aplicación y el Secreto de cliente. También copiamos la URI de redireccionamiento que nos provee Firebase para agregar en nuestra app.

![Obtener secret client](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/microsoft_06.png)

![Obtener secret client](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/microsoft_07.png)

5) Finalmente, nos dirigimos a la pestaña "Autenticación" del menú lateral, ponemos "Agregar una plataforma" y es necesario elegir "Web". Aquí agregamos la URI de redireccionamiento brindada por Firebase y hacemos click en "Configurar".

![Obtener secret client](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/microsoft_08.png)

![Obtener secret client](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/microsoft_09.png)

Nota: No hacen falta configuraciones adicionales en tu proyecto Flutter para habilitar el inicio de sesión con Microsoft.

~
<br>

## **Uso de la Librería**
1) Llamar a `SMultiLoginComponent()` en tu proyecto.<br>
Nota: Se puede elegir uno de entre 4 "modos" de diseño por defecto, que son:
```dart
// Dos modos, uno minimalista y otro con más detalle respectivamente, encerrados en una Card con un estilo el cual es personalizable:
SMultiLoginComponent.simpleCardMode();
SMultiLoginComponent.complexCardMode();

// Dos modos, uno minimalista y otro con más detalle respectivamente, sin la Card mencionada anteriormente:
SMultiLoginComponent.simpleMode();
SMultiLoginComponent.complexMode();
```
Cada uno de estos "modos", a su vez, también es personalizable.

2) Especificar los parametros deseados:
  - `onResultEmailLogin` - para incluir en inicio de sesión con correo y contraseña
  - `onResultGoogleLogin` - para incluir en inicio de sesión con una cuenta de Google
  - `onResultFacebookLogin` - para incluir en inicio de sesión con una cuenta de Facebook
  - `onResultAppleLogin` - para incluir en inicio de sesión con una cuenta de Apple (pendiente)
  - `onResultTwitterLogin` - para incluir en inicio de sesión con una cuenta de Twitter
  - `onResultLinkedinLogin` - para incluir en inicio de sesión con una cuenta de LinkedIn
  - `onResultMicrosoftLogin` - para incluir en inicio de sesión con una cuenta de Microsoft

Nota: para contar con un metodo de inicio de sesión, incluir el metodo onResult deseado. En caso contrario, no incluirlo.<br>
El resto de parametros son opcionales para personalizar el diseño del componente, de ser necesario.

3) Otros Metodos disponibles:
```dart
// Para cerrar sesión en la instancia Firebase.
// LLamarlo al cerrar sesión en la app
SMultiLogin().logout();

// Para obtener información del
// usuario que inició sesión.
// Se puede usar para verificar el
// login o guardar los datos del usuario logueado:
SMultiLogin().userData(); // Trae todos lo datos del usuario, como un modelo

SMultiLogin().userData().displayName; // Trae el nombre para mostrar del usuario logueado
SMultiLogin().userData().email; // Trae el email del usuario logueado
SMultiLogin().userData().phoneNumber; // Trae el número de teléfono del usuario logueado
SMultiLogin().userData().photoURL; // Trae la URL de la foto del usuario logueado
SMultiLogin().userData().token; // Trae el token de acceso del usuario logueado

```

EJEMPLOS:
```dart
// Ejemplo de SMultiLoginComponent.simpleCardMode(), diseño por defecto e inicio de sesión a través de correo, google, facebook, twitter, linkedin y microsoft:
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
  onResultTwitterLogin: (data) {
    // código onResult Twitter
  },
  onErrorTwitterLogin: (error) {
    // código onError Twitter
  },
  onResultLinkedinLogin: (data) {
    // código onResult LinkedIn
  },
  onErrorLinkedinLogin: (error) {
    // código onError LinkedIn
  },
  onResultMicrosoftLogin: (data) {
    // código onResult Microsoft
  },
  onErrorMicrosoftLogin: (error) {
    // código onError Microsoft
  },
);
```
Imagen ilustrativa:<br>
![Imagen del componente con estilo default y login con email, google y facebook](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/usage_01.png)

```dart
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

Imagen ilustrativa:<br>
![Imagen del componente con estilo personalizado y login con email, google y facebook](https://github.com/YamiTeyssier/s-multilogin-plug/blob/development/assets/readme_images/usage_02.png)