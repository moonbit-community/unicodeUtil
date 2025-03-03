# unicodeUtil 

`unicodeUtil` 是一个用于处理 Unicode 码点属性的工具包，提供了多种函数来测试 Unicode 码点的属性。

判断字符是否数字（支持多种Unicode数字表达）

```
fn main {
  // ASCII 数字 (0-9)
  println(@lib.is_digit('0'))//true
  // ASCII 非数字字符
  println(@lib.is_digit('a'))//false
  // Latin1 范围内非数字字符
  println(@lib.is_digit('é'))//false
  // Unicode 数字
 // 阿拉伯数字 (Arabic-Indic digits)
  println(@lib.is_digit('٩')) // 阿拉伯中的9  true
  // 波斯数字 (Persian digits)
  println(@lib.is_digit('۵'))//波斯数字的5 true
   // 天城文数字 (Devanagari digits)
  println(@lib.is_digit('५'))//天城文数字5 true
  // 泰文数字 (Thai digits)
  println(@lib.is_digit('๕'))//泰文数字5 true
   // Unicode 非数字字符
 println(@lib.is_digit('か'))  // 日语假名  false
    // 边界测试
    println(@lib.is_digit('\u0000'))  // NULL字符  false
}

```

