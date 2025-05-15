///|
test "is_digit" {
  // ASCII 数字 (0-9)
  assert_true!(is_digit('1'))
  assert_true!(is_digit('5'))
  assert_true!(is_digit('9'))

  // ASCII 非数字字符
  assert_false!(is_digit('a'))
  assert_false!(is_digit('Z'))
  assert_false!(is_digit(' '))
  assert_false!(is_digit('-'))
  assert_false!(is_digit('.'))

  // Latin1 范围内非数字字符
  assert_false!(is_digit('é'))
  assert_false!(is_digit('ñ'))
  assert_false!(is_digit('ß'))

  // Unicode 数字
  // 阿拉伯数字 (Arabic-Indic digits)
  assert_true!(is_digit('٠')) // 0
  assert_true!(is_digit('٥')) // 5
  assert_true!(is_digit('٩')) // 9

  // 波斯数字 (Persian digits)
  assert_true!(is_digit('۰')) // 0
  assert_true!(is_digit('۵')) // 5
  assert_true!(is_digit('۹')) // 9

  // 天城文数字 (Devanagari digits)
  assert_true!(is_digit('०')) // 0
  assert_true!(is_digit('५')) // 5
  assert_true!(is_digit('९')) // 9

  // 泰文数字 (Thai digits)
  assert_true!(is_digit('๐')) // 0
  assert_true!(is_digit('๕')) // 5
  assert_true!(is_digit('๙')) // 9

  // 全角数字 (Fullwidth digits)
  assert_true!(is_digit('０')) // 0
  assert_true!(is_digit('５')) // 5
  assert_true!(is_digit('９')) // 9

  // Unicode 非数字字符
  assert_false!(is_digit('א')) // 希伯来字母
  assert_false!(is_digit('ش')) // 阿拉伯字母
  assert_false!(is_digit('か')) // 日语假名
  assert_false!(is_digit('漢')) // 汉字
  assert_false!(is_digit('α')) // 希腊字母
  assert_false!(is_digit('∞')) // 数学符号

  // 边界测试
  assert_false!(is_digit('\u0000')) // NULL字符
  assert_false!(is_digit('\u007F')) // DELETE字符
  assert_false!(is_digit('\u0080')) // Latin1开始
  assert_false!(is_digit('\u00FF')) // Latin1结束
}

///|
test "special_case_conversion" {
  // 拉丁字母扩展
  assert_eq!(to_lower('É'), 'é')
  assert_eq!(to_upper('é'), 'É')
  assert_eq!(to_lower('Ñ'), 'ñ')
  assert_eq!(to_upper('ñ'), 'Ñ')

  // 希腊字母
  assert_eq!(to_lower('Α'), 'α') // Alpha
  assert_eq!(to_upper('α'), 'Α')
  assert_eq!(to_lower('Ω'), 'ω') // Omega
  assert_eq!(to_upper('ω'), 'Ω')

  // 西里尔字母
  assert_eq!(to_lower('А'), 'а') // Cyrillic A
  assert_eq!(to_upper('а'), 'А')
  assert_eq!(to_lower('Я'), 'я') // Cyrillic Ya
  assert_eq!(to_upper('я'), 'Я')

  // 德语ß 
  assert_eq!(to_upper('ß'), 'ẞ') // 小写ß -> 大写ẞ (不是'SS'或'S')
  assert_eq!(to_lower('ẞ'), 'ß') // 大写ẞ -> 小写ß

  // 全角字母
  assert_eq!(to_lower('Ａ'), 'ａ')
  assert_eq!(to_upper('ａ'), 'Ａ')
}

///| Unicode工具库测试用例
test "to_lower_ascii" {
  // 测试ASCII字符小写转换
  assert_eq!(to_lower('A'), 'a')
  assert_eq!(to_lower('Z'), 'z')
  assert_eq!(to_lower('a'), 'a')
  assert_eq!(to_lower('z'), 'z')
  assert_eq!(to_lower('0'), '0')
  assert_eq!(to_lower('!'), '!')
  assert_eq!(to_lower(' '), ' ')
}

///|
test "to_upper_ascii" {
  // 测试ASCII字符大写转换
  assert_eq!(to_upper('a'), 'A')
  assert_eq!(to_upper('z'), 'Z')
  assert_eq!(to_upper('A'), 'A')
  assert_eq!(to_upper('Z'), 'Z')
  assert_eq!(to_upper('0'), '0')
  assert_eq!(to_upper('!'), '!')
  assert_eq!(to_upper(' '), ' ')
}

