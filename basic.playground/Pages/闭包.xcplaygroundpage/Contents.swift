
import Foundation

/// 闭包：可以被传递和引用的独立代码块，能捕获上下文中的常量变量，由swift自动进行内存管理
///      函数 和 闭包 都是引用类型
/// 类型：
///         全局函数 -- 有名字 不会捕获值的闭包
///         内嵌函数 -- 有名字 从上层函数捕获值的闭包
///         闭包表达式 -- 没名字 从上下文中捕获值的闭包
/// 语法优化：
///         利用上下文推断参数 返回值类型
///         单表达式用隐式返回
///         简写实参名
///         尾随闭包
///

let names = ["Chris","Alex","Ewa","Barry","Daniella"]

// 排序规则
func compare(v1: String, v2: String) -> Bool{
    return v1 > v2
}

// 返回排序后的新数组  不会影响原数组
let sortedArr = names.sorted(by: compare)

// 闭包表达式
// 能使用 常量、变量 和 输入输出 形式参数，但不能提供默认值，可变形式参数只能在参数列表最后
//{ (parameters) -> (return type) in
//    statements
//}

// 完整格式
let sortedArr1 = names.sorted(by:{
    (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// 上下文推断参数类型 返回类型
let sortedArr2 = names.sorted(by: { s1, s2 in
    return s1 > s2
})

// 隐式返回
let sortedArr3 = names.sorted(by: { s1, s2 in
    s1 > s2
})

// 简写实参名
let sortedArr4 = names.sorted(by: {
    $0 > $1
})

// 运算符函数
let sortedArr5 = names.sorted(by: >)

// 尾随闭包  闭包表达式作为函数最后一个实参  （可以有多个尾随闭包）
let sortedArr6 = names.sorted() {
    $0 > $1
}
// 尾随闭包是唯一参数  省略（）
let sortedArr7 = names.sorted {
    $0 > $1
}

// 单个尾随闭包
func method(num1: Int, num2: Int, calculate:(Int, Int)->Int) -> Int{
    let result = calculate(num1, num2)
    return result
}
let result = method(num1: 1, num2: 2){
    (num1, num2) -> Int in
    return num1 + num2
}
let result1 = method(num1: 1, num2: 3, calculate: -)

// 多个尾随闭包
func loadData(from server: NSString, success:(Int)->Void, onFailure:(Int)->Void){
    // 执行任务 ...
    let code = 500
    if code == 200{
        success(code)
    }
    else{
        onFailure(code)
    }
}
// 调用方省略第一个的参数标签
loadData(from: "server"){
    code in
    print("success")
} onFailure:{
    code in
    print("failure:\(code)")
}

/// 值捕获  闭包内部可以访问上下文中的值
///         当不需要改变值时  只是进行拷贝
///         需要改变值内容时，进行引用的捕获
///         在不需要时 进行内存的释放

/// 逃逸闭包
///     闭包作为函数实参，在函数结束后调用 - （逃离了函数的作用域）   --- 在函数形参前 @escaping 声明是逃逸闭包
///
///         闭包存储在函数之外的变量中   -- 进消息页注册闭包回调  存储在provider的集合中  等来消息时才取出调用
///
///         异步回调 -- 调用函数 - 执行异步任务 - 函数结束 - 异步完成 - 执行闭包回调  --- 闭包生命周期长于函数
///
///     逃逸闭包里引用self 可能造成循环引用
///     逃逸闭包不能捕获 结构体 的 可编辑引用 self
///

//override func viewDidLoad() {
//    super.viewDidLoad()
//    getData { (data) in
//        print("闭包结果返回--\(data)--\(Thread.current)")
//    }
//}
//
//func getData(closure:@escaping (Any) -> Void) {
//    print("函数开始执行--\(Thread.current)")
//    DispatchQueue.global().async {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
//            print("执行了闭包---\(Thread.current)")
//            closure("345")
//        })
//    }
//    print("函数执行结束---\(Thread.current)")
//}

//// 逃逸闭包 显示的引用self
//someFunctionWithEscapingClosure { self.x = 100 }
//// 将self放到捕获列表
//someFunctionWithEscapingClosure { [self] in x = 100 }
//
//// 非逃逸闭包 隐式的引用self
//someFunctionWithNonescapingClosure { x = 200 }

// 自动闭包 @autoclosure 把⼀句表达式⾃动地封装成⼀个闭包   不接受参数
// 延时处理 在调用时才执行 避免占用资源

func || (left:Bool, right:Bool)-> Bool {
    if left {
        return true
    }else {
        return right
    }
}
func ||(left:Bool, right: @autoclosure()->Bool) -> Bool {
    if left {
        return true
    }else {
        // 调用时才执行
        return right()
    }
}

