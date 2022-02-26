
import Foundation

/// 为现有的类 结构体 枚举 协议 添加额外功能
///     没有名字
///     类似 OC 的分类
/// 能添加的东西：
///     计算属性            ---  不能添加存储属性   不能给已有属性添加属性观察器
///     方法                   ---  能添加新方法  不能重写已有方法
///     新的初始化器     ---  类 - 只能添加便捷初始化器
///     定义下标
///     新的内嵌类型
///     遵循协议
/// 格式：
///     extension SomeType: SomeProtocol, AnotherProtocol {
///         // implementation of protocol requirements goes here
///     }

class Msg{
    var type : Int = 0
    var content : String?
    var status : Int = -1
    var superMsg : Msg?
    var fingers : [String] = ["1", "2", "3", "4"]
    
    init(type: Int, content: String?){
        self.type = type
        self.content = content
    }
}

extension Msg{
    // 添加计算属性
    var isText : Bool{
        self.type == 0
    }
    
    // 添加初始化器
    convenience init(content: String?){
        self.init(type: 0, content: content)
    }
    
    // 添加方法
    func typeDesc() -> String{
        var desc = ""
        switch self.type{
        case 0:
            desc = "[文本]"
        case 1:
            desc = "[语音]"
        default:
            desc = "[未识别]"
        }
        return desc
    }
    
    // 添加下标
    subscript(index: Int) -> String?{
        guard index < self.fingers.count else{
            return "越界"
        }
        return self.fingers[index]
    }
    
    // 添加内嵌类型
    enum SendStatus{
       case failure, prepared, sending, success
    }
    var msgStatus: SendStatus{
        switch self.status{
        case let status where status < 0:
            return .failure
        case 1:
            return .sending
        default:
            return .prepared
        }
    }
}

var msg = Msg(type: 0, content: "文本消息")

let isText = msg.isText
let desc = msg.typeDesc()
let subs = msg[3]

msg.status = 1
let sts = msg.msgStatus
if sts == Msg.SendStatus.sending{
    print("sending")
}



struct Node{
    var index : Int
    var content : String?
//    var nextNode : Node?
}

extension Node{
    init(content: String?){
        self.init(index: 10, content: content)
    }
    
    mutating func indexSqual() -> Int{
        self.index * self.index
    }
}

var node = Node(content: "123")
let squal = node.indexSqual()
