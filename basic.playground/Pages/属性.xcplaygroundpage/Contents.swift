
import Foundation
import CoreGraphics

/// 类 结构体 枚举： 计算属性
/// 类 结构体：          存储属性  可设置属性观察器
///
///     swift里 属性没有与之对应的实例变量

struct Msg{
    // 变量存储属性
    var content : String?
    // 常量存储属性   必须在初始化完成之前有值
    let type : Int
    // 延时存储属性   必须是变量  初始值在第一次被使用时才计算
    lazy var finger: String? = "finger"
}
class MsgClass{
    // 变量存储属性
    var content : String?
    
    // 常量存储属性
    let type : Int
    
    // 延时存储属性   属性初始值依赖于外部因素  只有在初始化完成之后才能得到 或者 在需要时才去获取（懒加载）
    //              避免复杂的初始化
    //              多线程环境不能保证只初始化一次
    lazy var finger: String? = "finger"
    
    // 计算属性   实际不存储值， 通过提供 get set来间接的 获取 or 设置 其他属性和值
    var text: String{
        // 方式一
//        get{
//            if let text = self.content{
//                return text
//            }else{
//                return "no message"
//            }
//        }
        // 方式二   如果只有一行语句  可以使用隐式返回
        get{
            self.content ?? "no message"
        }
        // 方式一
//        set(text){
//            self.content = text
//        }
        // 方式二  没有命名 就是 newValue
        set{
            self.content = newValue
        }
    }
    
    // 只读计算属性 简写
    var readOnlyType : Int{
        return self.type < 0 ? 0 : self.type
    }
    
    init(content: String?, type: Int){
        self.content = content
        self.type = type
    }
}

var msg = Msg(content: "text content", type: 0)
msg.content = "video content"
// 常量存储属性 不能被修改
//msg.type = 1

// 常量结构体实例  不能修改属性值
let constMsg = Msg(content: "text content", type: 0)
//constMsg.content = "picture content"


// 常量类实例 可以改变量存储属性 不可改常量存储属性
let constClassMsg = MsgClass(content: "text content", type: 0)
constClassMsg.content = "doc content"
//constClassMsg.type = 1

// 延时存储属性
constClassMsg.finger = "lazy finger"

// 属性观察者
class StepCounter {
    var totalSteps: Int = 0 {
        willSet{
            print("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

// 属性包装  管理属性如何存储数据以及代码如何定义属性
//          感觉可以使用projectedValue来进行数据的校验，比如邮件的合法性、手机号码、长度要求等
//      替换属性的 getter 和 setter 中的重复代码特别有用。



// 定义一个包装  确保存入的值 不大于12
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

// 使用包装 在定义属性前 加 @包装名 由编译器来生成包装分理层的代码
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}
 
var rectangle = SmallRectangle()
print(rectangle.height) // Prints "0"

rectangle.height = 10
print(rectangle.height)  // Prints "10"

rectangle.height = 24
print(rectangle.height)  // Prints "12"

// 不使用特性语法方式  通过包装的实例对属性进行初始化  在计算属性的get set里 通过wrappedValue进行设置读取
struct SmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}

// 设定包装属性的初始值

// 定义包装 及初始化器 支持设置初始值或其他自定义
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
 
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
 
    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

// 包装属性 不使用初始化器时  默认调用init()
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}
 
var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)  // Prints "0 0"

// 初始值作为属性声明的一部分  调用init(wrappedValue: Int)
struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}
 
var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)  // Prints "1 1"

// 为属性包装添加实参  调用init(wrappedValue: Int, maximum: Int)   最通用
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}
 
var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)  // Prints "2 3"

// 通过属性包装映射值 projectedValue   通过定义映射值来暴露额外功能   属性包装可以返回它映射的任意类型值
@propertyWrapper
struct SmallNumber {
    private var number = 0
    var projectedValue = false
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
}

struct SomeStructure {
    @SmallNumber var someNumber: Int
}
var someStructure = SomeStructure()
 
someStructure.someNumber = 4
// 使用 s.$someNumber 来访问包装的映射值
print(someStructure.$someNumber)

/// 全局  局部变量
///     全局变量是定义在任何函数、方法、闭包或者类型环境之外的变量。
///     局部变量是定义在函数、方法或者闭包环境之中的变量
///     永远是延迟计算的
/// 类型属性
///     存储类型属性可以是变量或者常量    必须给一个默认值     第一次访问时延迟初始化一次
///     计算类型属性总要被声明为变量
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    // 计算属性用 class -- 允许子类重写
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
print(SomeClass.computedTypeProperty)





// UserDefault读写数据  免去一堆的getter和setter来从UserDefault中获取数据和存储数据
@propertyWrapper
class UserDefaultWrapper<Value> {
    
    private var key: String
    private var defaultValue: Value?
    
    init(key: String, defaultValue: Value? = nil) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: Value? {
        get {
            let std = UserDefaults.standard
            return std.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            let std = UserDefaults.standard
            if (newValue == nil) {
                std.removeObject(forKey: key)
            } else {
                std.setValue(newValue, forKey: key)
            }
            std.synchronize()
        }
    }
}

class USDemoClass {
    @UserDefaultWrapper(key: "money", defaultValue: 1) var money: Int?
    
    @UserDefaultWrapper(key: "age") var age: Int?
}

let value1 = USDemoClass()
print("value1.money: \(value1.money ?? 0)") // value1.money: 1
print("value1.age: \(String(describing: value1.age))") // value1.age: nil

// 该值将会写入UserDefault中，下次可以直接从UserDefault中获取
value1.money = 2
value1.age = 18
print("value1.money: \(value1.money ?? 0)") // value1.money: 2
print("value1.money: \(value1.age ?? 0)") // value1.age: 18

// https://juejin.cn/post/6844904153852936205   属性包装器 本地化
