import Foundation

/// open : 任意模块    用于类 类成员   可以被其他模块继承 重写
/// public: 任意模块   不允许被继承 重写
/// internal：同一模块任意源文件
/// fileprivate: 同一个文件内可访问
/// private: 定义实体的封闭声明中访问
///
/// 不可以被更低访问级别的实体定义：
///     public 变量 不能用 private 类来定义
///     函数不能比 参数 返回类型级别更高
///     子类不能高于父类
///
/// 类型的级别 会影响 成员的默认级别
///
/// 元组类型：使用时自动推断  使用元素最严格的级别
///
/// 函数类型：参数 返回值最严格级别   （参数 返回值  >= 函数）

// 全局函数  返回类型 （internal, private） --> private   与上下文级别不匹配
func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    
}

// 正确写法  使用 public  internal是无效的
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    
}

// 继承 重写 子类的访问级别
public class A {
    fileprivate func someMethod() {}
}
internal class B: A {
    override internal func someMethod() {
        // 同一个文件内 可以调用
        super.someMethod()
    }
}

/// 常量、变量、属性 不能拥有比它们 类型 更高的访问级别
/// 下标 不能拥有比它的 索引类型 和 返回类型 更高的访问级别

// 属性set 访问级别  fileprivate(set) , private(set) , 或 internal(set)
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

public struct TrackedString {
    // 外部可读 不可写
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

/// 初始化器
///     默认初始化 = 类 级别  （public类 默认为 internal）
///     必要初始化器 必须 和 类 级别一直
///     自定义初始化器 不能大于 类别
///     参数 不能比 方法 低

/// 协议
///     每个要求级别 必须与 协议一致
///     子协议 不能 高于 父协议
///     高级别类型 可遵循 低级别协议    之后  类型级别 为 协议级别
///      -- public类 遵循 internal协议  类级别变成了internal

/// 扩展
///     添加的任何成员都与类型相同
///     显示标准扩展级别  给成员设置新的默认级别
///     遵循协议的扩展不能显示标注修饰符



