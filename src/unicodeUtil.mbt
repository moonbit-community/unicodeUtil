///| Unicode 字符处理工具库
///| 提供字符分类、大小写转换等功能

///| Unicode 字符类别定义
pub(all) type UnicodeCategory Int

///|
fn op_equal(self : UnicodeCategory, other : UnicodeCategory) -> Bool {
  return self._ == other._
}

///|
pub(open) trait Eq {
  method_(UnicodeCategory) -> Int
}

///| 大写字母类别
pub const UpperCase = 0

///| 小写字母类别
pub const LowerCase = 1

///| 标题形式字母类别
pub const TitleCase = 2

///| 字母类别（通用）
pub const Letter = 3

///| 数字类别
pub const Digit = 4

///| 标点符号类别
pub const Punct = 5

///| 标记符号类别
pub const Mark = 6

///| 空白字符类别
pub const Space = 7

///| 控制字符类别
pub const Control = 8

///| 符号类别
pub const Symbol = 9

///| 数字类别（扩展）
pub const Number = 10

///| 图形字符类别
pub const Graphic = 11

///| 可打印字符类别
pub const Print = 12

///| Unicode 字符大小写转换范围
pub(all) struct CaseRange {
  lo : Int // 范围起始
  hi : Int // 范围结束
  delta1 : Int // 大写转换增量
  delta2 : Int // 小写转换增量
  delta3 : Int // 标题转换增量
}

///| 特殊大小写转换规则
pub(all) type SpecialCase Array[CaseRange]

///| 阿塞拜疆语大小写转换规则（与土耳其语相同）
let azeri_case : SpecialCase = turkish_case

