
import Foundation

protocol MsgProtocal{
    // 属性要求  -- 名称 类型 读写性   不指定是存储还是计算属性
    var content: String? {get set}
    var desc: String{get}
    static var type: Int {get set}
    
    // 方法要求  参数不能有默认值
    func msgContent(type: Int) -> String?
    
    static func random() -> Int
    // 类实现方法 可不加mutating
    mutating func toggle()
    
    // 初始化器要求  可用 指定 or 便捷初始化器 来提供实现
    //             必须用 required 来修饰 （final类 不需要）
    //             子类重写父类 并遵循协议   required override init()
    init(content: String?)
    
    // 协议是一个类型   可用来当参数 返回值 定义属性等等
}

protocol TextRepresentable {
    var textualDescription: String { get }
}

// 使用扩展遵循协议
extension String: TextRepresentable {
    var textualDescription: String {
        return "textualDescription"
    }
}

// 泛型类型 有条件遵循协议
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

// 协议继承 -- 添加更多的要求
protocol PrettyTextRepresentable: TextRepresentable, Comparable {
    var prettyTextualDescription: String { get }
}

// 限定只能被类遵循  AnyObject
protocol SomeClassOnlyProtocol: AnyObject, TextRepresentable {
    // class-only protocol definition goes here
}

// 协议组合类型  协议1 & 协议2 ... -- 遵循协议1 和 2      类A & 协议1 ...  -- 是A的子类并遵循协议1
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

class Person1: Aged {
    var name: String = "name"
    var age: Int = 10
}
func wishHappyBirthday1(to celebrator: Person1 & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

// 协议遵循检查  is  as

// 可选协议  不能被结构体 枚举遵循
@objc protocol CounterDataSource {
    // 方法或属性 自动变为可选类型  （Int）->Int ---> ((Int)->Int)?
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        // 可选链调用
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        }
        // 解包
        else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

// 协议扩展 ： 给协议创建扩展，所有的遵循类型 自动获得这个方法的实现 而不需要任何额外的修改
protocol RandomNumberGenerator {
    func random() -> Double
}

extension RandomNumberGenerator {
    // 提供默认实现   可以被覆盖
    func random() -> Double{
        return Double.random(in: 0...1)
    }
    
    // 扩展额外方法  
    func randomBool() -> Bool {
        return random() > 0.5
    }
}




class Msg: MsgProtocal{
    var content: String?
    static var type: Int = 2
    
    var desc: String{
        return "[文本]"
    }
    
    enum SwitchEnum{
        case on, off
    }
    var openStatus : SwitchEnum = .on
    
    required init(content: String?){
        self.content = content
    }
    
    func msgContent(type: Int) -> String? {
        return "12"
    }
    
    static func random() -> Int {
        return 1
    }
    
    func toggle() {
        switch self.openStatus{
        case .on:
            openStatus = .off
        case .off:
            openStatus = .on
        }
    }
}


