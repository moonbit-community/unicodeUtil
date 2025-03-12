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

///|
const Mark = 12 // 标记符号类别

///|
const Space = 13 // 空白字符类别

///|
const Control = 14 // 控制字符类别

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
    return search_range(numRanges, code)
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

  // 检查是否在范围内
  if search_range(ranges, code) {
    return true
  }

  // 额外检查一些散布各处的标点符号
  // 这里列出一些常见单独的标点符号

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
  // Unicode 标记符号范围
  let code = r.to_int()

  // 组合标记和非间距标记 (Combining Diacritical Marks)
  if code >= 0x0300 && code <= 0x036F {
    return true
  }

  // 组合标记扩展 (Combining Diacritical Marks Extended)
  if code >= 0x1AB0 && code <= 0x1AFF {
    return true
  }

  // 组合标记补充 (Combining Diacritical Marks Supplement)
  if code >= 0x1DC0 && code <= 0x1DFF {
    return true
  }

  // 组合半标记 (Combining Half Marks)
  if code >= 0xFE20 && code <= 0xFE2F {
    return true
  }

  // 特定语言的标记符号范围

  // 希伯来标记 (Hebrew Mark)
  if code >= 0x0591 && code <= 0x05BD {
    return true
  }
  if code == 0x05BF ||
    code == 0x05C1 ||
    code == 0x05C2 ||
    code == 0x05C4 ||
    code == 0x05C5 ||
    code == 0x05C7 {
    return true
  }

  // 阿拉伯标记 (Arabic Mark)
  if (code >= 0x0610 && code <= 0x061A) ||
    (code >= 0x064B && code <= 0x065F) ||
    code == 0x0670 {
    return true
  }

  // 叙利亚标记 (Syriac Mark)
  if code >= 0x0730 && code <= 0x074A {
    return true
  }

  // 泰文标记 (Thai Mark)
  if (code >= 0x0E34 && code <= 0x0E3A) || (code >= 0x0E47 && code <= 0x0E4E) {
    return true
  }

  // 老挝标记 (Lao Mark)
  if (code >= 0x0EB4 && code <= 0x0EB9) ||
    (code >= 0x0EBB && code <= 0x0EBC) ||
    (code >= 0x0EC8 && code <= 0x0ECD) {
    return true
  }

  // 藏文标记 (Tibetan Mark)
  if (code >= 0x0F18 && code <= 0x0F19) ||
    code >= 0x0F35 ||
    code == 0x0F37 ||
    code == 0x0F39 {
    return true
  }

  // 缅甸标记 (Myanmar Mark)
  if (code >= 0x1039 && code <= 0x103A) ||
    (code >= 0x1087 && code <= 0x108D) ||
    code == 0x108F ||
    (code >= 0x109A && code <= 0x109D) {
    return true
  }

  // 高棉标记 (Khmer Mark)
  if (code >= 0x17B4 && code <= 0x17D3) || code == 0x17DD {
    return true
  }

  // 蒙古标记 (Mongolian Mark)
  if (code >= 0x1885 && code <= 0x1886) || code >= 0x18A9 {
    return true
  }

  // 越南标记 (Vietnamese Mark)
  if (code >= 0x1A7F && code <= 0x1A89) || (code >= 0x1A90 && code <= 0x1A99) {
    return true
  }

  // 检查特定字符
  for i = 0; i < mark_chars.length(); i = i + 2 {
    if code >= mark_chars[i] && code <= mark_chars[i + 1] {
      return true
    }
  }

  // 使用 is_excluding_latin 函数如果已实现标记范围
  // return is_excluding_latin(Mark, r)

  return false
}

