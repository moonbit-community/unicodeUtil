Here’s the English translation of the content, maintaining clarity and adhering to Markdown standards:

---

# 🐱 unicodeUtil: Unicode Code Point Property Toolkit

[English](https://github.com/moonbit-community/unicodeUtil/blob/master/README.md) | [简体中文](https://github.com/moonbit-community/unicodeUtil/blob/master/README_zh_CN.md)

[![Build Status](https://img.shields.io/github/actions/workflow/status/moonbit-community/unicodeUtil/ci.yml)](https://github.com/moonbit-community/unicodeUtil/actions) [![License](https://img.shields.io/github/license/moonbit-community/unicodeUtil)](LICENSE)  [![codecov](https://codecov.io/gh/moonbit-community/NyaSearch/branch/main/graph/badge.svg)](https://codecov.io/gh/moonbit-community/unicodeUtil)  

`unicodeUtil` is a toolkit for handling Unicode code point properties. It provides various functions to test Unicode code point attributes, such as checking if a character is a number, converting case, and more. It supports multiple Unicode character sets and is suitable for internationalization, text processing, and character analysis.

---

## 🚀 **Key Features**

• 🔍 **Unicode Number Detection** – Supports multiple Unicode number representations.  
• ⚡ **Case Conversion** – Supports case conversion for various Unicode characters.  
• 📍 **Punctuation Detection** – Supports detection of various Unicode punctuation marks, including common punctuation (e.g., periods, commas), special symbols (e.g., Em dash, ellipsis), and full-width punctuation.  
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

`unicodeUtil` offers a variety of functions to handle Unicode character properties. Below are examples of some commonly used features:

---

### 🔍 **Check if a Character is a Number**

The `is_number` function checks if a character is a number, supporting various Unicode number representations (e.g., Arabic numerals, Thai numerals, Chinese numerals).

```moonbit
fn main {
  println(@lib.is_number('0')) // true  (ASCII number)
  println(@lib.is_number('一')) // true  (Chinese numeral)
  println(@lib.is_number('٩')) // true  (Arabic numeral)
  println(@lib.is_number('か')) // false (Japanese kana)
}
```

---

### 🔍 **Check if a Character is a Letter**

The `is_letter` function checks if a character is a letter, supporting various Unicode letter representations.

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
  println(@lib.to_lower('☺')) // '☺' (non-letter character, unchanged)
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
  println(@lib.to_upper('漢')) // '漢' (non-letter character, unchanged)
}
```

---

### 📍 **Check if a Character is Punctuation**

The `is_punct` function checks if a character is punctuation, supporting various Unicode punctuation marks.

```moonbit
fn main {
  println(@lib.is_punct('—')) // true  (Em dash)
  println(@lib.is_punct('≠')) // true  (Not equal sign)
  println(@lib.is_punct('é')) // false (non-punctuation character)
  println(@lib.is_punct('．')) // true  (full-width period)
  println(@lib.is_punct('？')) // true  (full-width question mark)
}
```

---

### 📍 **Check if a Character is a Mark**

The `is_mark` function checks if a character is a mark, supporting various Unicode marks.

```moonbit
fn main {
  println(@lib.is_mark('\u0300')) // true  (accent mark)
  println(@lib.is_mark('\u0591')) // true  (Hebrew mark)
  println(@lib.is_mark('1'))      // false (number)
  println(@lib.is_mark('ä'))      // false (composed character)
}
```

---

### 📍 **Check if a Character is a Control Character**

The `is_control` function checks if a character is a control character, supporting various Unicode control characters.

```moonbit
fn main {
  println(@lib.is_control('\u0008')) // true  (BACKSPACE)
  println(@lib.is_control('\u200D')) // true  (ZERO WIDTH JOINER)
  println(@lib.is_control('1'))      // false (number)
  println(@lib.is_control('\u2022')) // false (bullet symbol)
}
```

---

### 📍 **Check if a Character is Whitespace**

The `is_space` function checks if a character is whitespace, supporting various Unicode whitespace characters.

```moonbit
fn main {
  println(@lib.is_space(' '))       // true  (space)
  println(@lib.is_space('\u2000')) // true  (half-width space)
  println(@lib.is_space('6'))       // false (number)
  println(@lib.is_space('.'))       // false (punctuation)
}
```

---

### 📍 **Check if a Character is a Symbol**

The `is_symbol` function checks if a character is a symbol (e.g., mathematical symbols, currency symbols), supporting various Unicode symbols.

```moonbit
fn main {
  println(@lib.is_symbol('$')) // true  (dollar sign)
  println(@lib.is_symbol('¢')) // true  (cent sign)
  println(@lib.is_symbol('6')) // true  (geometric symbol)
  println(@lib.is_symbol('字')) // false (Chinese character)
}
```

---

### 📍 **Check if a Character is Printable**

The `is_print` function checks if a character is printable (e.g., letters, Chinese characters), supporting various Unicode symbols.

```moonbit
fn main {
  println(@lib.is_print('a')) // true  (letter 'a')
  println(@lib.is_print('.')) // true  (punctuation '.')
  println(@lib.is_print('梦')) // true  (Chinese character '梦')
  println(@lib.is_print('\n')) // false (newline is not printable)
}
```

---

### 📍 **Check if a Character is Graphic**

The `is_graphic` function checks if a character is graphic (e.g., letters, Chinese characters), supporting various Unicode symbols.

```moonbit
fn main {
  println(@lib.is_graphic('a')) // true  (letter 'a')
  println(@lib.is_graphic('\u0300')) // true  (combining accent mark)
  println(@lib.is_graphic('$')) // true  (dollar sign)
  println(@lib.is_graphic('u0000')) // false (NULL)
}
```

---

## 📜 **License**

This project is licensed under the Apache-2.0 License. See [LICENSE](https://github.com/moonbit-community/unicodeUtil/blob/main/LICENSE) for details.

---

## 📢 **Contact & Support**

• Moonbit Community: [moonbit-community](https://github.com/moonbit-community)  
• GitHub Issues: [Report an Issue](https://github.com/moonbit-community/unicodeUtil/issues)  

👋 If you like this project, give it a ⭐! Happy coding! 🚀  

---

