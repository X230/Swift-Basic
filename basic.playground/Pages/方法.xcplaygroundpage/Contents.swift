
import Foundation

/// 值类型方法
///     值类型的属性默认不能被自己实例方法修改
/// mutating 方法变异：
///     可以修改属性 并在方法结束时，将改变写入到原始结构体中
///     可以将全新的实例给self属性， 方法结束时，替换掉现存的实例
struct Point {
    var x = 0.0, y = 0.0
    // 修改属性
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    // 替换自身
    mutating func moveBy1(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        // 设置self为其他成员
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

// 类型方法：  static关键字   类可以使用class 关键字  允许子类重写
//          隐含的self 指向类本身  而不是实例
class SomeClass {
    // 允许子类重写
    class func someTypeMethod() {
        // type method implementation goes here
    }
    
    // 不允许重写
    static func someMethod(){
        
    }
}

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}
