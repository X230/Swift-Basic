
import Foundation

// 泛型函数
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 泛型栈
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("uni")
let fromTheTop = stackOfStrings.pop()

// 扩展泛型类型 -- 不需要再定义类型形参  使用原始类的形参 Element
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}

// 类型约束 -- 必须继承某个类 或者遵循协议 协议组合
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(of: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

let idx = strings.firstIndex(of: "llama")

// 关联类型  协议里使用泛型  遵循协议的类型来具体指定类型
protocol Container {
    // 关联类型 并 添加约束
    associatedtype ItemType : Equatable
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
    
    // 关联类型的where分句
    associatedtype Iterator: IteratorProtocol where Iterator.Element == ItemType
    func makeIterator() -> Iterator
}

struct Stack1<Element: Equatable>: Container {
    
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // 实现协议方法  类型推断 协议里 ItemType的具体类型
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
    
    func makeIterator() -> some IteratorProtocol {
        return items.makeIterator()
    }
}

// 泛型where分句
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
    
    return false
}

// 泛型扩展 where分句
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

// 协议扩展
extension Container where ItemType: Equatable {
    func startsWith(_ item: ItemType) -> Bool {
        return count >= 1 && self[0] == item
    }
}

// 上下文where分句
extension Container {
    func average() -> Double where ItemType == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: ItemType) -> Bool where ItemType: Equatable {
        return count >= 1 && self[count-1] == item
    }
}

// 泛型下标
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [ItemType]
        where Indices.Iterator.Element == Int {
            var result = [ItemType]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}

/// 隐藏返回值的类型信息  保存类型特征
///     引用为特定的类型,调用者不能看到
///     能给你更多关于具体类型的保证
/// 协议类型
///     引用到任何遵循这个协议的类型
///     能提供更多存储值的弹性

protocol Shape {
    func draw() -> String
}

// 返回值  某个遵循了Shape协议的类型
func flip<T: Shape>(_ shape: T) -> some Shape {
    return FlippedShape(shape: shape)
}
