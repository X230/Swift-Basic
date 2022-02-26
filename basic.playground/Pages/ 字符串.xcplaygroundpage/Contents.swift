
import Foundation

// 1.导入Foundation  可以访问所有NSString的方法

var str = "hello world"

// 多行字符串 “”“    要内容不包含换行符  末尾加 \
var strMutiLine = """
            hello\
            "world"
            """
print(strMutiLine)

// 扩展字符串  包含特殊字符
let strSpe = #"Line 1\nLine 2"#
print(strSpe) // Line 1\nLine 2    \n被当作字符串的内容 而不是换行符

let strSpe1 = #"Line 1\#nLine 2"#
/**
    Line 1
    Line 2
 */
print(strSpe1)

// 创建空串
var emptyStr = ""
var emptyStr1 = String()
if emptyStr1.isEmpty{
    print("emptyStr is empty")
}

emptyStr += "通过+拼接（追加）"

// 字符串是值类型  copy只在需要的时候进行
var tempStr = emptyStr
tempStr = "重新赋值 只对自己生效"
// emptyStr:通过+拼接（追加） tempStr:重新赋值 只对自己生效     emptyStr copy一份给tempStr 传值
print("emptyStr:" + emptyStr + "tempStr:" + tempStr)

// 字符
// 转成单个字符进行访问
for char in tempStr{
    print(char)
}

let char : Character = "A"
let chars : [Character] = ["A","p","p","l","e"]
var appStr = String(chars)
print(appStr)

appStr.append(" io")
appStr.append("s")

// 插值与扩展符
print(#"6 times 7 is \(6 * 7)."#)
print(#"6 times 7 is \#(6 * 7)."#)

// 只能索引Index访问特定位置的字符
var oriStr = "apple newbee"

// 没法用整数值访问  只能是 index
//let char = oriStr[0]

// 第一个字符的位置
let firstIndex = oriStr.startIndex
let charF = oriStr[firstIndex]      // a

// 最后一个字符后的位置
let endIndex = oriStr.endIndex
let charE = oriStr[endIndex]    // 越界

// 前一个索引位置
let endIndexRight = oriStr.index(before: endIndex)
//let charE = oriStr[endIndexRight]  // e

// 偏移位置索引
let midIndex = oriStr.index(firstIndex, offsetBy: 3)
let midChar = oriStr[midIndex]    // l

// 遍历所有索引
for index in appStr.indices{
    print(index)
}

for index in oriStr.indices{
    print(oriStr[index])
}

/**
    只要实现了 Indexable 协议  都有属性 startIndex endIndex 和方法 index(before:) index(after:) 和 index(_:offsetBy:)
    String  Array  Dictionary  Set
 */

// 插入到特定索引
// 插入字符
appStr.insert(".", at: appStr.endIndex)

// 插入字符串
appStr.insert(contentsOf: "swift", at: appStr.endIndex)
print(appStr)

// 移除字符
appStr.remove(at: appStr.index(before: appStr.endIndex))

// 移除子串
let range0 = appStr.range(of: "ios")
if let r = range0{
    appStr.removeSubrange(r)
}

let range = appStr.index(appStr.endIndex, offsetBy: -4) ..< appStr.endIndex
appStr.removeSubrange(range)
print(appStr)

/**
    RangeReplaceableIndexable 协议 都有方法insert(_:at:) ， insert(contentsOf:at:) ， remove(at:)
    String Array Dictionary Set
 */

// 子字符串  Substring类型 有String大多方法 -- 都遵循StringProtocal协议
// 子串会重用原串或其他子串的内存 --- 只要子串在使用 原串就不会释放   子串短期活动  长期保留需要转换成新串
let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]  //"Hello"
 
// 转换成字符串 for long-term storage.  由新的内存存储
let newString = String(beginning)

// 字符串比较
let isequal = greeting == appStr
let hasPre = greeting.hasPrefix("hello")
let hasSuf = greeting.hasSuffix("world!")