///| 判断字符是否为空白字符
///| 判断字符是否为空白字符
pub fn is_space(r : Char) -> Bool {
  let code = r.to_int()

  // ASCII 空白字符
  if r <= MaxASCII {
    // 标准 ASCII 空白字符
    return r == ' ' || // 空格 (U+0020)
      r == '\t' || // 水平制表符 (U+0009)
      r == '\n' || // 换行符 (U+000A)
      r == '\r' || // 回车符 (U+000D)
      r == '\u000B' || // 垂直制表符 (U+000B)
      r == '\u000C' // 换页符 (U+000C)
  }

  // Latin1 范围内的空白字符
  if r <= MaxLatin1 {
    if r == '\u00A0' { // 不换行空格 (U+00A0)
      return true
    }
    return false // Latin1 范围内只有 U+00A0 是空白字符
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

  // 单独检查重要的分散空白字符
  return code == 0x180E || // 蒙古语元音分隔符
    code == 0x200B || // 零宽空格
    code == 0x200D || // 零宽连接符
    code == 0x2060 || // 单词连接符
    code == 0xFEFF // 零宽不换行空格
}

///| 判断字符是否为控制字符
pub fn is_control(r : Char) -> Bool {
  let code = r.to_int()

  // ASCII 控制字符
  // C0 控制字符: 0x00-0x1F
  if code <= 0x1F {
    return true
  }

  // DELETE 字符 (DEL): 0x7F
  if code == 0x7F {
    return true
  }

  // Latin1 控制字符
  // C1 控制字符: 0x80-0x9F
  if code >= 0x80 && code <= 0x9F {
    return true
  }

  // Unicode 格式控制字符

  // 阿拉伯语格式控制
  if code >= 0x06DD && code <= 0x06DF {
    return true
  }
  // 确认圆点符号不是控制字符
  if code == 0x2022 { // 圆点符号 (U+2022)
    return false
  }

  // 检查单个或范围的控制字符
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

  // ASCII 字母范围处理
  if r <= MaxASCII {
    return ('A' <= r && r <= 'Z') || ('a' <= r && r <= 'z')
  }

  // Latin1 字母范围处理
  if r <= MaxLatin1 {
    // 特殊处理德语锐音 ß (U+00DF)
    if code == 0x00DF {
      return true
    }

    // Latin1 大写字母范围: 0xC0-0xD6, 0xD8-0xDE
    // Latin1 小写字母范围: 0xE0-0xF6, 0xF8-0xFE
    return (code >= 0xC0 && code <= 0xD6) ||
      (code >= 0xD8 && code <= 0xDE) ||
      (code >= 0xE0 && code <= 0xF6) ||
      (code >= 0xF8 && code <= 0xFE)
  }

  // 常见Unicode字母范围

  // 希腊字母
  if (code >= 0x0370 && code <= 0x0373) ||
    (code >= 0x0376 && code <= 0x0377) ||
    (code >= 0x037B && code <= 0x037D) ||
    code == 0x037F ||
    (code >= 0x0386 && code <= 0x0386) ||
    (code >= 0x0388 && code <= 0x038A) ||
    code == 0x038C ||
    (code >= 0x038E && code <= 0x03A1) ||
    (code >= 0x03A3 && code <= 0x03F5) ||
    (code >= 0x03F7 && code <= 0x0481) {
    return true
  }

  // 西里尔字母
  if (code >= 0x0400 && code <= 0x0481) ||
    (code >= 0x048A && code <= 0x04FF) ||
    (code >= 0x0500 && code <= 0x0527) ||
    (code >= 0x2DE0 && code <= 0x2DFF) ||
    (code >= 0xA640 && code <= 0xA69F) {
    return true
  }

  // 亚美尼亚字母
  if (code >= 0x0531 && code <= 0x0556) ||
    (code >= 0x0561 && code <= 0x0587) ||
    (code >= 0xFB13 && code <= 0xFB17) {
    return true
  }

  // 希伯来字母
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

  // 阿拉伯字母
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

  // 日文平假名和片假名
  if (code >= 0x3041 && code <= 0x3096) || // 平假名
    (code >= 0x30A1 && code <= 0x30FA) { // 片假名
    return true
  }

  // 汉字范围
  if (code >= 0x3400 && code <= 0x4DB5) || // CJK统一表意文字扩展A
    (code >= 0x4E00 && code <= 0x9FCB) || // CJK统一表意文字
    (code >= 0xF900 && code <= 0xFA6A) || // CJK兼容表意文字
    (code >= 0x20000 && code <= 0x2A6D6) { // CJK统一表意文字扩展B
    return true
  }

  // 韩文字母
  if (code >= 0x1100 && code <= 0x11FF) || // 韩文字母
    (code >= 0x3131 && code <= 0x318E) || // 韩文兼容字母
    (code >= 0xA960 && code <= 0xA97C) || // 韩文字母扩展-A
    (code >= 0xAC00 && code <= 0xD7A3) { // 韩文音节
    return true
  }

  // 全角字母
  if (code >= 0xFF21 && code <= 0xFF3A) || // 全角大写拉丁字母
    (code >= 0xFF41 && code <= 0xFF5A) { // 全角小写拉丁字母
    return true
  }

  // 其他常见字母范围 (印度语系等)
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

  // 拉丁字母扩展
  if (code >= 0x0100 && code <= 0x017F) || // 拉丁字母扩展-A
    (code >= 0x0180 && code <= 0x024F) || // 拉丁字母扩展-B
    (code >= 0x1E00 && code <= 0x1EFF) || // 拉丁字母附加扩展
    (code >= 0x2C60 && code <= 0x2C7F) || // 拉丁字母扩展-C
    (code >= 0xA720 && code <= 0xA7FF) || // 拉丁字母扩展-D
    (code >= 0xAB30 && code <= 0xAB6F) { // 拉丁字母扩展-E
    return true
  }

  // 特殊情况
  // 德语锐音ß和其大写形式ẞ
  if code == 0x00DF || code == 0x1E9E {
    return true
  }
  return false
}

///| 判断字符是否为符号
pub fn is_symbol(r : Char) -> Bool {
  let code = r.to_int()

  // ASCII 符号范围处理
  if r <= MaxASCII {
    // $ (美元符号), % (百分号), & (和号), * (星号), + (加号), < (小于号), 
    // = (等于号), > (大于号), ^ (脱字符), | (竖线), ~ (波浪号)
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

  // Latin1 符号范围处理
  if r <= MaxLatin1 {
    // ¢ (美分), £ (英镑), ¤ (货币符号), ¥ (日元), © (版权), ® (注册商标),
    // ° (度), ± (加减), µ (微), × (乘), ÷ (除)
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

  // 1. 货币符号 (Currency Symbols)
  if code >= 0x20A0 && code <= 0x20CF {
    return true
  }

  // 2. 字母符号 (Letterlike Symbols)
  if code >= 0x2100 && code <= 0x214F {
    // 排除特定字符
    if code == 0x2126 { // Ω (欧姆符号，也是希腊字母)
      return false
    }
    return true
  }

  // 3. 数学运算符 (Mathematical Operators)
  if code >= 0x2200 && code <= 0x22FF {
    return true
  }

  // 4. 技术符号 (Technical Symbols)
  if code >= 0x2300 && code <= 0x23FF {
    return true
  }

  // 5. 几何图形 (Geometric Shapes)
  if code >= 0x25A0 && code <= 0x25FF {
    return true
  }

  // 6. 杂项符号 (Miscellaneous Symbols)
  if code >= 0x2600 && code <= 0x26FF {
    return true
  }

  // 7. 箭头 (Arrows)
  if code >= 0x2190 && code <= 0x21FF {
    return true
  }

  // 8. 装饰符号 (Dingbats)
  if code >= 0x2700 && code <= 0x27BF {
    return true
  }

  // 9. 数学字母符号 (Mathematical Alphanumeric Symbols)
  if code >= 0x1D400 && code <= 0x1D7FF {
    return true
  }

  // 10. 象棋符号 (Chess Symbols)
  if code >= 0x2654 && code <= 0x265F {
    return true
  }

  // 11. 音乐符号 (Musical Symbols)
  if (code >= 0x1D100 && code <= 0x1D1FF) || (code >= 0x2669 && code <= 0x266F) {
    return true
  }

  // 12. 麻将牌符号 (Mahjong Tiles)
  if code >= 0x1F000 && code <= 0x1F02F {
    return true
  }

  // 13. 扑克牌符号 (Playing Cards)
  if code >= 0x1F0A0 && code <= 0x1F0FF {
    return true
  }

  // 14. 表情符号 (Emoticons)
  if code >= 0x1F600 && code <= 0x1F64F {
    return true
  }

  // 15. 交通和地图符号 (Transport and Map Symbols)
  if code >= 0x1F680 && code <= 0x1F6FF {
    return true
  }

  // 16. 符号变体选择器 (Variation Selectors)
  if code >= 0xFE00 && code <= 0xFE0F {
    return true
  }

  // 17. 组合用半符号 (Combining Half Marks)
  if code >= 0xFE20 && code <= 0xFE2F {
    return true
  }

  // 18. 全角符号 (Fullwidth Symbols)
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

  // 19. 上标和下标 (Superscripts and Subscripts)
  if code >= 0x2070 && code <= 0x209F {
    return true
  }

  // 20. 数字形式 (Number Forms)
  if code >= 0x2150 && code <= 0x218F {
    return true
  }
  for i = 0; i < specific_symbols.length(); i = i + 1 {
    if code == specific_symbols[i] {
      return true
    }
  }
  return false
}
///| 判断字符是否为数字
///| 扩展自is_digit，包括各种脚本的数字、分数、罗马数字等
pub fn is_number(r: Char) -> Bool {
  // 首先检查是否为基本数字（使用现有的is_digit函数）
  if is_digit(r) {
    return true
  }
  
  let code = r.to_int()
  
  // 全角数字 (０-９)
  if code >= 0xFF10 && code <= 0xFF19 {
    return true
  }
  
  // 1. 数字形式 (Number Forms)
  // 包含分数、罗马数字等
  if code >= 0x2150 && code <= 0x218F {
    return true
  }
  
  // 2. 上标和下标数字 (Superscripts and Subscripts)
  if (code >= 0x2070 && code <= 0x2079) || // 上标数字
     (code >= 0x2080 && code <= 0x2089) {  // 下标数字
    return true
  }
  
  // 3. 封闭式数字 (Enclosed Alphanumerics - 数字部分)
  if (code >= 0x2460 && code <= 0x2473) || // 圆圈数字1-20
     (code >= 0x2474 && code <= 0x2487) || // 括号数字1-20
     (code >= 0x2488 && code <= 0x249B) || // 点数字1-20
     (code >= 0x24EA && code <= 0x24FF) {  // 圆圈数字0和11-20
    return true
  }
  
  // 4. 数学数字 (Mathematical Alphanumeric Symbols - 数字部分)
  if code >= 0x1D7CE && code <= 0x1D7FF {
    return true
  }
  
  // 5. 阿拉伯数字 (Arabic-Indic Digits)
  if code >= 0x0660 && code <= 0x0669 {
    return true
  }
  
  // 6. 东阿拉伯数字 (Eastern Arabic-Indic Digits)
  if code >= 0x06F0 && code <= 0x06F9 {
    return true
  }
  
  // 7. 天城文数字 (Devanagari Digits)
  if code >= 0x0966 && code <= 0x096F {
    return true
  }
  
  // 8. 孟加拉数字 (Bengali Digits)
  if code >= 0x09E6 && code <= 0x09EF {
    return true
  }
  
  // 9. 泰文数字 (Thai Digits)
  if code >= 0x0E50 && code <= 0x0E59 {
    return true
  }
  
  
  for i = 0; i < han_nums.length(); i = i + 1 {
    if code == han_nums[i] {
      return true
    }
  }
  
  // 11. 其他印度语系数字
  if (code >= 0x0A66 && code <= 0x0A6F) || // 古吉拉特数字
     (code >= 0x0AE6 && code <= 0x0AEF) || // 古吉拉特数字
     (code >= 0x0B66 && code <= 0x0B6F) || // 奥里亚数字
     (code >= 0x0BE6 && code <= 0x0BEF) || // 泰米尔数字
     (code >= 0x0C66 && code <= 0x0C6F) || // 泰卢固数字
     (code >= 0x0CE6 && code <= 0x0CEF) || // 卡纳达数字
     (code >= 0x0D66 && code <= 0x0D6F) {  // 马拉雅拉姆数字
    return true
  }
  
  // 12. 东亚数字
  if (code == 0x3007) || // 〇 (零)
     (code >= 0x3021 && code <= 0x3029) || // 汉字数字 (一至九)
     (code >= 0x3038 && code <= 0x303A) {  // 汉字数字 (十、廿、卅)
    return true
  }
  
  // 13. 罗马数字
  if (code >= 0x2160 && code <= 0x2182) || // 罗马数字大写 I-M
     (code >= 0x2170 && code <= 0x2188) {  // 罗马数字小写 i-m
    return true
  }

  for i = 0; i < special_nums.length(); i = i + 1 {
    if code == special_nums[i] {
      return true
    }
  }
  
  return false
}