# 🐱 unicodeUtil: Unicode Codepoint Property Handling Toolkit

[English](https://github.com/moonbit-community/unicodeUtil/blob/master/README.md) | [简体中文](https://github.com/moonbit-community/unicodeUtil/blob/master/README_zh_CN.md)

[![Build Status](https://img.shields.io/github/actions/workflow/status/moonbit-community/unicodeUtil/ci.yml)](https://github.com/moonbit-community/unicodeUtil/actions)  [![License](https://img.shields.io/github/license/moonbit-community/unicodeUtil)](LICENSE)  [![codecov](https://codecov.io/gh/moonbit-community/NyaSearch/branch/main/graph/badge.svg)](https://codecov.io/gh/moonbit-community/unicodeUtil)  

`unicodeUtil` is a toolkit for handling Unicode codepoint properties, providing various functions to test the properties of Unicode codepoints, including checking if a character is a number, case conversion, and more. It supports multiple Unicode character sets and is suitable for internationalized application development, text processing, and character analysis.

---

## 🚀 **Key Features**

• 🔍 **Unicode Number Check** – Supports multiple Unicode number representations.  
• ⚡ **Case Conversion** – Supports case conversion for various Unicode characters.  
• 📍 **Punctuation Check** – Supports checking for various Unicode punctuation marks, including common punctuation (e.g., periods, commas), special symbols (e.g., Em dash, ellipsis), and full-width punctuation.  
• 🛠 **Easy to Use** – Provides a simple API for quick integration.  
• ✅ **Extensively Tested** – Tested with a wide range of Unicode characters.  
• 🔄 **Open Source** – Actively maintained by the Moonbit community.  

---

## 📥 **Installation**

```bash
moon add kesmeey/unicodeUtil
```

---

## 🚀 **Usage Guide**

`unicodeUtil` offers various functions to handle the properties of Unicode characters. Below are some examples of commonly used features:

---

### 🔍 **Check if a Character is a Number**

The `is_number` function checks if a character is a number, supporting multiple Unicode number representations (e.g., Arabic numerals, Thai numerals, Chinese numerals, etc.).

```moonbit
fn main {
  println(@lib.is_number('0')) // true  (ASCII number)
  println(@lib.is_number('一')) // true (Chinese numeral)
  println(@lib.is_number('٩')) // true  (Arabic numeral)
  println(@lib.is_number('か')) // false (Japanese kana)
}
```

---

### 🔍 **Check if a Character is a Letter**

The `is_letter` function checks if a character is a letter, supporting multiple Unicode letter representations.

```moonbit
fn main {
  println(@lib.is_letter('A')) // true  (English letter)
  println(@lib.is_letter('0')) // false (ASCII non-letter)
  println(@lib.is_letter('Я')) // true  (Cyrillic letter)
  println(@lib.is_letter('字')) // true  (Chinese character)
}
```

---

### ⚡ **Convert to Lowercase**

The `to_lower` function converts uppercase characters to lowercase, supporting various Unicode characters.

```moonbit
fn main {
  println(@lib.to_lower('A')) // 'a'  (ASCII uppercase letter)
  println(@lib.to_lower('É')) // 'é'  (Latin1 uppercase letter)
  println(@lib.to_lower('Α')) // 'α'  (Greek letter)
  println(@lib.to_lower('İ')) // 'i'  (Turkish character)
  println(@lib.to_lower('☺')) // '☺' (Non-letter character, unchanged)
}
```

---

### ⚡ **Convert to Uppercase**

The `to_upper` function converts lowercase characters to uppercase, supporting various Unicode characters.

```moonbit
fn main {
  println(@lib.to_upper('a')) // 'A'  (ASCII lowercase letter)
  println(@lib.to_upper('é')) // 'É'  (Latin1 lowercase letter)
  println(@lib.to_upper('α')) // 'Α'  (Greek letter)
  println(@lib.to_upper('ı')) // 'I'  (Turkish character)
  println(@lib.to_upper('ß')) // 'ẞ'  (German character)
  println(@lib.to_upper('漢')) // '漢' (Non-letter character, unchanged)
}
```

---

### 📍 **Check if a Character is Punctuation**

The `is_punct` function checks if a character is punctuation, supporting various Unicode punctuation marks.

```moonbit
fn main {
  println(@lib.is_punct('—')) // true  (Em dash)
  println(@lib.is_punct('≠')) // true  (Not equal sign)
  println(@lib.is_punct('é')) // false (Non-punctuation character)
  println(@lib.is_punct('．')) // true  (Full-width period)
  println(@lib.is_punct('？')) // true  (Full-width question mark)
}
```

---

### 📍 **Check if a Character is a Mark**

The `is_mark` function checks if a character is a mark, supporting various Unicode marks.

```moonbit
fn main {
  println(@lib.is_mark('\u0300')) // true  (Accent mark)
  println(@lib.is_mark('\u0591')) // true  (Hebrew mark)
  println(@lib.is_mark('1'))      // false (Number)
  println(@lib.is_mark('ä'))      // false (Combining character)
}
```

---

### 📍 **Check if a Character is a Control Character**

The `is_control` function checks if a character is a control character, supporting various Unicode control characters.

```moonbit
fn main {
  println(@lib.is_control('\u0008')) // true  (BACKSPACE)
  println(@lib.is_control('\u200D')) // true  (ZERO WIDTH JOINER)
  println(@lib.is_control('1'))      // false (Number)
  println(@lib.is_control('\u2022')) // false (Bullet symbol)
}
```

---

### 📍 **Check if a Character is a Whitespace Character**

The `is_space` function checks if a character is a whitespace character, supporting various Unicode whitespace characters.

```moonbit
fn main {
  println(@lib.is_space(' '))       // true  (Space)
  println(@lib.is_space('\u2000')) // true  (En space)
  println(@lib.is_space('6'))       // false (Number)
  println(@lib.is_space('.'))       // false (Punctuation)
}
```

---

### 📍 **Check if a Character is a Symbol**

The `is_symbol` function checks if a character is a symbol (e.g., mathematical symbols, currency symbols), supporting various Unicode symbols.

```moonbit
fn main {
  println(@lib.is_symbol('$')) // true  (Dollar sign)
  println(@lib.is_symbol('¢')) // true  (Cent sign)
  println(@lib.is_symbol('6')) // true  (Geometric symbol)
  println(@lib.is_symbol('字')) // false (Chinese character)
}
```

---

## 📜 **License**

This project is licensed under the Apache-2.0 License. For details, see [LICENSE](https://github.com/moonbit-community/unicodeUtil/blob/main/LICENSE).

---

## 📢 **Contact & Support**

• Moonbit Community: [moonbit-community](https://github.com/moonbit-community)  
• GitHub Issues: [Report Issues](https://github.com/moonbit-community/unicodeUtil/issues)  

👋 If you like this project, give it a ⭐! Happy coding! 🚀  

---