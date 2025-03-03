test "is_digit" {
    // ASCII 数字 (0-9)
    assert_true!(is_digit('0'))
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
    assert_true!(is_digit('٠'))  // 0
    assert_true!(is_digit('٥'))  // 5
    assert_true!(is_digit('٩'))  // 9
    
    // 波斯数字 (Persian digits)
    assert_true!(is_digit('۰'))  // 0
    assert_true!(is_digit('۵'))  // 5
    assert_true!(is_digit('۹'))  // 9
    
    // 天城文数字 (Devanagari digits)
    assert_true!(is_digit('०'))  // 0
    assert_true!(is_digit('५'))  // 5
    assert_true!(is_digit('९'))  // 9
    
    // 泰文数字 (Thai digits)
    assert_true!(is_digit('๐'))  // 0
    assert_true!(is_digit('๕'))  // 5
    assert_true!(is_digit('๙'))  // 9
    
    // 全角数字 (Fullwidth digits)
    assert_true!(is_digit('０'))  // 0
    assert_true!(is_digit('５'))  // 5
    assert_true!(is_digit('９'))  // 9
    
    // Unicode 非数字字符
    assert_false!(is_digit('א'))  // 希伯来字母
    assert_false!(is_digit('ش'))  // 阿拉伯字母
    assert_false!(is_digit('か'))  // 日语假名
    assert_false!(is_digit('漢'))  // 汉字
    assert_false!(is_digit('α'))  // 希腊字母
    assert_false!(is_digit('∞'))  // 数学符号
    
    // 边界测试
    assert_false!(is_digit('\u0000'))  // NULL字符
    assert_false!(is_digit('\u007F'))  // DELETE字符
    assert_false!(is_digit('\u0080'))  // Latin1开始
    assert_false!(is_digit('\u00FF'))  // Latin1结束
}


test "special_case_conversion" {
    // 拉丁字母扩展
    assert_eq!(to_lower('É'), 'é')
    assert_eq!(to_upper('é'), 'É')
    assert_eq!(to_lower('Ñ'), 'ñ')
    assert_eq!(to_upper('ñ'), 'Ñ')
    
    // 希腊字母
    assert_eq!(to_lower('Α'), 'α')  // Alpha
    assert_eq!(to_upper('α'), 'Α')
    assert_eq!(to_lower('Ω'), 'ω')  // Omega
    assert_eq!(to_upper('ω'), 'Ω')
    
    // 西里尔字母
    assert_eq!(to_lower('А'), 'а')  // Cyrillic A
    assert_eq!(to_upper('а'), 'А')
    assert_eq!(to_lower('Я'), 'я')  // Cyrillic Ya
    assert_eq!(to_upper('я'), 'Я')
    
    // 特殊情况
    assert_eq!(to_upper('ß'), 'S')  // 德语sharp s, 实际应该是"SS"
    
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
    
    // 特殊情况 - 德语锐音ß
    assert_eq!(to_upper('ß'), 'S')
}

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