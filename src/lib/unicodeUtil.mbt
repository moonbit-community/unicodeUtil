///|
const ReplacementChar = '\uFFFD' // Represents invalid code points.

///|
const MaxASCII = '\u007F' // maximum ASCII value.

///|
const MaxLatin1 = '\u00FF' // maximum Latin-1 value.

///|
pub(all) type UnicodeCategory Int

///|
fn op_equal(self : UnicodeCategory, other : UnicodeCategory) -> Bool {
  return self._ == other._
}

///|
pub(open) trait Eq {
  method_(UnicodeCategory) -> Int
}

///|
const UpperCase = 0

///|
const LowerCase = 1

///|
const TitleCase = 2

///|
const Digit = 9

///|
const Punct = 11

///| Unicode字符大小写转换范围
pub(all) struct CaseRange {
  lo : Int // 范围起始
  hi : Int // 范围结束
  delta1 : Int // 大写转换增量
  delta2 : Int // 小写转换增量
  delta3 : Int // 标题转换增量
}

///|
pub(all) type SpecialCase Array[CaseRange]

///|
let turkish_case : SpecialCase = [
  CaseRange::{
    lo: 0x0049,
    hi: 0x0049,
    delta1: 0,
    delta2: 0x131 - 0x49,
    delta3: 0,
  }, // I → ı (大写转小写)
  CaseRange::{
    lo: 0x0069,
    hi: 0x0069,
    delta1: 0x130 - 0x69,
    delta2: 0,
    delta3: 0x130 - 0x69,
  }, // i → İ (小写转大写)
  CaseRange::{
    lo: 0x0130,
    hi: 0x0130,
    delta1: 0,
    delta2: 0x69 - 0x130,
    delta3: 0,
  }, // İ → i (大写转小写)
  CaseRange::{
    lo: 0x0131,
    hi: 0x0131,
    delta1: 0x49 - 0x131,
    delta2: 0,
    delta3: 0x49 - 0x131,
  }, // ı → I (小写转大写)
]

///|
let azeri_case : SpecialCase = turkish_case

///|
pub fn is_digit(r : Char) -> Bool {
  // 处理ASCII和Latin1范围内的字符
  if r <= MaxLatin1 {
    return '0' <= r && r <= '9'
  }
  // 处理其他Unicode范围的数字字符
  return is_excluding_latin(Digit, r)
}

///| 检查非Latin1范围内的字符是否属于指定类别
pub fn is_excluding_latin(category : UnicodeCategory, r : Char) -> Bool {
  let code = r.to_int()

  // 处理数字类别
  if category == Digit {
    // 创建一个范围表，包含所有Unicode数字的范围
    // 每个范围是[start, end, 0]三元组
    // 0表示这是个连续范围
    let ranges = [
      // 阿拉伯数字 (Arabic-Indic digits)
      0x0660, 0x0669, 0,
      // 波斯数字 (Extended Arabic-Indic digits)
       0x06F0, 0x06F9, 0,
      // 天城文数字 (Devanagari digits)
       0x0966, 0x096F, 0,
      // 孟加拉数字 (Bengali digits)
       0x09E6, 0x09EF, 0,
      // 泰语数字 (Thai digits)
       0x0E50, 0x0E59, 0,
      // 全角数字 (Fullwidth digits)
       0xFF10, 0xFF19, 0,
      // 以下是更多Unicode数字范围，按需添加
      // 缅甸数字 (Myanmar digits)
       0x1040, 0x1049, 0,
      // 老挝数字 (Lao digits)
       0x0ED0, 0x0ED9, 0,
      // 藏文数字 (Tibetan digits)
       0x0F20, 0x0F29, 0,
      // 高棉数字 (Khmer digits)
       0x17E0, 0x17E9, 0,
      // 埃塞俄比亚数字 (Ethiopic digits)
       0x1369, 0x1371, 0,
      // 蒙古数字 (Mongolian digits)
       0x1810, 0x1819, 0,
      // 泰米尔数字 (Tamil digits)
       0x0BE6, 0x0BEF, 0,
    ]
    return search_range(ranges, code)
  }
  return false
}

