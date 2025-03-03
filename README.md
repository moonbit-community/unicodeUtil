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

大写转小写（支持多种Unicode字符）

```
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
  
  // 西里尔字母
  println(@lib.to_lower('А')) // 'а' (Cyrillic A)
  println(@lib.to_lower('Я')) // 'я' (Cyrillic Ya)
  
  // 亚美尼亚字母
  println(@lib.to_lower('Ա')) // 'ա' (Ayb)
  
  // 全角字母
  println(@lib.to_lower('Ａ')) // 'ａ'
  
  // 特殊土耳其语字符
  println(@lib.to_lower('İ')) // 'i' (I with dot)
  
  // 非字母Unicode字符
  println(@lib.to_lower('漢')) // '漢' (unchanged)
  println(@lib.to_lower('☺')) // '☺' (unchanged)
}

```

小写转大写（支持多种Unicode字符）

```
fn main {
    // ASCII 小写字母
  println(@lib.to_upper('a')) // 'A'
  println(@lib.to_upper('z')) // 'Z'
 
  // ASCII 非字母字符
  println(@lib.to_upper('0')) // '0'
  println(@lib.to_upper('!')) // '!'
  
  // Latin1 小写字母
  println(@lib.to_upper('é')) // 'É'
  println(@lib.to_upper('ñ')) // 'Ñ'
  println(@lib.to_upper('ö')) // 'Ö'
  
  // 希腊字母
  println(@lib.to_upper('α')) // 'Α' (alpha)
  println(@lib.to_upper('ω')) // 'Ω' (omega)
  
  // 西里尔字母
  println(@lib.to_upper('а')) // 'А' (cyrillic a)
  println(@lib.to_upper('я')) // 'Я' (cyrillic ya)
  
  // 亚美尼亚字母
  println(@lib.to_upper('ա')) // 'Ա' (ayb)
  
  // 全角字母
  println(@lib.to_upper('ａ')) // 'Ａ'
  
  // 特殊土耳其语字符
  println(@lib.to_upper('ı')) // 'I' (dotless i)
  
  // 特殊德语字符
  println(@lib.to_upper('ß')) // 'S' (简化实现，实际应该是"SS")
  
  // 非字母Unicode字符
  println(@lib.to_upper('漢')) // '漢' (unchanged)
  println(@lib.to_upper('☺')) // '☺' (unchanged)
  
}

```

