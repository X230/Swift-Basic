
import Foundation

/// 类 结构体 枚举 都能定义下标：
///     作为访问集合、列表或序列成员元素的快捷方式 -- 使用索引来设置 获取值
/// 可以定义多个下标：
///     会根据传入的索引值的类型选择合适的下标重载使用
/// 下标没有维度限制：
///     使用多个  任意类型  的输入形参  来定义下标以满足自定义类型的需求

// 定义语法  参数可以多个 任意类型  返回值任意类型
//          可以使用变量形参 可变形参
//          不能是inout  不能设默认值
subscript(index: Int) -> Int {
    get {
        // return an appropriate subscript value here
    }
    // newValue 可以省略  会默认提供
    set(newValue) {
        // perform a suitable setting action here
    }
}


struct TimesTable {
    let multiplier: Int
    // 只读下标 可以省略get
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
// 使用
print("six times three is \(threeTimesTable[6])")

// 多参下标
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

// 类型下标   stack  or  class
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
