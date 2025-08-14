//这里放置一些常量

///|
const ReplacementChar = '\uFFFD' // Represents invalid code points.

///|
const MaxASCII = '\u007F' // maximum ASCII value.

///|
const MaxLatin1 = '\u00FF' // maximum Latin-1 value.

///|
pub let individual_puncts = [
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

// 判断Unicode标点符号范围

///|
pub let ranges = [
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

// Latin1标点符号列表（明确列出，而非范围）

///|
pub let latin1_puncts = [
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
// 创建一个范围表，包含所有Unicode数字的范围
// 每个范围是[start, end, 0]三元组
// 0表示这是个连续范围

///|
pub let numRanges = [
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

///|土耳其字符特殊转化    
pub let turkish_case : SpecialCase = [
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

// 部分标记字符特殊处理

///|
pub let mark_chars = [
  // 上标符号 (Modifier Symbol)
  0x02B0, 0x02B8, // 上标小写字母
   0x02E0, 0x02E4, // 上标小写字母

  // 封闭的字母数字 (Enclosed Alphanumerics)
   0x24D0, 0x24E9, // 封闭的小写字母

  // IPA 扩展的修饰符号
   0x02ED, 0x02EF,

  // 上标以及下标
   0x207A, 0x207E, // 上标符号
   0x208A, 0x208E, // 下标符号
]

// 常见 Unicode 空白字符

///|
pub let space_chars = [
  0x1680, 0, // 欧甘字母空格
   0x2000, 0x200A, // 各种宽度空格 (包含 0x2001, 0x2002, 0x2003 等)
   0x2028, 0, // 行分隔符
   0x2029, 0, // 段落分隔符
   0x202F, 0, // 窄不换行空格
   0x205F, 0, // 中度数学空格
   0x3000, 0, // 表意文字空格
]

// 其他重要的 Unicode 控制字符

///|
pub let control_chars = [
  0x061C, // 阿拉伯语标记 (ALM)
   0x070F, // 叙利亚语缩写标记
   0x180B, 0x180D, // 蒙古语母音分隔符
   0x180E, // 蒙古语元音分隔符
   0x200C, // 零宽非连接符 (ZWNJ)
   0x200D, // 零宽连接符 (ZWJ)
   0x200E, // 左至右标记 (LRM)
   0x200F, // 右至左标记 (RLM)
   0x202A, 0x202E, // 双向格式化字符
   0x2060, 0x2064, // 单词连接符和其他不可见格式化字符
   0x2066, 0x206F, // 其他格式化字符
   0xFEFF, // 零宽不换行空格 (BOM)
   0xFFF9, 0xFFFB, // 互操作格式标记
   0x110BD, // 库达文体标记
   0x1BCA0, 0x1BCA3, // 速记格式控制
   0x1D173, 0x1D17A, // 音乐格式控制
   0xE0001, // 语言标签
   0xE0020, 0xE007F, // 标签字符
]

// 检查常见Unicode符号块之外的特定符号
// 例如：€ (欧元), ℃ (摄氏度), ™ (商标), № (编号),

///|
pub let specific_symbols = [
  0x20AC, // € (欧元符号)
   0x2103, // ℃ (摄氏度符号)
   0x2116, // № (编号符号)
   0x2122, // ™ (商标符号)
   0x2139, // ℹ (信息符号)
   0x2194, // ↔ (左右箭头)
   0x21D2, // ⇒ (右双箭头)
   0x21D4, // ⇔ (双向双箭头)
   0x2200, // ∀ (全称量词符号)
   0x2203, // ∃ (存在量词符号)
   0x2208, // ∈ (属于符号)
   0x220F, // ∏ (连乘符号)
   0x2211, // ∑ (求和符号)
   0x221E, // ∞ (无穷大符号)
   0x222B, // ∫ (积分符号)
   0x2248, // ≈ (约等于符号)
   0x2260, // ≠ (不等于符号)
   0x2264, // ≤ (小于等于符号)
   0x2265, // ≥ (大于等于符号)
]

// 14. 特殊数字字符

///|
pub let special_nums = [
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

// 10. 汉字数字
// 一、二、三、四、五、六、七、八、九、十、百、千、万、亿

///|
pub let han_nums = [
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
