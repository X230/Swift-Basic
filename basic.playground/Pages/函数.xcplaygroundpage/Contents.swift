
import Foundation

// 定义函数
//func greeting(name : String) -> String{
//    let greet = "hello " + name
//    return greet
//}
//print(greeting(name:"dx"))  // hello dx
 
// 隐式返回 只有一行时  不写 return
//func greeting(name : String) -> String{
//    "hello " + name
//}

// 无返回值
func greeting(name : String){
    print("hello \(name)")
}
greeting(name : "dx")

// 多返回值 - 元组
func minMax(arr:[Int]) -> (min: Int, max: Int){
    let min = arr.min() ?? 0
    let max = arr.max() ?? 0
    return (min, max)
}
let arr = [1, 2, 3, 4]
let result = minMax(arr:arr)
print("minValue = \(result.min)), maxValue = \(result.max)")

// 可选元组
func minMaxOptional(arr:[Int]) -> (min: Int, max: Int)?{
    if arr.isEmpty{
        return nil
    }
    let min = arr.min() ?? 0
    let max = arr.max() ?? 0
    return (min, max)
}
// 可选绑定解包
if let result = minMaxOptional(arr: []){
    print("minValue = \(result.min)), maxValue = \(result.max)")
}

// 参数标签 及 省略标签   -- 调用时更加明确
func dealMsg(_ msg : String, with type : Int) -> Bool{
    return true
}
dealMsg("msg", with: 0)

// 参数默认值  有默认值的调用时可以不传 -- 规范 有默认值的放后面
func defaultValueFunc(_ msg : String, with type : Int = 0){
    print("type 默认值为 0")
}
defaultValueFunc("不使用默认值", with: 1)
defaultValueFunc("使用默认值")

// 可以多个参数设置默认值 省略标签时注意 （with 省略 报错）
func addNum(_ a : Int = 1, with b : Int, _ c : Int = 3) -> Int{
    a + b + c
}
let sum = addNum(with: 2)
let sum1 = addNum(1, with: 2)
let sum2 = addNum(1, with: 2, 3)

// 可变参数
func addNum(for numbers : Int...) -> Int{
    // 可变参数 在函数内部  被当做数组
    var sum = 0
    for num in numbers{
        sum += num
    }
    return sum
}
let sum3 = addNum(for: 1, 2, 3, 4)

// 可以有多个可变参数  可变参数后的第一个参数 不能省略标签  默认就是参数名
func calculate(_ num1 : Int..., num2: Int..., with opr: String) -> Int{
    var sum1 = 0
    for num in num1{
        sum1 += num
    }
    
    var sum2 = 0
    for num in num2{
        sum2 += num
    }
    
    if opr == "+"{
        return sum1 + sum2
    }
    else if opr == "-"{
        return sum1 - sum2
    }
    else {
        return 0
    }
}
// 默认标签就是参数名
let sum4 = calculate(1,2,3, num2: 2,3,4, with: "-")

// 输入输出参数
// 函数内部修改外部变量的值  ： 必须是var  不能是可变参数 不能有默认值
func swap(_ a: inout Int, with b: inout Int){
    let temp = a
    a = b
    b = temp
}
var a = 10, b = 20
swap(&a, with: &b)
print("a=\(a), b=\(b)")

// 函数类型
var fn : (inout Int, String...)->Void
func temp1(num: inout Int, str: String...){
    print("11")
}
fn = temp1
fn(&a, "11","22")

var fn1 : (Int, String?)->[Int]
func temp2(num: Int, str: String?)->[Int]{
    return [1, 2]
}
fn1 = temp2
let arrBack = fn1(1, nil)

func fumcParam(fn: (Int, Int)->Int, num: Int){
    // 参数类型为函数类型
}

func returnFunc(isAdd: Bool) -> (Int, Int)->Int{
    // 返回值为函数类型
    
    //内嵌函数
    func add(num1: Int, num2: Int) -> Int{
        return num1 + num2
    }
    return add
}
