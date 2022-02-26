
import Foundation

/// 默认情况下，Swift 会阻止你代码中发生的不安全行为。
///     Swift 会保证在使用前就初始化，
///     内存在变量释放后这块内存就不能再访问了，
///     数组会检查越界错误
///     通过要求标记内存位置来确保代码对内存有独占访问权,避免访问冲突

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

// 弱引用 weak : 可能变为nil   可选类型
// 可选项检查避免野指针
class CreditCard {
    let number: UInt64
    weak var customer: Customer?
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}


// 无主引用 unowned : 初始化后不会再置为nil    非可选类型
// 如果实例释放后  再使用无主引用  会报错
class CreditCard1 {
    let number: UInt64
    // 安全的无主引用
    unowned var customer: Customer
    
    // unowned(unsafe) 不安全的无主引用  释放后 还会尝试访问之前的内存地址
    unowned(unsafe) var customer1: Customer
    
    // 无主可选引用：需要负责保证它总引用到一个合法对象或 nil
    unowned var customer2: Customer?
    
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

// 闭包的循环引用   实例持有闭包  闭包捕获了实例：使用了实例的 属性 或 方法
class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
}

// 解决：定义捕获列表  [捕获列表](形参) in  code
lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}

lazy var someClosure: () -> String = {
    [unowned self, weak delegate = self.delegate!] in
    // closure body goes here
}

// inout 内存访问冲突   -- 同时访问同一块内存 可能导致结果不一致
var stepSize = 1
 
func increment(_ number: inout Int) {
    number += stepSize
}
 
increment(&stepSize)


// 解决： 显示拷贝一份再更新
var copyOfStepSize = stepSize
increment(&copyOfStepSize)

stepSize = copyOfStepSize

/// mutating  值类型（结构体 枚举 元组）属性访问  包装线程安全
///     只访问实例的存储属性，不是计算属性或者类属性；
///     结构体是局部变量而非全局变量；
///     结构体要么没有被闭包捕获要么只被非逃逸闭包捕获。
