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