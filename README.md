# 📦 Flutter Barcode Scanner
A mobile application built with Flutter that scans product barcodes and fetches detailed nutritional information from the Open Food Facts API.

# 📖 Introduction
This project serves as a practical demonstration of integrating a barcode scanner with a RESTful API in a Flutter application. The app allows users to scan a product's barcode (EAN or UPC) and instantly retrieve its name and nutritional data, including calories, proteins, carbohydrates, fat, and sugars. This showcases a complete end-to-end process, from user input and data fetching to robust error handling and UI state management.

# ✨ Features
* Barcode Scanning: Uses the flutter_barcode_scanner package to perform one-time scans of product barcodes.

* API Integration: Fetches product information and nutritional data by making HTTP GET requests to the Open Food Facts API.

* Dynamic Data Display: Parses the JSON response to extract and display key product details.

* Loading Indicator: Provides a smooth user experience with a CircularProgressIndicator while data is being fetched.

* Robust Error Handling: Gracefully handles various network and API errors, including canceled scans, product not found, and failed network requests.

* Simple UI: Features a clean, straightforward interface that focuses on core functionality.

# 🛠 Tech Stack
* Flutter & Dart: The core framework and language for building the application.

* flutter_barcode_scanner: A powerful plugin for handling barcode and QR code scanning.

* http: The package used to make network requests to the REST API.

* dart:convert: Used for decoding the JSON data received from the API.

# 🚀 Getting Started
✅ Prerequisites
* Flutter SDK installed on your machine.

* An IDE with Flutter support (e.g., Android Studio, VS Code).

* A physical Android or iOS device, or an emulator/simulator with camera access.

# ⚙️ Installation
* Clone the repository:

```
git clone [https://github.com/TalipTun/Flutter_Barcode_Scanner.git](https://github.com/TalipTun/Flutter_Barcode_Scanner.git)
cd Flutter_Barcode_Scanner
```
* Install the dependencies:

``` flutter pub get ```

* Ensure your device has camera permissions enabled.

* Run the app:

``` flutter run ```

# 🧠 Learning Highlights
This project was a valuable opportunity to apply several key concepts of Flutter and mobile development:

* Asynchronous Programming: Mastered the use of async/await to handle network requests without freezing the UI, providing a responsive and fluid experience.

* API Integration: Gained practical experience in connecting a mobile app to a third-party API, formulating requests, and interpreting the structure of the JSON response.

* State Management: Utilized StatefulWidget and setState to manage the app's state, such as displaying a loading indicator or updating the results text.

* Robust Error Handling: Implemented try-catch blocks and checked response.statusCode to handle potential issues and provide clear feedback to the user.

# 👤 Author
Talip Tun

* LinkedIn

* GitHub

# 📄 License
This project is licensed under the MIT License.

GitHub

License
This project is licensed under the MIT License.