///|
test "to_lower_latin1" {
  // 测试Latin1范围字符小写转换
  assert_eq!(to_lower('À'), 'à')
  assert_eq!(to_lower('Ç'), 'ç')
  assert_eq!(to_lower('É'), 'é')
  assert_eq!(to_lower('Ñ'), 'ñ')
  assert_eq!(to_lower('Ö'), 'ö')
  assert_eq!(to_lower('Ü'), 'ü')

  // 已经是小写的字符
  assert_eq!(to_lower('à'), 'à')
  assert_eq!(to_lower('ç'), 'ç')

  // 非字母字符不变
  assert_eq!(to_lower('±'), '±')
  assert_eq!(to_lower('§'), '§')
}

///|
test "to_upper_latin1" {
  // 测试Latin1范围字符大写转换
  assert_eq!(to_upper('à'), 'À')
  assert_eq!(to_upper('ç'), 'Ç')
  assert_eq!(to_upper('é'), 'É')
  assert_eq!(to_upper('ñ'), 'Ñ')
  assert_eq!(to_upper('ö'), 'Ö')
  assert_eq!(to_upper('ü'), 'Ü')

  // 已经是大写的字符
  assert_eq!(to_upper('À'), 'À')
  assert_eq!(to_upper('Ç'), 'Ç')
}

///|
test "to_lower_special_unicode" {
  // 测试特殊Unicode字符小写转换

  // 希腊字母
  assert_eq!(to_lower('Α'), 'α') // Alpha
  assert_eq!(to_lower('Β'), 'β') // Beta
  assert_eq!(to_lower('Γ'), 'γ') // Gamma
  assert_eq!(to_lower('Δ'), 'δ') // Delta
  assert_eq!(to_lower('Ω'), 'ω') // Omega

  // 西里尔字母
  assert_eq!(to_lower('А'), 'а') // A
  assert_eq!(to_lower('Б'), 'б') // Be
  assert_eq!(to_lower('В'), 'в') // Ve
  assert_eq!(to_lower('Я'), 'я') // Ya

  // 亚美尼亚字母
  assert_eq!(to_lower('Ա'), 'ա') // Ayb
  assert_eq!(to_lower('Բ'), 'բ') // Ben
  assert_eq!(to_lower('Գ'), 'գ') // Gim

  // 全角字母
  assert_eq!(to_lower('Ａ'), 'ａ')
  assert_eq!(to_lower('Ｚ'), 'ｚ')
}

///|
test "to_upper_special_unicode" {
  // 测试特殊Unicode字符大写转换

  // 希腊字母
  assert_eq!(to_upper('α'), 'Α') // alpha
  assert_eq!(to_upper('β'), 'Β') // beta
  assert_eq!(to_upper('γ'), 'Γ') // gamma
  assert_eq!(to_upper('δ'), 'Δ') // delta
  assert_eq!(to_upper('ω'), 'Ω') // omega

  // 西里尔字母
  assert_eq!(to_upper('а'), 'А') // a
  assert_eq!(to_upper('б'), 'Б') // be
  assert_eq!(to_upper('в'), 'В') // ve
  assert_eq!(to_upper('я'), 'Я') // ya

  // 亚美尼亚字母
  assert_eq!(to_upper('ա'), 'Ա') // ayb
  assert_eq!(to_upper('բ'), 'Բ') // ben
  assert_eq!(to_upper('գ'), 'Գ') // gim

  // 全角字母
  assert_eq!(to_upper('ａ'), 'Ａ')
  assert_eq!(to_upper('ｚ'), 'Ｚ')
}

///|
test "is_punct_ascii" {
  // ASCII 标点符号测试
  assert_true!(is_punct('!'))
  assert_true!(is_punct('"'))
  assert_true!(is_punct('#'))
  assert_true!(is_punct('$'))
  assert_true!(is_punct('%'))
  assert_true!(is_punct('&'))
  assert_true!(is_punct('\''))
  assert_true!(is_punct('('))
  assert_true!(is_punct(')'))
  assert_true!(is_punct('*'))
  assert_true!(is_punct('+'))
  assert_true!(is_punct(','))
  assert_true!(is_punct('-'))
  assert_true!(is_punct('.'))
  assert_true!(is_punct('/'))
  assert_true!(is_punct(':'))
  assert_true!(is_punct(';'))
  assert_true!(is_punct('<'))
  assert_true!(is_punct('='))
  assert_true!(is_punct('>'))
  assert_true!(is_punct('?'))
  assert_true!(is_punct('@'))
  assert_true!(is_punct('['))
  assert_true!(is_punct('\\'))
  assert_true!(is_punct(']'))
  assert_true!(is_punct('^'))
  assert_true!(is_punct('_'))
  assert_true!(is_punct('`'))
  assert_true!(is_punct('{'))
  assert_true!(is_punct('|'))
  assert_true!(is_punct('}'))
  assert_true!(is_punct('~'))

  // 非标点符号
  assert_false!(is_punct('a'))
  assert_false!(is_punct('A'))
  assert_false!(is_punct('0'))
  assert_false!(is_punct(' '))
}

