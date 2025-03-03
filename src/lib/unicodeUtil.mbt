
const ReplacementChar = '\uFFFD'   // Represents invalid code points.
const MaxASCII        = '\u007F'  // maximum ASCII value.
const 	MaxLatin1       = '\u00FF' // maximum Latin-1 value.

const Digit = 9

pub fn is_digit(r: Char) -> Bool {
    // 处理ASCII和Latin1范围内的字符
    if r <= MaxLatin1 {
        return '0' <= r && r <= '9'
    }
    // 处理其他Unicode范围的数字字符
    return is_excluding_latin(Digit, r)
}





///| 检查非Latin1范围内的字符是否属于指定类别
pub fn is_excluding_latin(category: Int, r: Char) -> Bool {
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
            0x0BE6, 0x0BEF, 0
        ]
        
        return search_range(ranges, code)
    }
    
 
    
    return false
}

///| 在排序好的范围表中搜索一个码点
fn search_range(ranges: Array[Int], target: Int) -> Bool {
    let mut i = 0
    while i < ranges.length() {
        let start = ranges[i]
        let end = ranges[i + 1]
        
        if target >= start && target <= end {
            return true
        }
        
        i = i + 3  // 跳过一个三元组
    }
    return false
}
