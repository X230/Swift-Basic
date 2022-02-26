
import Foundation

/// 初始化器不返回值    第一次 使用之前确保正确的初始化
///     必须为所有存储属性设置初始值：
///         定义时  或者 初始化器  中进行设置   不会触发观察器
///         可选类型自动设置为nil
/// 规则：
///     指定初始化器必须从它的直系父类调用指定初始化器
///     便捷初始化器必须从相同的类里调用另一个初始化器
///     便捷初始化器最终必须调用一个指定初始化器
///
/// 两段式初始化：
///     完成自己存储属性的初始化，再沿着初始化链往上调用
///     调用属性方法做其他工作
///
///     自身存储属性的初始化 ---》  调用父类初始化 ---》 自身属性 方法的使用
///
/// 子类不会默认继承父类的初始化器
/// 继承规则：
///     添加的属性有默认值
///     没有定义指定初始化器时，会自动继承所有指定初始化器
///
///     如果子类实现所有父类指定初始化器，会自动继承所有便捷初始化器
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
let namedMeat = Food(name: "Bacon")
let defaultName = Food()

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    // 提供父类指定初始化的实现 （重写指定初始化器）
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
// 自动继承所有便捷初始器
let oneMysteryItem = RecipeIngredient()

class ShoppingListItem: RecipeIngredient {
    // 有默认值 没有初始化器
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}
// 继承所有的初始化器
var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]

// 可失败初始化器
class Product {
    var name: String = ""
    
    init(){}
    
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
 
class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
    // 非可失败 不能 调用 可失败
//    init(name: String, quantity: Int) {
//        self.quantity = quantity
//        super.init(name: name)
//    }
    
    // 使用非可失败 重写 可失败
    override init(name: String) {
        self.quantity = 1
        super.init()
        if name.isEmpty {
            self.name = "default"
        }
        else{
            self.name = name
        }
    }
}

let item = CartItem(name: "", quantity: 1)

// 必要初始化器   子类都必须实现
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}

// 使用闭包 函数 设置属性默认值
//class SomeClass1 {
//    let someProperty: SomeType = {
//        // 实例化时会自动执行闭包  在这里创建默认值   不能调用自己的属性 方法 （初始化还没完成）
//        return someValue
//    }()
//}
//
//// 反初始化  对象被释放前 执行额外的资源释放操作
//deinit {
//    // perform the deinitialization  不需要调用super  不需要（）
//}