///|
test "is_punct_latin1" {
  // Latin1 标点符号测试
  assert_true!(is_punct('¡')) // 倒置叹号
  assert_true!(is_punct('¤')) // 货币符号
  assert_true!(is_punct('§')) // 章节符号
  assert_true!(is_punct('¿')) // 倒置问号
  assert_true!(is_punct('×')) // 乘号
  assert_true!(is_punct('÷')) // 除号
}

///|
test "is_punct_unicode" {
  // Unicode 标点符号测试
  assert_true!(is_punct('—')) // Em dash
  assert_true!(is_punct('…')) // 省略号
  assert_true!(is_punct('•')) // 项目符号
  assert_true!(is_punct('※')) // 参考标记
  assert_true!(is_punct('★')) // 黑星
  assert_true!(is_punct('→')) // 右箭头
  assert_true!(is_punct('≠')) // 不等号

  // 非标点符号
  assert_false!(is_punct('é'))
  assert_false!(is_punct('Ñ'))
  assert_false!(is_punct('±')) // 加减号通常被视为数学符号而非标点
  assert_true!(is_punct('—')) // Em dash
  assert_true!(is_punct('…')) // 省略号
  assert_true!(is_punct('•')) // 项目符号
  assert_true!(is_punct('※')) // 参考标记
  assert_true!(is_punct('★')) // 黑星
  assert_true!(is_punct('→')) // 右箭头
  assert_true!(is_punct('≠')) // 不等号

  // CJK 标点
  assert_true!(is_punct('。')) // 句号
  assert_true!(is_punct('、')) // 顿号
  assert_true!(is_punct('「')) // 左引号
  assert_true!(is_punct('」')) // 右引号
  assert_true!(is_punct('，')) // 逗号
  assert_true!(is_punct('！')) // 感叹号

  // 全角ASCII标点
  assert_true!(is_punct('．')) // 全角句点
  assert_true!(is_punct('：')) // 全角冒号
  assert_true!(is_punct('？')) // 全角问号

  // 非标点符号
  assert_false!(is_punct('あ')) // 日语平假名
  assert_false!(is_punct('漢')) // 汉字
  assert_false!(is_punct('א')) // 希伯来字母
  assert_false!(is_punct('１')) // 全角数字
}

///| 测试标记符号识别
test "is_mark" {
  // 组合标记
  assert_true!(is_mark('\u0300')) // 重音符号 (Combining Grave Accent)
  assert_true!(is_mark('\u0301')) // 锐音符号 (Combining Acute Accent)
  assert_true!(is_mark('\u0302')) // 扬抑符 (Combining Circumflex Accent)
  assert_true!(is_mark('\u0303')) // 波浪符 (Combining Tilde)
  assert_true!(is_mark('\u0308')) // 分音符 (Combining Diaeresis)

  // 语言特定标记
  assert_true!(is_mark('\u0591')) // 希伯来标记 (Hebrew Accent Etnahta)
  assert_true!(is_mark('\u064B')) // 阿拉伯标记 (Arabic Fathatan)
  assert_true!(is_mark('\u0E38')) // 泰文标记 (Thai Character Sara U)
  assert_true!(is_mark('\u0EB5')) // 老挝标记 (Lao Vowel Sign Ii)

  // 非标记符号
  assert_false!(is_mark('a')) // 拉丁字母
  assert_false!(is_mark('1')) // 数字
  assert_false!(is_mark('.')) // 标点符号
  assert_false!(is_mark('´')) // 独立的锐音符号（不是组合标记）
  assert_false!(is_mark('ä')) // 已经组合好的字符（不是标记本身）
  assert_false!(is_mark(' ')) // 空格
  assert_false!(is_mark('\u00A0')) // 不换行空格 (NBSP)

  // 特殊情况
  assert_true!(is_mark('\u02B4')) // 修饰符号小字母 h (Modifier Letter Small H)
  assert_true!(is_mark('\u24D9')) // 封闭的小写字母 r
}

///| 标记符号与常规字符组合测试
test "marks_with_base_char" {
  // 测试字符串中标记符号的识别
  let s = "e\u0301" // 'é' 分解形式（'e' + 锐音符号）
  assert_false!(is_mark(s[0])) // 'e' 不是标记
  assert_true!(is_mark(s[1])) // '\u0301' 是标记

  // 注意：这里测试的是组合标记而非预组合字符
  // 'é' (U+00E9) 是预组合字符，不是标记
  assert_false!(is_mark('é'))
}

