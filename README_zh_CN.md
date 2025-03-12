感谢你的反馈！确实，在 Markdown 中，使用 `-` 或 `*` 来表示列表项更为标准和常见。以下是修正后的内容：

---

# 🐱 unicodeUtil：Unicode 码点属性处理工具包

[English](https://github.com/moonbit-community/unicodeUtil/blob/master/README.md) | [简体中文](https://github.com/moonbit-community/unicodeUtil/blob/master/README_zh_CN.md)

[![Build Status](https://img.shields.io/github/actions/workflow/status/moonbit-community/unicodeUtil/ci.yml)](https://github.com/moonbit-community/unicodeUtil/actions)  [![License](https://img.shields.io/github/license/moonbit-community/unicodeUtil)](LICENSE)  [![codecov](https://codecov.io/gh/moonbit-community/NyaSearch/branch/main/graph/badge.svg)](https://codecov.io/gh/moonbit-community/unicodeUtil)  

`unicodeUtil` 是一个用于处理 Unicode 码点属性的工具包，提供了多种函数来测试 Unicode 码点的属性，包括判断字符是否为数字、大小写转换等功能。它支持多种 Unicode 字符集，适用于国际化应用开发、文本处理和字符分析。

---

## 🚀 **主要特性**

• 🔍 **Unicode 数字判断** – 支持多种 Unicode 数字表达。  
• ⚡ **大小写转换** – 支持多种 Unicode 字符的大小写转换。  
• 📍 **判断标点符号** – 支持多种 Unicode 标点符号的判断，包括常用标点（如句号、逗号）、特殊符号（如 Em dash、省略号）以及全角标点符号。  
• 🛠 **易于使用** – 提供简单的 API 便于快速集成。  
• ✅ **广泛测试** – 经过多种 Unicode 字符的测试。  
• 🔄 **开源** – 由 Moonbit 社区积极维护。  

---

## 📥 **安装**

```bash
moon add kesmeey/unicodeUtil
```

---

## 🚀 **使用指南**

`unicodeUtil` 提供了多种功能来处理 Unicode 字符的属性。以下是一些常用功能的示例：

---

### 🔍 **判断字符是否为数字**

`is_number` 函数用于判断字符是否为数字，支持多种 Unicode 数字表达( 阿拉伯数字,泰文数字,汉字数字等)。

```moonbit
fn main {
  println(@lib.is_number('0')) // true  (ASCII 数字)
  println(@lib.is_number('一')) // true (汉字的一)
  println(@lib.is_number('٩')) // true  (阿拉伯数字)
  println(@lib.is_number('か')) // false (日语假名)
}
```

---

### 🔍 **判断字符是否为字母**

`is_letter` 函数用于判断字符是否为字母，支持多种 Unicode 字母表达。

```moonbit
fn main {
  println(@lib.is_letter('A')) // true  (英文字母)
  println(@lib.is_letter('0')) // false (ASCII 非字母)
  println(@lib.is_letter('Я')) // true  (西里尔字母)
  println(@lib.is_letter('字')) // true  (中文汉字)
}
```

---

### ⚡ **大写转小写**

`to_lower` 函数用于将大写字符转换为小写，支持多种 Unicode 字符。

```moonbit
fn main {
  println(@lib.to_lower('A')) // 'a'  (ASCII 大写字母)
  println(@lib.to_lower('É')) // 'é'  (Latin1 大写字母)
  println(@lib.to_lower('Α')) // 'α'  (希腊字母)
  println(@lib.to_lower('İ')) // 'i'  (土耳其语字符)
  println(@lib.to_lower('☺')) // '☺' (非字母字符，不变)
}
```

---

### ⚡ **小写转大写**

`to_upper` 函数用于将小写字符转换为大写，支持多种 Unicode 字符。

```moonbit
fn main {
  println(@lib.to_upper('a')) // 'A'  (ASCII 小写字母)
  println(@lib.to_upper('é')) // 'É'  (Latin1 小写字母)
  println(@lib.to_upper('α')) // 'Α'  (希腊字母)
  println(@lib.to_upper('ı')) // 'I'  (土耳其语字符)
  println(@lib.to_upper('ß')) // 'ẞ'  (德语字符)
  println(@lib.to_upper('漢')) // '漢' (非字母字符，不变)
}
```

---

### 📍 **判断字符是否为标点符号**

`is_punct` 函数用于判断字符是否为标点符号，支持多种 Unicode 标点符号。

```moonbit
fn main {
  println(@lib.is_punct('—')) // true  (Em dash)
  println(@lib.is_punct('≠')) // true  (不等号)
  println(@lib.is_punct('é')) // false (非标点符号)
  println(@lib.is_punct('．')) // true  (全角句点)
  println(@lib.is_punct('？')) // true  (全角问号)
}
```

---

### 📍 **判断字符是否为标记符号**

`is_mark` 函数用于判断字符是否为标记符号，支持多种 Unicode 标记符号。

```moonbit
fn main {
  println(@lib.is_mark('\u0300')) // true  (重音符号)
  println(@lib.is_mark('\u0591')) // true  (希伯来标记)
  println(@lib.is_mark('1'))      // false (数字)
  println(@lib.is_mark('ä'))      // false (组合字符)
}
```

---

### 📍 **判断字符是否为控制字符**

`is_control` 函数用于判断字符是否为控制字符，支持多种 Unicode 控制字符。

```moonbit
fn main {
  println(@lib.is_control('\u0008')) // true  (BACKSPACE)
  println(@lib.is_control('\u200D')) // true  (ZERO WIDTH JOINER)
  println(@lib.is_control('1'))      // false (数字)
  println(@lib.is_control('\u2022')) // false (圆点符号)
}
```

---

### 📍 **判断字符是否为空白字符**

`is_space` 函数用于判断字符是否为空白字符，支持多种 Unicode 空白字符。

```moonbit
fn main {
  println(@lib.is_space(' '))       // true  (空格)
  println(@lib.is_space('\u2000')) // true  (半角空格)
  println(@lib.is_space('6'))       // false (数字)
  println(@lib.is_space('.'))       // false (标点符号)
}
```

---

### 📍 **判断字符是否为符号**

`is_symbol` 函数用于判断字符是否为符号（数学符号、货币符号等），支持多种 Unicode 符号。

```moonbit
fn main {
  println(@lib.is_symbol('$')) // true  (美元符号)
  println(@lib.is_symbol('¢')) // true  (美分符号)
  println(@lib.is_symbol('6')) // true  (几何符号)
  println(@lib.is_symbol('字')) // false (汉字)
}
```

---

## 📜 **许可证**

本项目遵循 Apache-2.0 许可证。详情请参阅 [LICENSE](https://github.com/moonbit-community/unicodeUtil/blob/main/LICENSE)。

---

## 📢 **联系与支持**

• Moonbit 社区: [moonbit-community](https://github.com/moonbit-community)  
• GitHub 问题: [报告问题](https://github.com/moonbit-community/unicodeUtil/issues)  

👋 如果你喜欢这个项目，请给它一个 ⭐！祝编码愉快！ 🚀  

---

