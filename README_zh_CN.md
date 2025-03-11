# 🐱 unicodeUtil：Unicode 码点属性处理工具包

[English](https://github.com/moonbit-community/unicodeUtil/blob/master/README.md) | [简体中文](https://github.com/moonbit-community/unicodeUtil/blob/master/README_zh_CN.md)

[![Build Status](https://img.shields.io/github/actions/workflow/status/moonbit-community/unicodeUtil/ci.yml)](https://github.com/moonbit-community/unicodeUtil/actions)
[![License](https://img.shields.io/github/license/moonbit-community/unicodeUtil)](LICENSE)
[![codecov](https://codecov.io/gh/moonbit-community/NyaSearch/branch/main/graph/badge.svg)](https://codecov.io/gh/moonbit-community/unicodeUtil)

`unicodeUtil` 是一个用于处理 Unicode 码点属性的工具包，提供了多种函数来测试 Unicode 码点的属性，包括判断字符是否为数字、大小写转换等功能。它支持多种 Unicode 字符集，适用于国际化应用开发、文本处理和字符分析。


🚀 **主要特性**

• 🔍 **Unicode 数字判断** – 支持多种 Unicode 数字表达。

• ⚡ **大小写转换** – 支持多种 Unicode 字符的大小写转换。

• 📍 ​判断标点符号 – 支持多种 Unicode 标点符号的判断，包括常用标点（如句号、逗号）、特殊符号（如 Em dash、省略号）以及全角标点符号。

• 🛠 **易于使用** – 提供简单的 API 便于快速集成。

• ✅ **广泛测试** – 经过多种 Unicode 字符的测试。

• 🔄 **开源** – 由 Moonbit 社区积极维护。

---

## 📥 安装

```
moon add kesmeey/unicodeUtil
```

## **🚀 `unicodeUtil` 使用指南**

`unicodeUtil` 提供了多种功能来处理 Unicode 字符的属性。你可以使用它来判断字符是否为数字，或者进行大小写转换。

---

### **🔍 判断字符是否为数字**

`is_digit` 函数用于判断字符是否为数字，支持多种 Unicode 数字表达。

```moonbit
fn main {
  // ASCII 数字 (0-9)
  println(@lib.is_digit('0')) // true
  // ASCII 非数字字符
  println(@lib.is_digit('a')) // false
  // 阿拉伯中的9 
  println(@lib.is_digit('٩')) // true
  // Unicode 非数字字符 日语假名  
  println(@lib.is_digit('か')) // false
}
```

---

### **🎯 大写转小写**

`to_lower` 函数用于将大写字符转换为小写，支持多种 Unicode 字符。

```moonbit
fn main {
  // ASCII 大写字母
  println(@lib.to_lower('A')) // 'a'
  println(@lib.to_lower('Z')) // 'z'
  
  // Latin1 大写字母
  println(@lib.to_lower('É')) // 'é'
  println(@lib.to_lower('Ñ')) // 'ñ'
  println(@lib.to_lower('Ö')) // 'ö'
  
  // 希腊字母
  println(@lib.to_lower('Α')) // 'α' (Alpha)
  println(@lib.to_lower('Ω')) // 'ω' (Omega)
  
  // 特殊土耳其语字符
  println(@lib.to_lower('İ')) // 'i' (I with dot)
  
  // 非字母Unicode字符
  println(@lib.to_lower('☺')) // '☺' (unchanged)
}
```

---

### **🎯 小写转大写**

`to_upper` 函数用于将小写字符转换为大写，支持多种 Unicode 字符。

```moonbit
fn main {
  // ASCII 小写字母
  println(@lib.to_upper('a')) // 'A'
  println(@lib.to_upper('z')) // 'Z'
 
  // Latin1 小写字母
  println(@lib.to_upper('é')) // 'É'
  println(@lib.to_upper('ñ')) // 'Ñ'
  println(@lib.to_upper('ö')) // 'Ö'
  
  // 希腊字母
  println(@lib.to_upper('α')) // 'Α' (alpha)
  println(@lib.to_upper('ω')) // 'Ω' (omega)
  
  // 特殊土耳其语字符
  println(@lib.to_upper('ı')) // 'I' (dotless i)
  
  // 特殊德语字符
  println(@lib.to_upper('ß')) // 'ẞ' (简化实现，实际应该是"SS")
  
  // 非字母Unicode字符
  println(@lib.to_upper('漢')) // '漢' (unchanged)
}
```
---

### **🎯 判断**

`to_upper` 函数用于将小写字符转换为大写，支持多种 Unicode 字符。

```moonbit
fn main {
  // ASCII 小写字母
  println(@lib.to_upper('a')) // 'A'
  println(@lib.to_upper('z')) // 'Z'
 
  // Latin1 小写字母
  println(@lib.to_upper('é')) // 'É'
  println(@lib.to_upper('ñ')) // 'Ñ'
  println(@lib.to_upper('ö')) // 'Ö'
  
  // 希腊字母
  println(@lib.to_upper('α')) // 'Α' (alpha)
  println(@lib.to_upper('ω')) // 'Ω' (omega)
  
  // 特殊土耳其语字符
  println(@lib.to_upper('ı')) // 'I' (dotless i)
  
  // 特殊德语字符
  println(@lib.to_upper('ß')) // 'ẞ' (简化实现，实际应该是"SS")
  
  // 非字母Unicode字符
  println(@lib.to_upper('漢')) // '漢' (unchanged)
}
```

---


### **🎯 判断字符是否为标点符号**
`is_punct`  函数用于判断字符是否为标点符号，支持多种 Unicode 标点符号。

```moonbit
fn main {
  // Unicode 标点符号测试
  println(@lib.is_punct('—')) // true, Em dash
  println(@lib.is_punct('≠')) // true, 不等号

  // 非标点符号
  println(@lib.is_punct('é')) // false
  println(@lib.is_punct('±')) // false, 加减号通常被视为数学符号而非标点

  // 全角ASCII标点
  println(@lib.is_punct('．')) // true, 全角句点
  println(@lib.is_punct('？')) // true, 全角问号
}
```
---

### **🛠 完整示例**

```moonbit
fn main {
  // 判断字符是否为数字
  println(@lib.is_digit('5')) // true
  println(@lib.is_digit('五')) // true

  // 大写转小写
  println(@lib.to_lower('É')) // 'é'
  println(@lib.to_lower('Ω')) // 'ω'

  // 小写转大写
  println(@lib.to_upper('ß')) // 'ẞ'
  println(@lib.to_upper('α')) // 'Α'

 //判断是否为标点符号
 println(@lib.is_punct('—')) // true, Em dash
 println(@lib.is_punct('？')) // true, 全角问号
}
```

🎉 **现在你已经可以使用 `unicodeUtil` 进行 Unicode 字符属性处理了！** 🚀

## 📜 许可证

本项目遵循 Apache-2.0 许可证。详情请参阅 [LICENSE](https://github.com/moonbit-community/unicodeUtil/blob/main/LICENSE)。

## 📢 联系与支持

• Moonbit 社区: [moonbit-community](https://github.com/moonbit-community)
• GitHub 问题: [报告问题](https://github.com/moonbit-community/unicodeUtil/issues)

👋 如果你喜欢这个项目，请给它一个 ⭐！祝编码愉快！ 🚀