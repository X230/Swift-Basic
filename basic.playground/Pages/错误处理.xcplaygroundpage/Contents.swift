//
//import Foundation
//
//// 枚举定义错误 -- 遵循Error协议 自定义运行时错误
//enum VendingMachineError: Error {
//    case invalidSelection
//    case insufficientFunds(coinsNeeded: Int)
//    case outOfStock
//}
//
//struct Item {
//    var price: Int
//    var count: Int
//}
//
//class VendingMachine {
//    var inventory = [
//        "Candy Bar": Item(price: 12, count: 7),
//        "Chips": Item(price: 10, count: 4),
//        "Pretzels": Item(price: 7, count: 11)
//    ]
//    var coinsDeposited = 0
//
//    // throw 函数可能抛出异常
//    func vend(itemNamed name: String) throws {
//
//        guard let item = inventory[name] else {
//            // throw 抛出异常
//            throw VendingMachineError.invalidSelection
//        }
//
//        guard item.count > 0 else {
//            throw VendingMachineError.outOfStock
//        }
//
//        guard item.price <= coinsDeposited else {
//            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
//        }
//
//        coinsDeposited -= item.price
//
//        var newItem = item
//        newItem.count -= 1
//        inventory[name] = newItem
//
//        print("Dispensing \(name)")
//    }
//}
//
//// 使用 do catch 处理异常
//do {
//    try expression
//    statements
//} catch pattern 1 {
//    statements
//} catch pattern 2 where condition {
//    statements
//} catch pattern 3, pattern 4 where condition {
//    statements
//} catch {
//    statements
//}
//
//let favoriteSnacks = [
//    "Alice": "Chips",
//    "Bob": "Licorice",
//    "Eve": "Pretzels",
//]
//
//// 自身没处理 继续向上抛出异常
//func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
//    let snackName = favoriteSnacks[person] ?? "Candy Bar"
//    // 向上传递错误
//    try vendingMachine.vend(itemNamed: snackName)
//}
//
//var vendingMachine = VendingMachine()
//vendingMachine.coinsDeposited = 8
//do {
//    // 捕获错误 传递到catch   没有异常 继续往下执行
//    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
//    print("Success! Yum.")
//    // 各种模式 匹配异常类型
//} catch VendingMachineError.invalidSelection {
//    print("Invalid Selection.")
//} catch VendingMachineError.outOfStock {
//    print("Out of Stock.")
//} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
//    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
//} catch {
//    // 把错误绑定到一个本地变量 error 上
//    print("Unexpected error: \(error).")
//}
//
//// catch ,分割 处理多个错误
//func eat(item: String) throws {
//    do {
//        try vendingMachine.vend(itemNamed: item)
//    } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
//        print("Invalid selection, out of stock, or not enough money.")
//    }
//}
//
//// catch如果没有处理所有错误 会继续向上层传递  传到顶层还没有处理  则运行时异常
//func nourish(with item: String) throws {
//    do {
//        try vendingMachine.vend(itemNamed: item)
//    } catch is VendingMachineError {
//        print("Couldn't buy that from the vending machine.")
//    }
//}
//
//do {
//    // 外层再继续捕获 处理
//    try nourish(with: "Beet-Flavored Chips")
//} catch {
//    print("Unexpected non-vending-machine-related error: \(error)")
//}
//
//// 不处理异常 try? try!
//
//// try? 错误转换为可选项  如果抛出异常 值为nil  否则 就是函数结果的可选项
//func someThrowingFunction() throws -> Int {
//    // ...
//}
//
//let x = try? someThrowingFunction()
//
//// 等效
//let y: Int?
//do {
//    y = try someThrowingFunction()
//} catch {
//    y = nil
//}
//
//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() {
//        // 没有抛出异常 解包 返回
//        return data
//    }
//    if let data = try? fetchDataFromServer() {
//        return data
//    }
//    return nil
//}
//
//// try! 取消错误传递    如果抛出错误 则运行时异常
//let photo = try! loadImage("./Resources/John Appleseed.jpg")
//
///// defer 指定清理操作
/////     在以任何方式(throw return break)离开当前代码块前执行必须要的清理工作
/////     延迟执行 当前作用域范围退出前执行defer语句
//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // Work with the file.
//        }
//        // close(file) is called here, at the end of the scope.
//    }
//}
//
//// assert断言 不满足条件时，直接终止  (测试)
//// 增加swift flag  -assert-config debug 强制开启断言
