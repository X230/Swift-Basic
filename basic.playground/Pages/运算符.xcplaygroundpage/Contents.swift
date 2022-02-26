
import Foundation

// 赋值符号 =  不会返回值
let x = 1, y = 2
//if x = y {
//    // 不合法
//}

if x == y{
    print("正确使用")
}

// + - * / % 可以检测并阻止值移除
var str = "dd" + "xx"   // + 支持字符串拼接
print(str)

var intV : Int8 = Int8.max
// 值溢出 报错
//intV = intV + 1

// - 128
intV = intV &+ 1
print(intV)

// ？？ 空合并运算符   a ?? b  a必须可选项  b 必须与 a 存储同类型值
var a : String? = ""
var b : String = "default"
// c 是否是可选 取决于 b
var c = a ?? b

// 闭区间运算符
for i in 0...5{
    print("index : \(i)")
}

// 半开区间
let arr = ["A", "B", "C", "D", "E"]
for i in 1..<3{
    // 1 2  -- B  C
    print("index: \(i) arr Value: \(arr[i])")
}

// 单侧开区间  尽可能的大
for item in arr[0...]{
    // 0 1 2 3 4
    print(item)
}

// 不能加空格
for item in arr[..<2]{
    // 0 1
    print(item)
}

let range = ...5  // PartialRangeThrough
let bool : Bool = range.contains(3)  // true

// 运算符重载
struct Vector2D {
    var x = 0.0, y = 0.0
}
 
prefix operator +++

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    // 前缀运算符
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    
    // 组合赋值运算符
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
    
    // 等价运算符
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    
    // 自定义运算符
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

/// 中缀运算符
/// 结合性：associativity  - left right  none   默认 none
/// 优先级:  precedence - 默认100
infix operator +- { associativity left precedence 140 }
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