///|
test "is_space" {
  // ASCII 空白字符
  assert_true!(is_space(' ')) // 空格
  assert_true!(is_space('\t')) // 水平制表符
  assert_true!(is_space('\n')) // 换行符
  assert_true!(is_space('\r')) // 回车符
  assert_true!(is_space('\u000B')) // 垂直制表符
  assert_true!(is_space('\u000C')) // 换页符

  // Latin1 空白字符
  assert_true!(is_space('\u00A0')) // 不换行空格 (NBSP)

  // Unicode 空白字符
  assert_true!(is_space('\u2000')) // 半角空格 (En Space)
  assert_true!(is_space('\u2001')) // 全角空格 (Em Space)
  assert_true!(is_space('\u2002')) // 半角空格 (En Space)
  assert_true!(is_space('\u2003')) // 全角空格 (Em Space)
  assert_true!(is_space('\u2004')) // 三分之一全角空格 (Three-Per-Em Space)
  assert_true!(is_space('\u2005')) // 四分之一全角空格 (Four-Per-Em Space)
  assert_true!(is_space('\u2006')) // 六分之一全角空格 (Six-Per-Em Space)
  assert_true!(is_space('\u2007')) // 数字空格 (Figure Space)
  assert_true!(is_space('\u2008')) // 标点符号空格 (Punctuation Space)
  assert_true!(is_space('\u2009')) // 窄空格 (Thin Space)
  assert_true!(is_space('\u200A')) // 极窄空格 (Hair Space)
  assert_true!(is_space('\u2028')) // 行分隔符 (Line Separator)
  assert_true!(is_space('\u2029')) // 段落分隔符 (Paragraph Separator)
  assert_true!(is_space('\u202F')) // 窄不换行空格 (Narrow No-Break Space)
  assert_true!(is_space('\u205F')) // 中度数学空格 (Medium Mathematical Space)
  assert_true!(is_space('\u3000')) // 表意文字空格 (Ideographic Space)

  // 零宽空格
  assert_true!(is_space('\u200B')) // 零宽空格 (Zero Width Space)
  assert_true!(is_space('\u200D')) // 零宽连接符 (Zero Width Joiner)
  assert_true!(is_space('\uFEFF')) // 零宽不换行空格 (Zero Width No-Break Space)

  // 非空白字符
  assert_false!(is_space('a')) // 字母
  assert_false!(is_space('1')) // 数字
  assert_false!(is_space('.')) // 标点符号
  assert_false!(is_space('あ')) // 日语假名
  assert_false!(is_space('漢')) // 汉字
}

///| 测试控制字符识别
test "is_control" {
  // ASCII 控制字符
  assert_true!(is_control('\u0000')) // NULL
  assert_true!(is_control('\u0001')) // START OF HEADING
  assert_true!(is_control('\u0007')) // BELL
  assert_true!(is_control('\u0008')) // BACKSPACE
  assert_true!(is_control('\u0009')) // HORIZONTAL TABULATION (TAB)
  assert_true!(is_control('\u000A')) // LINE FEED (LF)
  assert_true!(is_control('\u000D')) // CARRIAGE RETURN (CR)
  assert_true!(is_control('\u001B')) // ESCAPE
  assert_true!(is_control('\u001F')) // UNIT SEPARATOR
  assert_true!(is_control('\u007F')) // DELETE

  // Latin1 控制字符
  assert_true!(is_control('\u0080')) // PADDING CHARACTER
  assert_true!(is_control('\u0085')) // NEXT LINE
  assert_true!(is_control('\u009F')) // APPLICATION PROGRAM COMMAND

  // Unicode 格式控制字符
  assert_true!(is_control('\u200C')) // ZERO WIDTH NON-JOINER
  assert_true!(is_control('\u200D')) // ZERO WIDTH JOINER
  assert_true!(is_control('\u200E')) // LEFT-TO-RIGHT MARK
  assert_true!(is_control('\u200F')) // RIGHT-TO-LEFT MARK
  assert_true!(is_control('\u202A')) // LEFT-TO-RIGHT EMBEDDING
  assert_true!(is_control('\u202E')) // RIGHT-TO-LEFT OVERRIDE
  assert_true!(is_control('\u2060')) // WORD JOINER
  assert_true!(is_control('\uFEFF')) // ZERO WIDTH NO-BREAK SPACE (BOM)

  // 非控制字符
  assert_false!(is_control('a')) // 字母
  assert_false!(is_control('1')) // 数字
  assert_false!(is_control('.')) // 标点符号
  assert_false!(is_control(' ')) // 空格
  assert_false!(is_control('\u00A0')) // 不换行空格 (NBSP)
  assert_false!(is_control('\u2022')) // 圆点符号
}

