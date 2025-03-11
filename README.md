# 🐱 unicodeUtil: Unicode Code Point Property Utility

[English](https://github.com/moonbit-community/unicodeUtil/blob/main/README.md) | [简体中文](https://github.com/moonbit-community/unicodeUtil/blob/main/README_zh_CN.md)

[![Build Status](https://img.shields.io/github/actions/workflow/status/moonbit-community/unicodeUtil/ci.yml)](https://github.com/moonbit-community/unicodeUtil/actions)
[![License](https://img.shields.io/github/license/moonbit-community/unicodeUtil)](LICENSE)
[![codecov](https://codecov.io/gh/moonbit-community/NyaSearch/branch/main/graph/badge.svg)](https://codecov.io/gh/moonbit-community/unicodeUtil)

`unicodeUtil` is a utility package for handling Unicode code point properties. It provides various functions to test Unicode code point attributes, including checking if a character is a digit and converting between uppercase and lowercase. It supports multiple Unicode character sets and is suitable for internationalization, text processing, and character analysis.

🚀 **Key Features**
• 🔍 **Unicode Digit Check** – Supports various Unicode digit representations.
• ⚡ **Case Conversion** – Supports case conversion for multiple Unicode characters.
• 🛠 **Easy to Use** – Provides a simple API for quick integration.
• ✅ **Extensively Tested** – Tested with a wide range of Unicode characters.
• 🔄 **Open Source** – Actively maintained by the Moonbit community.

---

## 📥 Installation

```
moon add kesmeey/unicodeUtil
```

## **🚀 `unicodeUtil` Usage Guide**

`unicodeUtil` offers various functions to handle Unicode character properties. You can use it to check if a character is a digit or perform case conversion.

---

### **🔍 Check if a Character is a Digit**

The `is_digit` function checks if a character is a digit, supporting various Unicode digit representations.

```moonbit
fn main {
  // ASCII digits (0-9)
  println(@lib.is_digit('0')) // true
  // ASCII non-digit characters
  println(@lib.is_digit('a')) // false
  // Arabic-Indic digit (9)
  println(@lib.is_digit('٩')) // true
  // Unicode non-digit character (Japanese kana)
  println(@lib.is_digit('か')) // false
}
```

---

### **🎯 Convert Uppercase to Lowercase**

The `to_lower` function converts uppercase characters to lowercase, supporting multiple Unicode characters.

```moonbit
fn main {
  // ASCII uppercase letters
  println(@lib.to_lower('A')) // 'a'
  println(@lib.to_lower('Z')) // 'z'
  
  // Latin1 uppercase letters
  println(@lib.to_lower('É')) // 'é'
  println(@lib.to_lower('Ñ')) // 'ñ'
  println(@lib.to_lower('Ö')) // 'ö'
  
  // Greek letters
  println(@lib.to_lower('Α')) // 'α' (Alpha)
  println(@lib.to_lower('Ω')) // 'ω' (Omega)
  
  // Special Turkish character
  println(@lib.to_lower('İ')) // 'i' (I with dot)
  
  // Non-letter Unicode character
  println(@lib.to_lower('☺')) // '☺' (unchanged)
}
```

---

### **🎯 Convert Lowercase to Uppercase**

The `to_upper` function converts lowercase characters to uppercase, supporting multiple Unicode characters.

```moonbit
fn main {
  // ASCII lowercase letters
  println(@lib.to_upper('a')) // 'A'
  println(@lib.to_upper('z')) // 'Z'
 
  // Latin1 lowercase letters
  println(@lib.to_upper('é')) // 'É'
  println(@lib.to_upper('ñ')) // 'Ñ'
  println(@lib.to_upper('ö')) // 'Ö'
  
  // Greek letters
  println(@lib.to_upper('α')) // 'Α' (alpha)
  println(@lib.to_upper('ω')) // 'Ω' (omega)
  
  // Special Turkish character
  println(@lib.to_upper('ı')) // 'I' (dotless i)
  
  // Special German character
  println(@lib.to_upper('ß')) // 'ẞ' (simplified implementation, should be "SS")
  
  // Non-letter Unicode character
  println(@lib.to_upper('漢')) // '漢' (unchanged)
}
```

---

### **🛠 Complete Example**

```moonbit
fn main {
  // Check if a character is a digit
  println(@lib.is_digit('5')) // true
  println(@lib.is_digit('五')) // true

  // Convert uppercase to lowercase
  println(@lib.to_lower('É')) // 'é'
  println(@lib.to_lower('Ω')) // 'ω'

  // Convert lowercase to uppercase
  println(@lib.to_upper('ß')) // 'ẞ'
  println(@lib.to_upper('α')) // 'Α'
}
```

🎉 **Now you can use `unicodeUtil` for Unicode character property handling!** 🚀

## 📜 License

This project is licensed under the Apache-2.0 License. See [LICENSE](https://github.com/moonbit-community/unicodeUtil/blob/main/LICENSE) for details.

## 📢 Contact & Support

• Moonbit Community: [moonbit-community](https://github.com/moonbit-community)
• GitHub Issues: [Report an Issue](https://github.com/moonbit-community/unicodeUtil/issues)

👋 If you like this project, give it a ⭐! Happy coding! 🚀