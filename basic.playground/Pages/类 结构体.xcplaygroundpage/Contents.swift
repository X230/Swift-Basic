
import Foundation
import UIKit

/// 类 结构体都能做的事：
///     定义属性：存储值
///     定义方法：提供功能
///     定义下标脚本：使用下标访问值
///     定义初始化器：初始化状态
///     扩展：默认没有的功能
///     协议：特定类型提供标准功能
/// 类特有：
///     继承
///     类型转换：运行时检查实例的类型
///     反初始化器：类实例释放被分配的资源
///     引用计数：多个引用指向同一个实例
/// 结构体：
///     通过复制来传递  不会使用引用计数
///
///     拷贝操作由swift来管理 只有在需要时 才进行实际的拷贝  而不是一赋值就执行拷贝
///
/// 区别OC:
///     swift可以直接设置结构体子属性的值  frame.size.width = 10
///

struct Size{
    var width = 0
    var height = 0
}
class View{
    var size = Size(width:10, height:20)
    var color = UIColor.red
    var alpha = 0.1
    var name : String?
}

// 结构体自动生成一个成员初始化器   类没有
var size = Size(width: 20, height:40)
print("size width = \(size.width), height = \(size.height)")

var size1 = size  // 完全两个不同的实例   copy的一份


// 类
var view = View()
view.size = size
view.name = "view_init"

var view1 = view
view1.name = "view_copy"
view1.size.width = 50    // 对结构体的成员 可以直接修改
print(view.size.width)   // 50  两个引用 指向同一个实例

// 判断类实例是否相等 ===   不能用于值类型  判断两个变量是否引用同一个实例
let isEqual = view === view1