///| 测试控制字符与其他类别的关系
test "control_vs_other_categories" {
  // 有些控制字符同时也是空白字符
  assert_true!(is_control('\u0009')) // TAB 是控制字符
  assert_true!(is_space('\u0009')) // TAB 也是空白字符
  assert_true!(is_control('\u000A')) // LF 是控制字符
  assert_true!(is_space('\u000A')) // LF 也是空白字符
  assert_true!(is_control('\u000D')) // CR 是控制字符
  assert_true!(is_space('\u000D')) // CR 也是空白字符

  // 格式控制字符与空白字符的区别
  assert_true!(is_control('\u200C')) // ZWNJ 是控制字符
  assert_false!(is_space('\u200C')) // 但在这个实现中不是空白字符

  // NULL 不是空白字符
  assert_true!(is_control('\u0000')) // NULL 是控制字符
  assert_false!(is_space('\u0000')) // 但不是空白字符
}

///| 测试拉丁字母识别
test "is_letter_latin" {
  // ASCII 字母
  assert_true!(is_letter('A'))
  assert_true!(is_letter('Z'))
  assert_true!(is_letter('a'))
  assert_true!(is_letter('z'))

  // Latin1 字母
  assert_true!(is_letter('À'))
  assert_true!(is_letter('Ç'))
  assert_true!(is_letter('É'))
  assert_true!(is_letter('Ñ'))
  assert_true!(is_letter('à'))
  assert_true!(is_letter('ç'))
  assert_true!(is_letter('é'))
  assert_true!(is_letter('ñ'))

  // 德语特殊字符
  assert_true!(is_letter('ß'))
  assert_true!(is_letter('ẞ')) // 大写的ß

  // 拉丁字母扩展
  assert_true!(is_letter('Ā')) // 拉丁字母扩展A
  assert_true!(is_letter('ā'))
  assert_true!(is_letter('Ħ')) // 拉丁字母扩展B
  assert_true!(is_letter('ħ'))
  assert_true!(is_letter('Ḃ')) // 拉丁字母附加扩展
  assert_true!(is_letter('ḃ'))
}

///| 测试各种语言字母识别
test "is_letter_other_scripts" {
  // 希腊字母
  assert_true!(is_letter('Α')) // 大写Alpha
  assert_true!(is_letter('α')) // 小写alpha
  assert_true!(is_letter('Ω')) // 大写Omega
  assert_true!(is_letter('ω')) // 小写omega

  // 西里尔字母
  assert_true!(is_letter('А')) // 大写A
  assert_true!(is_letter('а')) // 小写a
  assert_true!(is_letter('Я')) // 大写Ya
  assert_true!(is_letter('я')) // 小写ya

  // 希伯来字母
  assert_true!(is_letter('א')) // Alef
  assert_true!(is_letter('ת')) // Tav

  // 阿拉伯字母
  assert_true!(is_letter('ا')) // Alif
  assert_true!(is_letter('ي')) // Yeh

  // 日文字符
  assert_true!(is_letter('あ')) // 平假名a
  assert_true!(is_letter('ア')) // 片假名A
  assert_true!(is_letter('ん')) // 平假名n
  assert_true!(is_letter('ン')) // 片假名N

  // 韩文
  assert_true!(is_letter('ㄱ')) // 韩文字母
  assert_true!(is_letter('가')) // 韩文音节

  // 汉字
  assert_true!(is_letter('漢')) // 汉
  assert_true!(is_letter('字')) // 字

  // 天城文（印地语）
  assert_true!(is_letter('अ'))
  assert_true!(is_letter('ह'))
}

///| 测试非字母字符
test "is_letter_non_letters" {
  // 数字
  assert_false!(is_letter('0'))
  assert_false!(is_letter('9'))

  // 标点符号
  assert_false!(is_letter('.'))
  assert_false!(is_letter(','))
  assert_false!(is_letter('!'))
  assert_false!(is_letter('?'))
  assert_false!(is_letter('-'))
  assert_false!(is_letter('"'))

  // 空白字符
  assert_false!(is_letter(' '))
  assert_false!(is_letter('\t'))
  assert_false!(is_letter('\n'))
}