///| 在排序好的范围表中搜索一个码点
fn search_range(ranges : Array[Int], target : Int) -> Bool {
  let mut i = 0
  while i < ranges.length() {
    let start = ranges[i]
    let end = ranges[i + 1]
    if target >= start && target <= end {
      return true
    }
    i = i + 3 // 跳过一个三元组
  }
  return false
}

///| 将字符转换为小写
pub fn to_lower(r : Char) -> Char {
  let code = r.to_int()

  // ASCII 范围内的快速处理
  if r <= MaxASCII {
    if 'A' <= r && r <= 'Z' {
      return Char::from_int(code + ('a'.to_int() - 'A'.to_int()))
    }
    return r
  }

  // Latin1 范围内的处理
  if r <= MaxLatin1 {
    return to_latin1_case(LowerCase, r)
  }

  // 处理特殊字符范围

  // 1. 土耳其语/阿塞拜疆语特殊字符
  if code == 0x0049 { // I → ı
    return Char::from_int(0x131)
  } else if code == 0x0130 { // İ → i
    return Char::from_int(0x69)
  }

  // 2. 希腊字母
  if code >= 0x0391 && code <= 0x03A9 {
    if code != 0x03A2 { // 排除希腊字母中间的非字母
      return Char::from_int(code + 32)
    }
  }

  // 3. 西里尔字母
  if code >= 0x0410 && code <= 0x042F {
    return Char::from_int(code + 32)
  }

  // 4. 亚美尼亚字母
  if code >= 0x0531 && code <= 0x0556 {
    return Char::from_int(code + 48)
  }

  // 5. 全角字母
  if code >= 0xFF21 && code <= 0xFF3A {
    return Char::from_int(code + 32)
  }
  // 6. - 德语大写ẞ小写转换
  if code == 0x1E9E { // 大写的ẞ (U+1E9E)
    return Char::from_int(0xDF) // 转换为小写的ß (U+00DF)
  }

  // 其他Unicode范围的处理
  return r
}

///| 将字符转换为大写
pub fn to_upper(r : Char) -> Char {
  let code = r.to_int()

  // ASCII 范围内的快速处理
  if r <= MaxASCII {
    if 'a' <= r && r <= 'z' {
      return Char::from_int(code - ('a'.to_int() - 'A'.to_int()))
    }
    return r
  }

  // Latin1 范围内的处理
  if r <= MaxLatin1 {
    return to_latin1_case(UpperCase, r)
  }

  // 处理特殊字符范围

  // 1. 土耳其语/阿塞拜疆语特殊字符
  if code == 0x0069 { // i → İ
    return Char::from_int(0x130)
  } else if code == 0x0131 { // ı → I
    return Char::from_int(0x49)
  }

  // 2. 希腊字母
  if code >= 0x03B1 && code <= 0x03C9 {
    return Char::from_int(code - 32)
  }

  // 3. 西里尔字母
  if code >= 0x0430 && code <= 0x044F {
    return Char::from_int(code - 32)
  }

  // 4. 亚美尼亚字母
  if code >= 0x0561 && code <= 0x0586 {
    return Char::from_int(code - 48)
  }

  // 5. 全角字母
  if code >= 0xFF41 && code <= 0xFF5A {
    return Char::from_int(code - 32)
  }

  // 其他Unicode范围的处理
  return r
}

///| 将字符转换为标题形式（通常与大写相同，特殊情况除外）
pub fn to_title(r : Char) -> Char {
  let code = r.to_int()

  // 大多数情况下与大写相同
  if code == 0x03C3 { // 希腊小写字母sigma的特殊处理
    return Char::from_int(0x03A3) // 希腊大写字母SIGMA
  }

  // 对于其他字符，使用大写形式
  return to_upper(r)
}

