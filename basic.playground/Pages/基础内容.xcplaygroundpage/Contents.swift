import UIKit

//-------- 常量 变量 --------
// 1.常量的值 设定之后就不能再修改
let maxLoginTimes = UInt8.max
let color = 0x110011
let expnum = 1.25e4  // 1.25 * 10 ^ 4  -- 12500
let sepnum = 1_000_000

// 2.常量使用之前 必须赋值
let maxTimes : Int
maxTimes = 10
print("maxTimes\(maxTimes)")

var loginTimes = 0

// 3.逗号分隔 一行定义多个常量 变量
let a = 0, b = 1, c = 2
var a1 = 1, b1 = 2.0, c1 = true

// 1 2.0 true
print(a1,b1,c1)

// 4.类型标注 -- 确定了类型 就不能再存储其他类型的值
let name : String = "daixu"

// 5.同一类型
var red = 0, green = 0.5, blue : Double
blue = 1.0

// red:0 green:0.5 blue:1.0
print("red:\(red) green:\(green) blue:\(blue)")

// 6.不同类型
var re : Int = 1, gr : Double = 0.5, bl : Float = 0.2

// red:1 green:0.5 blue:0.2
print("red:\(re) green:\(gr) blue:\(bl)")

// 7.类型推断  类型安全 ： 编译期进行  根据初始化值进行类型推断  编译期进行类型检查

// 8.类型转换
let aTemp = 12.5
let sTemp = "123"
var translateResult = Int(aTemp)  // 12
translateResult = Int(sTemp) ?? 0 // 123

var strToInt : Int?
strToInt = Int(sTemp) // 123

// 9.元组  -- 一个函数返回多个值
let httpError = (404, "not found")  // (Int, String)
let httpErr1 = (code : 404, msg : "not found") // code msg 不是字符串 不加“” ==变量名
let (code, msg) = (404, "not found")

// 10.可选项    oc nil -- 指针 指向不存在的对象   swift nil 特殊的值 表示值缺失 非引用类型也可以设置

var ageNil : Int? = 10
// 可选变量 默认值就是 nil
var strNil : String? = "222"

// 确定包含值 强制解包  没有值+强制解包 -- 报错
print("age:\(ageNil!)")

// 可选绑定 -- 将可选项的值 解包出来 赋值给一个常量或变量
if let tempOp = ageNil {
    print("age:\(tempOp)")
}else{
    // 为nil时 执行
    print("ageNil = nil")
}

// 可选类型 先解包 再进行类型转换  不解包就报错
if let num = Int(strNil!){
    // num 只在作用域内 有效
    print("可以转为整型：\(num)")
}
// ==> if嵌套
if let str = strNil{
    if let num = Int(str){
        print("可以转为整型：\(num)")
    }
}
// ==>
if let str = strNil, let num = Int(str), num > 0 && num < 1000{
    print("可以转为整型：\(num)")
}

// 隐式展开可选项 -- 一旦赋值后 就会一直有值 使用时可去掉检查（自动进行展开）  一般用于类的初始化过程中
let assumStr : String! = "必须一直有值 如果有可能变为nil 则使用普通可选项"

// 12.断言调试
let age = 10
// 添加断言  条件成立时 继续执行  否则终止程序
assert(age > 0, "age must large than 0")

// 13.强制先决条件 -- 如果不满足条件 则显示提示信息
precondition(age > 0, "age must large than 0")