///|
test "is_letter_latin" {
  // ASCII 字母
  assert_true!(is_letter('A'))
  assert_true!(is_letter('Z'))
  assert_true!(is_letter('a'))
  assert_true!(is_letter('z'))

  // Latin1 字母
  assert_true!(is_letter('À'))
  assert_true!(is_letter('Ç'))
  assert_true!(is_letter('É'))
  assert_true!(is_letter('Ñ'))
  assert_true!(is_letter('à'))
  assert_true!(is_letter('ç'))
  assert_true!(is_letter('é'))
  assert_true!(is_letter('ñ'))

  // 德语特殊字符
  assert_true!(is_letter('ß'))
  assert_true!(is_letter('ẞ')) // 大写的ß

  // 拉丁字母扩展
  assert_true!(is_letter('Ā')) // 拉丁字母扩展A
  assert_true!(is_letter('ā'))
  assert_true!(is_letter('Ħ')) // 拉丁字母扩展B
  assert_true!(is_letter('ħ'))
  assert_true!(is_letter('Ḃ')) // 拉丁字母附加扩展
  assert_true!(is_letter('ḃ'))
}

///| 测试各种语言字母识别
test "is_letter_other_scripts" {
  // 希腊字母
  assert_true!(is_letter('Α')) // 大写Alpha
  assert_true!(is_letter('α')) // 小写alpha
  assert_true!(is_letter('Ω')) // 大写Omega
  assert_true!(is_letter('ω')) // 小写omega

  // 西里尔字母
  assert_true!(is_letter('А')) // 大写A
  assert_true!(is_letter('а')) // 小写a
  assert_true!(is_letter('Я')) // 大写Ya
  assert_true!(is_letter('я')) // 小写ya

  // 希伯来字母
  assert_true!(is_letter('א')) // Alef
  assert_true!(is_letter('ת')) // Tav

  // 阿拉伯字母
  assert_true!(is_letter('ا')) // Alif
  assert_true!(is_letter('ي')) // Yeh

  // 日文字符
  assert_true!(is_letter('あ')) // 平假名a
  assert_true!(is_letter('ア')) // 片假名A
  assert_true!(is_letter('ん')) // 平假名n
  assert_true!(is_letter('ン')) // 片假名N

  // 韩文
  assert_true!(is_letter('ㄱ')) // 韩文字母
  assert_true!(is_letter('가')) // 韩文音节

  // 汉字
  assert_true!(is_letter('漢')) // 汉
  assert_true!(is_letter('字')) // 字

  // 天城文（印地语）
  assert_true!(is_letter('अ'))
  assert_true!(is_letter('ह'))
}

///| 测试符号识别功能
test "is_symbol" {
  // ASCII 符号
  assert_true!(is_symbol('$')) // 美元符号
  assert_true!(is_symbol('%')) // 百分号
  assert_true!(is_symbol('&')) // 和号
  assert_true!(is_symbol('*')) // 星号
  assert_true!(is_symbol('+')) // 加号
  assert_true!(is_symbol('<')) // 小于号
  assert_true!(is_symbol('=')) // 等于号
  assert_true!(is_symbol('>')) // 大于号
  assert_true!(is_symbol('^')) // 脱字符
  assert_true!(is_symbol('|')) // 竖线
  assert_true!(is_symbol('~')) // 波浪号

  // Latin1 符号
  assert_true!(is_symbol('¢')) // 美分符号
  assert_true!(is_symbol('£')) // 英镑符号
  assert_true!(is_symbol('¤')) // 货币符号
  assert_true!(is_symbol('¥')) // 日元符号
  assert_true!(is_symbol('©')) // 版权符号
  assert_true!(is_symbol('®')) // 注册商标
  assert_true!(is_symbol('°')) // 度数符号
  assert_true!(is_symbol('±')) // 加减号
  assert_true!(is_symbol('µ')) // 微符号
  assert_true!(is_symbol('×')) // 乘号
  assert_true!(is_symbol('÷')) // 除号

  // 特殊Unicode符号
  assert_true!(is_symbol('€')) // 欧元符号
  assert_true!(is_symbol('™')) // 商标符号
  assert_true!(is_symbol('℃')) // 摄氏度符号
  assert_true!(is_symbol('№')) // 编号符号

  // 数学符号
  assert_true!(is_symbol('∀')) // 全称量词符号
  assert_true!(is_symbol('∃')) // 存在量词符号
  assert_true!(is_symbol('∈')) // 属于符号
  assert_true!(is_symbol('∑')) // 求和符号
  assert_true!(is_symbol('∏')) // 连乘符号
  assert_true!(is_symbol('∞')) // 无穷大符号
  assert_true!(is_symbol('∫')) // 积分符号
  assert_true!(is_symbol('≈')) // 约等于符号
  assert_true!(is_symbol('≠')) // 不等于符号
  assert_true!(is_symbol('≤')) // 小于等于符号
  assert_true!(is_symbol('≥')) // 大于等于符号

  // 几何符号和箭头
  assert_true!(is_symbol('△')) // 三角形
  assert_true!(is_symbol('□')) // 正方形
  assert_true!(is_symbol('○')) // 圆形
  assert_true!(is_symbol('→')) // 右箭头
  assert_true!(is_symbol('←')) // 左箭头
  assert_true!(is_symbol('↑')) // 上箭头
  assert_true!(is_symbol('↓')) // 下箭头
  assert_true!(is_symbol('↔')) // 左右箭头

  // 扑克牌和其他游戏符号
  assert_true!(is_symbol('♠')) // 黑桃
  assert_true!(is_symbol('♥')) // 红桃
  assert_true!(is_symbol('♦')) // 方块
  assert_true!(is_symbol('♣')) // 梅花
  assert_true!(is_symbol('♚')) // 国际象棋王

  // 全角符号
  assert_true!(is_symbol('＄')) // 全角美元符号
  assert_true!(is_symbol('％')) // 全角百分号

  // 非符号字符
  assert_false!(is_symbol('a')) // 小写字母
  assert_false!(is_symbol('A')) // 大写字母
  assert_false!(is_symbol('0')) // 数字
  assert_false!(is_symbol('.')) // 标点符号
  assert_false!(is_symbol('!')) // 标点符号
  assert_false!(is_symbol(' ')) // 空格
  assert_false!(is_symbol('\n')) // 控制字符
  assert_false!(is_symbol('α')) // 希腊字母
  assert_false!(is_symbol('漢')) // 汉字
}