///| 处理Latin1范围内的大小写转换
fn to_latin1_case(case_type : Int, r : Char) -> Char {
  let code = r.to_int()

  // Latin1 大写字母范围: 0xC0-0xD6, 0xD8-0xDE
  // Latin1 小写字母范围: 0xE0-0xF6, 0xF8-0xFE

  if case_type == LowerCase {
    if (code >= 0xC0 && code <= 0xD6) || (code >= 0xD8 && code <= 0xDE) {
      return Char::from_int(code + 32)
    }
  } else if case_type == UpperCase {
    if (code >= 0xE0 && code <= 0xF6) || (code >= 0xF8 && code <= 0xFE) {
      return Char::from_int(code - 32)
    }

    // 特殊情况处理 - 德语ß大写转换
    if code == 0xDF { // 德语 ß
      return Char::from_int(0x1E9E) // 转换为大写的ẞ (U+1E9E)
    }
  }
  return r
}

///| 辅助函数：将字符串转换为小写
pub fn string_to_lower(s : String) -> String {
  let mut result = ""
  for i = 0; i < s.length(); i = i + 1 {
    result = result + to_lower(s[i]).to_string()
  }
  result
}

///| 辅助函数：将字符串转换为大写
pub fn string_to_upper(s : String) -> String {
  let mut result = ""
  for i = 0; i < s.length(); i = i + 1 {
    result = result + to_upper(s[i]).to_string()
  }
  result
}

///|
pub fn is_punct(r : Char) -> Bool {
  // 处理ASCII范围内的标点符号
  if r <= MaxASCII {
    // ASCII标点符号范围
    return (r >= '!' && r <= '/') || // ! " # $ % & ' ( ) * + , - . /
      (r >= ':' && r <= '@') || // : ; < = > ? @
      (r >= '[' && r <= '`') || // [ \ ] ^ _ `
      (r >= '{' && r <= '~') // { | } ~
  }

  // 处理Latin1范围内的标点符号
  if r <= MaxLatin1 {
    let code = r.to_int()

    // Latin1标点符号列表（明确列出，而非范围）
    let latin1_puncts = [
      0x00A1, // ¡ 倒置叹号
       0x00A2, // ¢ 美分符号
       0x00A3, // £ 英镑符号
       0x00A4, // ¤ 货币符号
       0x00A5, // ¥ 日元符号
       0x00A6, // ¦ 断竖线
       0x00A7, // § 章节符号
       0x00A8, // ¨ 分音符
       0x00A9, // © 版权符号
       0x00AA, // ª 阴性序数记号
       0x00AB, // « 左角引号
       0x00AC, // ¬ 否定符号
       0x00AE, // ® 注册商标
       0x00AF, // ¯ 长音符
       0x00B0, // ° 度数符号
      // 注意：0x00B1 (±) 被排除了，因为它是数学符号
       0x00B2, // ² 上标2
       0x00B3, // ³ 上标3
       0x00B4, // ´ 锐音符
       0x00B5, // µ 微符号
       0x00B6, // ¶ 段落符号
       0x00B7, // · 中点符号
       0x00B8, // ¸ 下加符
       0x00B9, // ¹ 上标1
       0x00BA, // º 阳性序数记号
       0x00BB, // » 右角引号
       0x00BC, // ¼ 四分之一
       0x00BD, // ½ 二分之一
       0x00BE, // ¾ 四分之三
       0x00BF, // ¿ 倒置问号
       0x00D7, // × 乘号
       0x00F7, // ÷ 除号
    ]

    // 检查是否在列表中
    for i = 0; i < latin1_puncts.length(); i = i + 1 {
      if code == latin1_puncts[i] {
        return true
      }
    }
    return false
  }

  // 处理其他Unicode范围的标点符号
  return is_excluding_latin_punct(r)
}

