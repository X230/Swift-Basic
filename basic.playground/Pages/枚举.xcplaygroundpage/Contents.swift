
import Foundation

/// 不需要给枚举的每个成员都提供值
///         不会在创建时 默认分配一个整数值
///
/// 原始值：可以是 字符 字符串  整数 浮点数
/// 关联值：成员可以指定 任意类型 的值来与 不同的成员值 关联储存
///         可以定义  一组相关成员的合集 作为枚举的一部分，
///         每一个成员  都可以有  不同类型的值的合集  与其关联
/// 其他特性：
///         计算属性：用来提供关于枚举当前值的额外信息
///         实例方法：用来提供与枚举表示的值相关的功能
///         初始化器：来初始化成员值
///         遵循协议：来提供标准功能


// 定义枚举
enum Direction {
    case north
    case south
    case east
    case west
}

enum MsgType{
    case text, video, audio, document
}

var direction = Direction.north

// 确定类型之后 类型推断
direction = .south
var type : MsgType = .text


// 遍历  一个集合 包含 枚举的所有情况
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count

for beverage in Beverage.allCases {
    print(beverage)
}


// 关联值
// 将额外的自定义信息 与 成员值 一起存储  -- 每次使用成员的时候 都可以拿到这些额外的信息
// 不同成员的关联值类型 可以不同
enum Code{
    case barCode(Int, Int, Int, Int)
    case qrCode(String)
}
var barcode = Code.barCode(1, 2, 3, 4)
barcode = .qrCode("二维码内容")

switch barcode{
    // 单个提取
case .barCode(let system, let facture, let product, let check):
    print("upc:\(system),\(facture),\(product),\(check)")
    // 同一提取
case let .qrCode(content):
    print("qr code :" + content)
}

// 原始值
// 成员用相同类型的默认值预先填充
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

// 隐式原始值  不需要为每个成员显示指定  swift自动分配
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
// 字符串用于原始值时   默认就是成员名称
enum CompassPoint: String {
    case north, south, east, west
}
let rawV = ASCIIControlCharacter.tab.rawValue

// 原始值可失败初始化器
let planet : Planet? = Planet(rawValue: 3)

// 递归枚举 -- 另一个枚举 作为 成员的关联值  indirect
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression1 {
    case number(Int)
    case addition(ArithmeticExpression1, ArithmeticExpression1)
    case multiplication(ArithmeticExpression1, ArithmeticExpression1)
}
// (5 + 4) * 2
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
 
print(evaluate(product))