///| 测试数字识别功能
test "is_number" {
  // 基本数字（通过is_digit已经识别）
  assert_true!(is_number('0'))
  assert_true!(is_number('1'))
  assert_true!(is_number('9'))

  // 全角数字
  assert_true!(is_number('０'))
  assert_true!(is_number('１'))
  assert_true!(is_number('９'))

  // 特殊数字字符
  assert_true!(is_number('²')) // 平方
  assert_true!(is_number('³')) // 立方
  assert_true!(is_number('¹')) // 一次方
  assert_true!(is_number('¼')) // 四分之一
  assert_true!(is_number('½')) // 二分之一
  assert_true!(is_number('¾')) // 四分之三
  assert_true!(is_number('⅓')) // 三分之一
  assert_true!(is_number('⅔')) // 三分之二

  // 罗马数字
  assert_true!(is_number('Ⅰ')) // 罗马数字 I
  assert_true!(is_number('Ⅴ')) // 罗马数字 V
  assert_true!(is_number('Ⅹ')) // 罗马数字 X
  assert_true!(is_number('ⅰ')) // 罗马小写数字 i
  assert_true!(is_number('ⅴ')) // 罗马小写数字 v
  assert_true!(is_number('ⅹ')) // 罗马小写数字 x

  // 上标和下标数字
  assert_true!(is_number('⁰')) // 上标 0
  assert_true!(is_number('⁹')) // 上标 9
  assert_true!(is_number('₀')) // 下标 0
  assert_true!(is_number('₉')) // 下标 9

  // 封闭式数字
  assert_true!(is_number('①')) // 圆圈数字 1
  assert_true!(is_number('⑩')) // 圆圈数字 10
  assert_true!(is_number('⑴')) // 括号数字 1
  assert_true!(is_number('⒑')) // 括号数字 10

  // 各种语言的数字
  assert_true!(is_number('٠')) // 阿拉伯-印度数字 0
  assert_true!(is_number('٩')) // 阿拉伯-印度数字 9
  assert_true!(is_number('۰')) // 东阿拉伯-印度数字 0
  assert_true!(is_number('۹')) // 东阿拉伯-印度数字 9
  assert_true!(is_number('०')) // 天城文数字 0
  assert_true!(is_number('९')) // 天城文数字 9

  // 汉字数字
  assert_true!(is_number('一')) // 汉字 "一"
  assert_true!(is_number('二')) // 汉字 "二"
  assert_true!(is_number('三')) // 汉字 "三"
  assert_true!(is_number('十')) // 汉字 "十"
  assert_true!(is_number('百')) // 汉字 "百"
  assert_true!(is_number('千')) // 汉字 "千"
  assert_true!(is_number('万')) // 汉字 "万"
  assert_true!(is_number('亿')) // 汉字 "亿"
  assert_true!(is_number('〇')) // 汉字 "零"

  // 非数字字符
  assert_false!(is_number('a')) // 字母
  assert_false!(is_number('A')) // 字母
  assert_false!(is_number('$')) // 符号
  assert_false!(is_number('.')) // 标点符号
  assert_false!(is_number(' ')) // 空格
  assert_false!(is_number('\n')) // 控制字符
  assert_false!(is_number('漢')) // 非数字汉字
}

