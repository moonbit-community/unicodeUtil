fn main {
  // ===== to_lower 测试 =====
  println("===== to_lower 测试 =====")
  
  // ASCII 大写字母
  println(@lib.to_lower('A')) // 'a'
  println(@lib.to_lower('Z')) // 'z'
  
  // ASCII 已经是小写的字母
  println(@lib.to_lower('a')) // 'a'
  println(@lib.to_lower('z')) // 'z'
  
  // ASCII 非字母字符
  println(@lib.to_lower('0')) // '0'
  println(@lib.to_lower('!')) // '!'
  
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
  
  // ===== to_upper 测试 =====
  println("===== to_upper 测试 =====")
  
  // ASCII 小写字母
  println(@lib.to_upper('a')) // 'A'
  println(@lib.to_upper('z')) // 'Z'
  
  // ASCII 已经是大写的字母
  println(@lib.to_upper('A')) // 'A'
  println(@lib.to_upper('Z')) // 'Z'
  
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
  println(@lib.to_upper('i')) // 'İ' (i with dot)
  println(@lib.to_upper('ı')) // 'I' (dotless i)
  
  // 特殊德语字符
  println(@lib.to_upper('ß')) // 'S' (简化实现，实际应该是"SS")
  
  // 非字母Unicode字符
  println(@lib.to_upper('漢')) // '漢' (unchanged)
  println(@lib.to_upper('☺')) // '☺' (unchanged)
  
  // ===== string_to_lower/upper 测试 =====
  println("===== 字符串转换测试 =====")
  
  // 英文字符串
  println(@lib.string_to_lower("HELLO WORLD"))  // "hello world"
  println(@lib.string_to_upper("hello world"))  // "HELLO WORLD"
  
  // 混合字符串
  println(@lib.string_to_lower("HeLLo WoRLd"))  // "hello world"
  println(@lib.string_to_upper("HeLLo WoRLd"))  // "HELLO WORLD"
  
  // 带重音符号的字符串
  println(@lib.string_to_lower("CAFÉ RÉSUMÉ"))  // "café résumé"
  println(@lib.string_to_upper("café résumé"))  // "CAFÉ RÉSUMÉ"
  
  // 多语言混合字符串
  println(@lib.string_to_lower("ABCαβγАБВ"))    // "abcαβγабв"
  println(@lib.string_to_upper("abcαβγабв"))    // "ABCΑΒΓАБВr"
  
  // 土耳其语特殊字符
  println(@lib.string_to_lower("IİıJ"))        // "ıiıj"
  println(@lib.string_to_upper("iIıİ"))        // "İIIİ"
}