///| 检查字符是否在指定的码点范围内
///| ranges格式: [start1, end1, start2, end2, ...]
fn in_ranges(code : Int, ranges : Array[Int]) -> Bool {
  let mut i = 0
  while i < ranges.length() {
    if i + 1 < ranges.length() {
      if code >= ranges[i] && code <= ranges[i + 1] {
        return true
      }
      i = i + 2
    } else {
      // 处理单个码点的情况
      if code == ranges[i] {
        return true
      }
      i = i + 1
    }
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

///| 判断字符是否为数字（基本数字0-9及全角数字０-９）
pub fn is_digit(r : Char) -> Bool {
  let code = r.to_int()

  // 处理ASCII范围内的基本数字0-9
  if '0' <= r && r <= '9' {
    return true
  }

  // 全角数字０-９也算作基本数字
  if code >= 0xFF10 && code <= 0xFF19 {
    return true
  }

  // 封闭数字、分数、罗马数字等特殊形式不算基本数字
  if (code >= 0x2460 && code <= 0x2473) || // 圆圈数字①-⑳
    (code >= 0x2474 && code <= 0x2487) || // 括号数字⑴-⒇
    (code >= 0x2153 && code <= 0x215E) || // 分数符号
    (code >= 0x2160 && code <= 0x2188) { // 罗马数字
    return false
  }

  // 处理其他Unicode范围的数字字符
  return is_excluding_latin(Digit, r)
}

///| 检查非Latin1范围内的字符是否属于指定类别
pub fn is_excluding_latin(category : UnicodeCategory, r : Char) -> Bool {
  let code = r.to_int()

  // 处理不同的Unicode类别
  if category == Digit {
    return search_range(numRanges, code)
  } else if category == Letter {
    // 实现字母类别的检查
    return false // 此处需要实现
  } else if category == Mark {
    // 实现标记类别的检查
    return false // 此处需要实现
  } else if category == Number {
    // 实现扩展数字类别的检查
    return false // 此处需要实现
  } else if category == Punct {
    // 实现标点类别的检查
    return false // 此处需要实现
  } else if category == Symbol {
    // 实现符号类别的检查
    return false // 此处需要实现
  } else if category == Space {
    // 实现空白类别的检查
    return false // 此处需要实现
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

  // 特殊字符处理

  // 1. 土耳其语/阿塞拜疆语特殊字符
  if code == 0x0049 { // I → ı
    return Char::from_int(0x131)
  } else if code == 0x0130 { // İ → i
    return Char::from_int(0x69)
  }

  // 2. 希腊字母
  if code >= 0x0391 && code <= 0x03A9 && code != 0x03A2 {
    return Char::from_int(code + 32)
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

  // 6. 德语大写ẞ小写转换
  if code == 0x1E9E { // 大写的ẞ (U+1E9E)
    return Char::from_int(0xDF) // 转换为小写的ß (U+00DF)
  }

  // 通用情况 - 如果没有特殊规则，返回原字符
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

  // 特殊字符处理

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

  // 通用情况 - 如果没有特殊规则，返回原字符
  return r
}

///| 将字符转换为标题形式（通常与大写相同，特殊情况除外）
pub fn to_title(r : Char) -> Char {
  let code = r.to_int()

  // 希腊小写字母sigma的特殊处理
  if code == 0x03C3 { // 希腊小写字母sigma
    return Char::from_int(0x03A3) // 希腊大写字母SIGMA
  }

  // 对于其他字符，使用大写形式
  return to_upper(r)
}

///| 处理Latin1范围内的大小写转换
fn to_latin1_case(case_type : Int, r : Char) -> Char {
  let code = r.to_int()
  if case_type == LowerCase {
    // 将大写转为小写
    if (code >= 0xC0 && code <= 0xD6) || (code >= 0xD8 && code <= 0xDE) {
      return Char::from_int(code + 32)
    }
  } else if case_type == UpperCase {
    // 将小写转为大写
    if (code >= 0xE0 && code <= 0xF6) || (code >= 0xF8 && code <= 0xFE) {
      return Char::from_int(code - 32)
    }

    // 德语ß大写转换
    if code == 0xDF { // 德语 ß
      return Char::from_int(0x1E9E) // 转换为大写的ẞ (U+1E9E)
    }
  }
  return r
}

///| 将字符串转换为小写
pub fn string_to_lower(s : String) -> String {
  let mut result = ""
  for i = 0; i < s.length(); i = i + 1 {
    result = result + to_lower(s[i]).to_string()
  }
  return result
}

///| 将字符串转换为大写
pub fn string_to_upper(s : String) -> String {
  let mut result = ""
  for i = 0; i < s.length(); i = i + 1 {
    result = result + to_upper(s[i]).to_string()
  }
  return result
}

///| 判断字符是否为标点符号
pub fn is_punct(r : Char) -> Bool {
  let code = r.to_int()

  // ASCII 范围内的标点符号
  if r <= MaxASCII {
    return (r >= '!' && r <= '/') || // ! " # $ % & ' ( ) * + , - . /
      (r >= ':' && r <= '@') || // : ; < = > ? @
      (r >= '[' && r <= '`') || // [ \ ] ^ _ `
      (r >= '{' && r <= '~') // { | } ~
  }

  // Latin1 范围内的标点符号
  if r <= MaxLatin1 {
    // 检查Latin1标点符号列表
    for i = 0; i < latin1_puncts.length(); i = i + 1 {
      if code == latin1_puncts[i] {
        return true
      }
    }
    return false
  }

  // 特殊处理非Latin1范围内的标点符号
  return is_excluding_latin_punct(r)
}

///| 检查非Latin1范围内的标点符号
fn is_excluding_latin_punct(r : Char) -> Bool {
  let code = r.to_int()

  // 特殊处理某些数学运算符
  if code == 0x2260 { // ≠ (不等号)
    return true
  }

  // 排除数学运算符
  if code >= 0x2200 && code <= 0x22FF {
    return false
  }

  // 排除全角数字
  if code >= 0xFF10 && code <= 0xFF19 {
    return false
  }

  // 排除全角字母
  if (code >= 0xFF21 && code <= 0xFF3A) || (code >= 0xFF41 && code <= 0xFF5A) {
    return false
  }

  // 检查是否在通用标点符号范围内
  if search_range(ranges, code) {
    return true
  }

  // 检查单独的标点符号
  for i = 0; i < individual_puncts.length(); i = i + 1 {
    if code == individual_puncts[i] {
      return true
    }
  }
  return false
}

///| 判断字符是否为标记符号
pub fn is_mark(r : Char) -> Bool {
  let code = r.to_int()

  // Latin1范围内没有标记符号
  if r <= MaxLatin1 {
    return false
  }

  // 组合标记和非间距标记
  if code >= 0x0300 && code <= 0x036F {
    return true
  }

  // 组合标记扩展
  if code >= 0x1AB0 && code <= 0x1AFF {
    return true
  }

  // 组合标记补充
  if code >= 0x1DC0 && code <= 0x1DFF {
    return true
  }

  // 组合半标记
  if code >= 0xFE20 && code <= 0xFE2F {
    return true
  }

  // 特定语言的标记符号范围

  // 希伯来标记
  if (code >= 0x0591 && code <= 0x05BD) ||
    code == 0x05BF ||
    code == 0x05C1 ||
    code == 0x05C2 ||
    code == 0x05C4 ||
    code == 0x05C5 ||
    code == 0x05C7 {
    return true
  }

  // 阿拉伯标记
  if (code >= 0x0610 && code <= 0x061A) ||
    (code >= 0x064B && code <= 0x065F) ||
    code == 0x0670 {
    return true
  }

  // 叙利亚标记
  if code >= 0x0730 && code <= 0x074A {
    return true
  }

  // 泰文标记
  if (code >= 0x0E34 && code <= 0x0E3A) || (code >= 0x0E47 && code <= 0x0E4E) {
    return true
  }

  // 老挝标记
  if (code >= 0x0EB4 && code <= 0x0EB9) ||
    (code >= 0x0EBB && code <= 0x0EBC) ||
    (code >= 0x0EC8 && code <= 0x0ECD) {
    return true
  }

  // 藏文标记
  if (code >= 0x0F18 && code <= 0x0F19) ||
    code == 0x0F35 ||
    code == 0x0F37 ||
    code == 0x0F39 {
    return true
  }

  // 缅甸标记
  if (code >= 0x1039 && code <= 0x103A) ||
    (code >= 0x1087 && code <= 0x108D) ||
    code == 0x108F ||
    (code >= 0x109A && code <= 0x109D) {
    return true
  }

  // 高棉标记
  if (code >= 0x17B4 && code <= 0x17D3) || code == 0x17DD {
    return true
  }

  // 蒙古标记
  if (code >= 0x1885 && code <= 0x1886) || code == 0x18A9 {
    return true
  }

  // 越南标记
  if (code >= 0x1A7F && code <= 0x1A89) || (code >= 0x1A90 && code <= 0x1A99) {
    return true
  }

  // 检查特定字符
  for i = 0; i < mark_chars.length(); i = i + 2 {
    if code >= mark_chars[i] && code <= mark_chars[i + 1] {
      return true
    }
  }
  return false
}

///| 判断字符是否为空白字符
pub fn is_space(r : Char) -> Bool {
  let code = r.to_int()

  // ASCII 空白字符
  if r <= MaxASCII {
    return r == ' ' || // 空格 (U+0020)
      r == '\t' || // 水平制表符 (U+0009)
      r == '\n' || // 换行符 (U+000A)
      r == '\r' || // 回车符 (U+000D)
      r == '\u000B' || // 垂直制表符 (U+000B)
      r == '\u000C' // 换页符 (U+000C)
  }

  // Latin1 范围内的空白字符
  if r <= MaxLatin1 {
    return r == '\u00A0' // 不换行空格 (U+00A0)
  }

  // 零宽非连接符明确不是空白字符
  if code == 0x200C {
    return false
  }

  // 检查空白字符数组
  let mut i = 0
  while i < space_chars.length() {
    if i + 1 < space_chars.length() && space_chars[i + 1] != 0 {
      // 范围检查
      if code >= space_chars[i] && code <= space_chars[i + 1] {
        return true
      }
      i = i + 2
    } else {
      // 单个字符检查
      if code == space_chars[i] {
        return true
      }
      i = i + 1
    }
  }

  // 特定空白字符检查
  return code == 0x180E || // 蒙古语元音分隔符
    code == 0x200B || // 零宽空格
    code == 0x200D || // 零宽连接符
    code == 0x2060 || // 单词连接符
    code == 0xFEFF // 零宽不换行空格
}

///| 判断字符是否为控制字符
pub fn is_control(r : Char) -> Bool {
  let code = r.to_int()

  // ASCII 控制字符: C0 (0x00-0x1F) 和 DELETE (0x7F)
  if code <= 0x1F || code == 0x7F {
    return true
  }

  // Latin1 控制字符: C1 (0x80-0x9F)
  if code >= 0x80 && code <= 0x9F {
    return true
  }

  // 阿拉伯语格式控制
  if code >= 0x06DD && code <= 0x06DF {
    return true
  }

  // 排除圆点符号
  if code == 0x2022 {
    return false
  }

  // 检查控制字符数组
  let mut i = 0
  while i < control_chars.length() {
    if i + 1 < control_chars.length() && control_chars[i + 1] != 0 {
      // 范围检查
      if code >= control_chars[i] && code <= control_chars[i + 1] {
        return true
      }
      i = i + 2
    } else {
      // 单个字符检查
      if code == control_chars[i] {
        return true
      }
      i = i + 1
    }
  }
  return false
}

///| 判断字符是否为字母
pub fn is_letter(r : Char) -> Bool {
  let code = r.to_int()

  // ASCII 字母范围
  if r <= MaxASCII {
    return ('A' <= r && r <= 'Z') || ('a' <= r && r <= 'z')
  }

  // Latin1 字母范围
  if r <= MaxLatin1 {
    // 特殊处理德语锐音 ß (U+00DF)
    if code == 0x00DF {
      return true
    }

    // Latin1 字母范围: 大写 (0xC0-0xD6, 0xD8-0xDE) 和 小写 (0xE0-0xF6, 0xF8-0xFE)
    return (code >= 0xC0 && code <= 0xD6) ||
      (code >= 0xD8 && code <= 0xDE) ||
      (code >= 0xE0 && code <= 0xF6) ||
      (code >= 0xF8 && code <= 0xFE)
  }

  // 特殊处理大写德语锐音 ẞ (U+1E9E)
  if code == 0x1E9E {
    return true
  }

  // 常见Unicode字母范围检查

  // 1. 希腊字母
  if (code >= 0x0370 && code <= 0x0373) ||
    (code >= 0x0376 && code <= 0x0377) ||
    (code >= 0x037B && code <= 0x037D) ||
    code == 0x037F ||
    code == 0x0386 ||
    (code >= 0x0388 && code <= 0x038A) ||
    code == 0x038C ||
    (code >= 0x038E && code <= 0x03A1) ||
    (code >= 0x03A3 && code <= 0x03F5) ||
    (code >= 0x03F7 && code <= 0x0481) {
    return true
  }

  // 2. 西里尔字母
  if (code >= 0x0400 && code <= 0x0481) ||
    (code >= 0x048A && code <= 0x04FF) ||
    (code >= 0x0500 && code <= 0x0527) ||
    (code >= 0x2DE0 && code <= 0x2DFF) ||
    (code >= 0xA640 && code <= 0xA69F) {
    return true
  }

  // 3. 亚美尼亚字母
  if (code >= 0x0531 && code <= 0x0556) ||
    (code >= 0x0561 && code <= 0x0587) ||
    (code >= 0xFB13 && code <= 0xFB17) {
    return true
  }

  // 4. 希伯来字母
  if (code >= 0x05D0 && code <= 0x05EA) ||
    (code >= 0x05F0 && code <= 0x05F2) ||
    (code >= 0xFB1D && code <= 0xFB36) ||
    (code >= 0xFB38 && code <= 0xFB3C) ||
    code == 0xFB3E ||
    (code >= 0xFB40 && code <= 0xFB41) ||
    (code >= 0xFB43 && code <= 0xFB44) ||
    (code >= 0xFB46 && code <= 0xFB4F) {
    return true
  }

  // 5. 阿拉伯字母
  if (code >= 0x0620 && code <= 0x063F) ||
    (code >= 0x0641 && code <= 0x064A) ||
    (code >= 0x066E && code <= 0x066F) ||
    (code >= 0x0671 && code <= 0x06D3) ||
    code == 0x06D5 ||
    (code >= 0x06E5 && code <= 0x06E6) ||
    (code >= 0x06EE && code <= 0x06EF) ||
    (code >= 0x06FA && code <= 0x06FC) ||
    code == 0x06FF ||
    code == 0x0710 ||
    (code >= 0x0712 && code <= 0x072F) ||
    (code >= 0x074D && code <= 0x07A5) ||
    code == 0x07B1 ||
    (code >= 0x07CA && code <= 0x07EA) {
    return true
  }

  // 6. 日文假名
  if (code >= 0x3041 && code <= 0x3096) || // 平假名
    (code >= 0x30A1 && code <= 0x30FA) { // 片假名
    return true
  }

  // 7. CJK汉字
  if (code >= 0x3400 && code <= 0x4DB5) || // CJK统一表意文字扩展A
    (code >= 0x4E00 && code <= 0x9FCB) || // CJK统一表意文字
    (code >= 0xF900 && code <= 0xFA6A) || // CJK兼容表意文字
    (code >= 0x20000 && code <= 0x2A6D6) { // CJK统一表意文字扩展B
    return true
  }

  // 8. 韩文
  if (code >= 0x1100 && code <= 0x11FF) || // 韩文字母
    (code >= 0x3131 && code <= 0x318E) || // 韩文兼容字母
    (code >= 0xA960 && code <= 0xA97C) || // 韩文字母扩展-A
    (code >= 0xAC00 && code <= 0xD7A3) { // 韩文音节
    return true
  }

  // 9. 全角字母
  if (code >= 0xFF21 && code <= 0xFF3A) || // 全角大写拉丁字母
    (code >= 0xFF41 && code <= 0xFF5A) { // 全角小写拉丁字母
    return true
  }

  // 10. 印度语系字母
  if (code >= 0x0900 && code <= 0x0977) || // 天城文
    (code >= 0x0979 && code <= 0x097F) ||
    (code >= 0x0985 && code <= 0x09B9) || // 孟加拉文
    (code >= 0x09CE && code <= 0x09D6) ||
    (code >= 0x09DC && code <= 0x09E3) ||
    (code >= 0x0A05 && code <= 0x0A39) || // 古吉拉特文
    (code >= 0x0A59 && code <= 0x0A5E) ||
    (code >= 0x0A72 && code <= 0x0A74) ||
    (code >= 0x0A85 && code <= 0x0AB9) {
    return true
  }

  // 11. 拉丁字母扩展
  if (code >= 0x0100 && code <= 0x017F) || // 拉丁字母扩展-A
    (code >= 0x0180 && code <= 0x024F) || // 拉丁字母扩展-B
    (code >= 0x1E00 && code <= 0x1EFF) || // 拉丁字母附加扩展
    (code >= 0x2C60 && code <= 0x2C7F) || // 拉丁字母扩展-C
    (code >= 0xA720 && code <= 0xA7FF) || // 拉丁字母扩展-D
    (code >= 0xAB30 && code <= 0xAB6F) { // 拉丁字母扩展-E
    return true
  }
  return false
}

///| 判断字符是否为符号
pub fn is_symbol(r : Char) -> Bool {
  let code = r.to_int()

  // ASCII 符号
  if r <= MaxASCII {
    return r == '$' ||
      r == '%' ||
      r == '&' ||
      r == '*' ||
      r == '+' ||
      r == '<' ||
      r == '=' ||
      r == '>' ||
      r == '^' ||
      r == '|' ||
      r == '~'
  }

  // Latin1 符号
  if r <= MaxLatin1 {
    return code == 0x00A2 ||
      code == 0x00A3 ||
      code == 0x00A4 ||
      code == 0x00A5 ||
      code == 0x00A9 ||
      code == 0x00AE ||
      code == 0x00B0 ||
      code == 0x00B1 ||
      code == 0x00B5 ||
      code == 0x00D7 ||
      code == 0x00F7
  }

  // Unicode 符号范围

  // 货币符号
  if code >= 0x20A0 && code <= 0x20CF {
    return true
  }

  // 字母符号
  if code >= 0x2100 && code <= 0x214F && code != 0x2126 {
    return true
  }

  // 数学运算符
  if code >= 0x2200 && code <= 0x22FF {
    return true
  }

  // 技术符号
  if code >= 0x2300 && code <= 0x23FF {
    return true
  }

  // 几何图形
  if code >= 0x25A0 && code <= 0x25FF {
    return true
  }

  // 杂项符号
  if code >= 0x2600 && code <= 0x26FF {
    return true
  }

  // 箭头
  if code >= 0x2190 && code <= 0x21FF {
    return true
  }

  // 装饰符号
  if code >= 0x2700 && code <= 0x27BF {
    return true
  }

  // 数学字母符号
  if code >= 0x1D400 && code <= 0x1D7FF {
    return true
  }

  // 象棋符号
  if code >= 0x2654 && code <= 0x265F {
    return true
  }

  // 音乐符号
  if (code >= 0x1D100 && code <= 0x1D1FF) || (code >= 0x2669 && code <= 0x266F) {
    return true
  }

  // 游戏符号
  if (code >= 0x1F000 && code <= 0x1F02F) ||
    ( // 麻将牌
      code >= 0x1F0A0 && code <= 0x1F0FF
    ) { // 扑克牌
    return true
  }

  // 表情符号
  if code >= 0x1F600 && code <= 0x1F64F {
    return true
  }

  // 交通和地图符号
  if code >= 0x1F680 && code <= 0x1F6FF {
    return true
  }

  // 变体选择器和组合用半符号
  if (code >= 0xFE00 && code <= 0xFE0F) || (code >= 0xFE20 && code <= 0xFE2F) {
    return true
  }

  // 全角符号
  if code == 0xFF04 ||
    code == 0xFF05 ||
    code == 0xFF06 ||
    (code >= 0xFF08 && code <= 0xFF0C) ||
    (code >= 0xFF0E && code <= 0xFF10) ||
    code == 0xFF1C ||
    code == 0xFF1D ||
    code == 0xFF1E ||
    code == 0xFF20 ||
    code == 0xFF3C ||
    code == 0xFF3E ||
    code == 0xFF3F ||
    code == 0xFF5C ||
    code == 0xFF5E {
    return true
  }

  // 上标下标和数字形式
  if (code >= 0x2070 && code <= 0x209F) || (code >= 0x2150 && code <= 0x218F) {
    return true
  }

  // 检查特定符号
  for i = 0; i < specific_symbols.length(); i = i + 1 {
    if code == specific_symbols[i] {
      return true
    }
  }
  return false
}

///| 判断字符是否为数字（扩展定义）

///| 判断字符是否为数字（扩展定义）
pub fn is_number(r : Char) -> Bool {
  // 基本数字也是数字
  if is_digit(r) {
    return true
  }
  let code = r.to_int()

  // 全角数字
  if code >= 0xFF10 && code <= 0xFF19 {
    return true
  }

  // 数字形式（分数、罗马数字等）
  if code >= 0x2150 && code <= 0x218F {
    return true
  }

  // 上标和下标数字
  if (code >= 0x2070 && code <= 0x2079) || (code >= 0x2080 && code <= 0x2089) {
    return true
  }

  // 封闭式数字（圆圈数字、括号数字等）
  if (code >= 0x2460 && code <= 0x2473) ||
    (code >= 0x2474 && code <= 0x2487) ||
    (code >= 0x2488 && code <= 0x249B) ||
    (code >= 0x24EA && code <= 0x24FF) {
    return true
  }

  // 数学数字
  if code >= 0x1D7CE && code <= 0x1D7FF {
    return true
  }

  // 各种语言的数字
  if (code >= 0x0660 && code <= 0x0669) || // 阿拉伯数字
    (code >= 0x06F0 && code <= 0x06F9) || // 东阿拉伯数字
    (code >= 0x0966 && code <= 0x096F) || // 天城文数字
    (code >= 0x09E6 && code <= 0x09EF) || // 孟加拉数字
    (code >= 0x0E50 && code <= 0x0E59) { // 泰文数字
    return true
  }

  // 罗马数字
  if (code >= 0x2160 && code <= 0x2182) || // 罗马数字大写 I-M
    (code >= 0x2170 && code <= 0x2188) { // 罗马数字小写 i-m
    return true
  }

  // 汉字数字
  let han_nums = [
    0x4E00, // 一
     0x4E8C, // 二
     0x4E09, // 三
     0x56DB, // 四
     0x4E94, // 五
     0x516D, // 六
     0x4E03, // 七
     0x516B, // 八
     0x4E5D, // 九
     0x5341, // 十
     0x767E, // 百
     0x5343, // 千
     0x4E07, // 万
     0x4EBF, // 亿
  ]
  for i = 0; i < han_nums.length(); i = i + 1 {
    if code == han_nums[i] {
      return true
    }
  }

  // 东亚数字
  if code == 0x3007 || // 〇 (零)
    (code >= 0x3021 && code <= 0x3029) || // 汉字数字 (一至九)
    (code >= 0x3038 && code <= 0x303A) { // 汉字数字 (十、廿、卅)
    return true
  }

  // 特殊数字字符
  let special_nums = [
    0x00B2, // ² (平方)
     0x00B3, // ³ (立方)
     0x00B9, // ¹ (一次方)
     0x00BC, // ¼ (四分之一)
     0x00BD, // ½ (二分之一)
     0x00BE, // ¾ (四分之三)
     0x2153, // ⅓ (三分之一)
     0x2154, // ⅔ (三分之二)
     0x215B, // ⅛ (八分之一)
     0x215C, // ⅜ (八分之三)
     0x215D, // ⅝ (八分之五)
     0x215E, // ⅞ (八分之七)
     0x2189, // ↉ (零分之零)
  ]
  for i = 0; i < special_nums.length(); i = i + 1 {
    if code == special_nums[i] {
      return true
    }
  }
  return false
}

///| 判断字符是否为图形字符
///| 图形字符包括字母、标记、数字、标点、符号及空白字符
pub fn is_graphic(r : Char) -> Bool {
  // 使用组合函数来判断
  // 图形字符 = 字母 + 标记 + 数字 + 标点 + 符号 + 空白

  // 基本 ASCII 和 Latin1 范围的快速处理
  if r <= MaxLatin1 {
    // ASCII 空白字符 (空格) 是图形字符
    if r == ' ' {
      return true
    }

    // 其他图形字符判断
    return is_letter(r) ||
      is_mark(r) ||
      is_number(r) ||
      is_punct(r) ||
      is_symbol(r) ||
      (
        is_space(r) &&
        r != '\t' &&
        r != '\n' &&
        r != '\r' &&
        r != '\u000B' &&
        r != '\u000C'
      )
  }

  // Unicode 范围的处理
  // 图形字符包括所有字母、标记、数字、标点、符号和空格字符
  if is_letter(r) ||
    is_mark(r) ||
    is_number(r) ||
    is_punct(r) ||
    is_symbol(r) ||
    // 排除控制类空白字符
    (is_space(r) && is_control(r) == false) {
    return true
  }
  return false
}

///| 判断字符是否为可打印字符
///| 包括字母、标记、数字、标点、符号以及ASCII空格(U+0020)
///|
pub fn is_print(r : Char) -> Bool {
  let code = r.to_int()

  // ASCII 范围快速处理
  if r <= MaxASCII {
    // ASCII 空格是可打印的
    if r == ' ' {
      return true
    }

    // ASCII 控制字符不可打印
    if code < 0x20 || code == 0x7F {
      return false
    }

    // 其他 ASCII 字符可打印
    return true
  }

  // 特殊处理常见的可打印特殊字符

  // 1. 明确处理圆圈数字和其他封闭数字
  if (code >= 0x2460 && code <= 0x2473) || // 圆圈数字1-20
    (code >= 0x2474 && code <= 0x2487) || // 括号数字1-20
    (code >= 0x2488 && code <= 0x249B) { // 点数字1-20
    return true
  }

  // 2. 组合重音符号范围
  if code >= 0x0300 && code <= 0x036F {
    return true
  }

  // 3. CJK统一表意文字 (中日韩汉字)
  if (code >= 0x3400 && code <= 0x4DB5) || // CJK统一表意文字扩展A
    (code >= 0x4E00 && code <= 0x9FFF) || // CJK统一表意文字基本区
    (code >= 0xF900 && code <= 0xFA6A) || // CJK兼容表意文字
    (code >= 0x20000 && code <= 0x2A6DF) { // CJK统一表意文字扩展B
    return true
  }

  // Latin1 范围处理
  if r <= MaxLatin1 {
    // Latin1 控制字符 (0x80-0x9F) 不可打印
    if code >= 0x80 && code <= 0x9F {
      return false
    }

    // 不包括不换行空格 (U+00A0) 和其他非ASCII空格
    if is_space(r) && r != ' ' {
      return false
    }

    // 其他 Latin1 字符可打印
    return true
  }

  // 全局排除条件

  // 控制字符不可打印
  if is_control(r) {
    return false
  }

  // 非ASCII空格不可打印
  if is_space(r) && r != ' ' {
    return false
  }

  // 非打印格式控制字符检查
  // 零宽字符等通常不可打印
  if code == 0x200B || // 零宽空格
    code == 0x200C || // 零宽非连接符
    code == 0x200D || // 零宽连接符
    code == 0xFEFF || // 零宽不换行空格
    (code >= 0x2060 && code <= 0x206F) { // 不可见格式控制字符
    return false
  }

  // 字母、标记、数字、标点和符号可打印
  // 注意：即使某些字符同时属于多个类别，只要一个条件满足即可返回true
  return is_letter(r) ||
    is_mark(r) ||
    is_number(r) ||
    is_punct(r) ||
    is_symbol(r)
}