///| 测试is_number和is_digit的关系
test "is_number_vs_is_digit" {
  // 基本数字两者都应该返回true
  assert_true!(is_digit('0'))
  assert_true!(is_number('0'))
  assert_true!(is_digit('9'))
  assert_true!(is_number('9'))

  // 扩展数字形式只有is_number应该返回true
  assert_false!(is_digit('①')) // 封闭数字不是基本数字
  assert_true!(is_number('①'))
  assert_false!(is_digit('½')) // 分数不是基本数字
  assert_true!(is_number('½'))
  assert_false!(is_digit('Ⅰ')) // 罗马数字不是基本数字
  assert_true!(is_number('Ⅰ'))
  assert_false!(is_digit('一')) // 汉字数字不是基本数字
  assert_true!(is_number('一'))

  // 非数字两者都应该返回false
  assert_false!(is_digit('a'))
  assert_false!(is_number('a'))
}

///| 测试图形字符识别功能
test "is_graphic" {
  // 字母
  assert_true!(is_graphic('a'))
  assert_true!(is_graphic('Z'))
  assert_true!(is_graphic('ä'))
  assert_true!(is_graphic('漢'))

  // 标记符号
  assert_true!(is_graphic('\u0300')) // 组合重音符号

  // 数字
  assert_true!(is_graphic('0'))
  assert_true!(is_graphic('9'))
  assert_true!(is_graphic('①'))

  // 标点符号
  assert_true!(is_graphic('.'))
  assert_true!(is_graphic(','))
  assert_true!(is_graphic('!'))

  // 符号
  assert_true!(is_graphic('$'))
  assert_true!(is_graphic('+'))
  assert_true!(is_graphic('©'))

  // 空白字符
  assert_true!(is_graphic(' ')) // ASCII 空格是图形字符
  assert_true!(is_graphic('\u00A0')) // NBSP是图形字符
  assert_true!(is_graphic('\u2002')) // EN SPACE是图形字符

  // 非图形字符
  assert_false!(is_graphic('\u0000')) // NULL
  assert_false!(is_graphic('\u0007')) // BELL
  assert_false!(is_graphic('\u001F')) // UNIT SEPARATOR
}

///| 测试可打印字符识别功能
test "is_print" {
  // 字母
  assert_true!(is_print('a'))
  assert_true!(is_print('Z'))
  assert_true!(is_print('ä'))
  assert_true!(is_print('漢'))

  // 标记符号
  assert_true!(is_print('\u0300')) // 组合重音符号

  // 数字
  assert_true!(is_print('0'))
  assert_true!(is_print('9'))
  assert_true!(is_print('①'))

  // 标点符号
  assert_true!(is_print('.'))
  assert_true!(is_print(','))
  assert_true!(is_print('!'))

  // 符号
  assert_true!(is_print('$'))
  assert_true!(is_print('+'))
  assert_true!(is_print('©'))

  // 空白字符
  assert_true!(is_print(' ')) // 仅ASCII空格是可打印的
  assert_false!(is_print('\u00A0')) // NBSP不是可打印字符
  assert_false!(is_print('\u2002')) // EN SPACE不是可打印字符
  assert_false!(is_print('\t')) // 制表符不是可打印字符
  assert_false!(is_print('\n')) // 换行符不是可打印字符

  // 控制字符
  assert_false!(is_print('\u0000')) // NULL
  assert_false!(is_print('\u0007')) // BELL
  assert_false!(is_print('\u001F')) // UNIT SEPARATOR
}

///| 测试is_graphic和is_print的关系
test "is_graphic_vs_is_print" {
  // 字母、数字、标点、符号都同时是图形字符和可打印字符
  assert_true!(is_graphic('a'))
  assert_true!(is_print('a'))
  assert_true!(is_graphic('0'))
  assert_true!(is_print('0'))
  assert_true!(is_graphic('.'))
  assert_true!(is_print('.'))

  // ASCII空格同时是图形字符和可打印字符
  assert_true!(is_graphic(' '))
  assert_true!(is_print(' '))

  // 其他空白字符是图形字符但不是可打印字符
  assert_true!(is_graphic('\u00A0')) // NBSP
  assert_false!(is_print('\u00A0'))
  assert_true!(is_graphic('\u2002')) // EN SPACE
  assert_false!(is_print('\u2002'))

  // 控制字符既不是图形字符也不是可打印字符
  assert_false!(is_graphic('\u0000'))
  assert_false!(is_print('\u0000'))
  assert_false!(is_graphic('\t'))
  assert_false!(is_print('\t'))
}
