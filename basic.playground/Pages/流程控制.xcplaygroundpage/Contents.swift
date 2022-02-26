
import Foundation

// for in
var arr : [Int] = []

for i in stride(from: 0, to: 10, by: 2){
    arr.append(i) // 0 2 4 6 8  半开区间
}

arr.removeAll()

for i in stride(from: 0, through: 10, by: 2){
    arr.append(i) // 0 2 4 6 8 10 闭区间
}

// while

while !arr.isEmpty{
    let removed = arr.removeLast()
    print("removed : \(removed)")
}

var i = 0
repeat{
    i += 1
    print(i)
}while(i < 10)

// if
if i <= 10, arr.count < i{
    print("true")
}

if i == 10 && arr.count < i{
    print("true")
}

func text(){
    guard let num = Int("tt6") else{
        print("转换失败 条件不满足时进入")
        return
    }
    print("转换结果\(num)  num可以在guard后面访问")
}
text()

// 检查api可用性
if #available(iOS 10, *){
    print("")
}

// switch  复杂判断 模式匹配  不需要{} break

// 没有隐式贯穿  导致编译错误    fallthrough实现贯穿效果
let char = "a"
switch char{
case "a": fallthrough
case "A":
    print("match a")
case "z":
    print("match z")
default:
    print("no match")
}

// 匹配多个值
switch char {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}

// 区间匹配
let count = 0
var naturalCount = ""
switch count {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
default:
    naturalCount = "many"
}

// 元组匹配  值绑定  point(0, 0) 第一个命中的会执行 其他的被忽略
let somePoint = (1, 1)
switch somePoint {
case (0, 0): // 元组
    print("(0, 0) is at the origin")
case (let x, 0): // 值绑定
    print("(\(x), 0) is on the x-axis")
case (0, _): // 忽略值
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2): // 区间
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

// where添加额外过滤条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}


// 控制转移  continue  break  fallthrough  return  throw

// 给语句打标签
loopTag : while i > 0 {
    switch i{
    case 0..<5:
        print(i)
        break loopTag   // 不加标签 退出的是switch  加标签  退出的是循环（标记语句）
    case 5..<10:
        print(i)
        continue loopTag
    default:
        break
    }
}