///| 检查非Latin1范围内的标点符号
fn is_excluding_latin_punct(r : Char) -> Bool {
  let code = r.to_int()

  // 排除一些特定的符号范围
  // 特殊处理某些数学运算符，将它们视为标点
  if code == 0x2260 { // ≠ (不等号)
    return true
  }
  // 排除数学运算符
  if code >= 0x2200 && code <= 0x22FF {
    return false
  }

  // 排除全角数字 (0xFF10-0xFF19)
  if code >= 0xFF10 && code <= 0xFF19 {
    return false
  }

  // 排除全角字母 (0xFF21-0xFF5A)
  if (code >= 0xFF21 && code <= 0xFF3A) || (code >= 0xFF41 && code <= 0xFF5A) {
    return false
  }

  // 判断Unicode标点符号范围
  let ranges = [
    // 常见Unicode标点符号范围

    // 一般标点
    0x2000, 0x206F, 0, // General Punctuation

    // 上标和下标
     0x2070, 0x209F, 0, // Superscripts and Subscripts (部分为标点)

    // 货币符号
     0x20A0, 0x20CF, 0, // Currency Symbols

    // 类字母符号
     0x2100, 0x214F, 0, // Letterlike Symbols

    // 数字形式
     0x2150, 0x218F, 0, // Number Forms

    // 箭头
     0x2190, 0x21FF, 0, // Arrows

    // 杂项技术符号
     0x2300, 0x23FF, 0, // Miscellaneous Technical

    // 控制图形
     0x2400, 0x243F, 0, // Control Pictures

    // 封闭字母数字
     0x2460, 0x24FF, 0, // Enclosed Alphanumerics

    // 方框制图
     0x2500, 0x257F, 0, // Box Drawing

    // 块元素
     0x2580, 0x259F, 0, // Block Elements

    // 几何形状
     0x25A0, 0x25FF, 0, // Geometric Shapes

    // 杂项符号
     0x2600, 0x26FF, 0, // Miscellaneous Symbols

    // 追加符号
     0x2E00, 0x2E7F, 0, // Supplemental Punctuation

    // CJK标点符号
     0x3000, 0x303F, 0, // CJK Symbols and Punctuation

    // 全角ASCII变体标点 - 重新定义为不包含数字和字母的范围
     0xFF00, 0xFF0F, 0, // Fullwidth ASCII variants (非字母数字部分)
     0xFF1A, 0xFF20, 0, // Fullwidth ASCII variants (非字母数字部分)
     0xFF3B, 0xFF40, 0, // Fullwidth ASCII variants (非字母数字部分)
     0xFF5B, 0xFF65, 0, // Fullwidth ASCII variants (非字母数字部分)

    // 小形变体标点
     0xFE50, 0xFE6F, 0, // Small Form Variants (标点部分)

    // 移除了过于宽泛的范围: 0xFF00, 0xFFEF
  ]

  // 检查是否在范围内
  if search_range(ranges, code) {
    return true
  }

  // 额外检查一些散布各处的标点符号
  // 这里列出一些常见单独的标点符号
  let individual_puncts = [
    0x037E, // 希腊问号
     0x0387, // 希腊中点符号
     0x055A, 0x055F, // 亚美尼亚标点
     0x0589, // 亚美尼亚全角停顿
     0x05BE, // 希伯来连字符
     0x05C0, // 希伯来标点
     0x05C3, // 希伯来标点
     0x05F3, 0x05F4, // 希伯来标点
     0x060C, 0x061B, // 阿拉伯标点
     0x061F, // 阿拉伯问号
     0x066A, 0x066D, // 阿拉伯标点
     0x06D4, // 阿拉伯标点
     0x0700, 0x070D, // 叙利亚标点
     0x0964, 0x0965, // 天城文标点
     0x0970, // 天城文标点
     0x0DF4, // 僧伽罗标点
     0x0E4F, // 泰文标点
     0x0E5A, 0x0E5B, // 泰文标点
     0x0F04, 0x0F12, // 藏文标点
     0x0F3A, 0x0F3D, // 藏文标点
     0x0F85, // 藏文标点
     0x104A, 0x104F, // 缅甸标点
     0x10FB, // 格鲁吉亚标点
  ]

  // 检查单独的标点符号
  for i = 0; i < individual_puncts.length(); i = i + 1 {
    if code == individual_puncts[i] {
      return true
    }
  }
  return false
}
