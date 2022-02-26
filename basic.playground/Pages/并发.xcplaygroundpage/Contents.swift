//
//import Foundation
//
///// 异步调用函数   可将异步代码挂起 并 恢复   在编译时进行检测
//
//// 闭包形式   获取所有照片名称 -- 请求第一张 -- 显示
//listPhotos(inGallery: "Summer Vacation") { photoNames in
//    let sortedNames = photoNames.sorted()
//    let name = sortedNames[1]
//    downloadPhoto(named: name) { photo in
//        show(photo)
//    }
//}
//
///// 定义异步函数   async    标记挂起位置   await
///// 能调用异步方法的位置：
/////     异步函数 方法 属性的代码段中
/////     标记了 @main 的结构体、类或者枚举的静态 main() 方法中
/////     在分离的子任务中
//func listPhotos(inGallery name: String) async -> [String] {
//    await Task.sleep(2)
//    let result = ["name"] // ... some asynchronous networking code ...
//    return result
//}
//
//// 异步函数形式
///**
//     await   挂起 等待函数返回  并 让线程去执行其他并发代码  --- 线程让步
//     异步函数返回之后  继续往下执行
// */
//let photoNames = await listPhotos(inGallery: "Summer Vacation")
//let sortedNames = photoNames.sorted()
//let name = sortedNames[1]
//let photo = await downloadPhoto(named: name)
//show(photo)
//
///// 异步序列 AsyncSequence
/////     同步序列：等待 直到所有元素都可用
/////     异步序列：await每一个元素
///// AsyncSequence：
/////     提供对其元素的异步、顺序、迭代访问。
/////     在每个元素上挂起，底层迭代器返回值 或者 抛出异常时 恢复
/////         迭代器返回 nil 时，表示迭代完成，与普通序列一样。
/////         错误发生时，也会返回 nil 表示结束。
//// 普通迭代原理  for in
//let arr = ["1","2","3"]
//for _ in arr{
//    // ....
//}
//// 编译器生成一个迭代器变量 然后在while循环中调用next方法
//var iterator = arr.makeIterator()
//while let _ = iterator.next(){
//    // ...
//}
//
//let url = URL(string: "")
//let lines = url?.lines
//// 异步序列迭代 for await in
//for await _ in lines?.dropFirst(){
//    // ...
//}
//// 编译器将普通迭代器改为异步迭代器
//var asyncIterator = lines.makeAsyncIterator()
//while let _ = await asyncIterator.next(){
//    // ...
//}
//
//// 异步序列可能抛出异常
//do{
//    for try await _ in lines?.dropFirst(){
//        //...
//    }
//}
//catch{
//    // ...
//}
//
//// 异步序列迭代 与其他任务并行
//async{
//    for await _ in lines{
//        // ...
//    }
//}
//
//// 显示终止迭代
//let asyncIterator = async{
//    for await item in lines{
//        // ...
//    }
//}
//asyncIterator.cancel()
//
//// 新增的AsyncSequence API
//for await line in FileHandle.standardInput.bytes.lines{
//
//}
//
//for await line in url?.lines{
//
//}
//
//let(bytes, resp) = await URLSession.shared.bytes(from: url, delegate: nil)
//for await byte in bytes{
//
//}
//
///// 自定义异步序列：
/////     不需要响应并且只是通知出现新值的场景
//
//
//// 并行调用异步方法
//
//// await 挂起 后面的不会执行 ---  一次只能一个任务
//let firstPhoto = await downloadPhoto(named: photoNames[0])
//let secondPhoto = await downloadPhoto(named: photoNames[1])
//let thirdPhoto = await downloadPhoto(named: photoNames[2])
//
//let photos = [firstPhoto, secondPhoto, thirdPhoto]
//
//// async 同时执行   获取结果的地方使用 await 挂起 等待执行完毕
//async let firstPhoto = downloadPhoto(named: photoNames[0])
//async let secondPhoto = downloadPhoto(named: photoNames[1])
//async let thirdPhoto = downloadPhoto(named: photoNames[2])
//
//let photos = await [firstPhoto, secondPhoto, thirdPhoto]
//
///// 任务 任务组  --- 结构化并发
/////     并发子任务全部完成时才会返回
//struct SlowDivideOperation {
//    
//    let name: String
//    let a: Double
//    let b: Double
//    let sleepDuration: UInt64
//    
//    func execute() async -> Double {
//        
//        // Sleep for x seconds
//        await Task.sleep(sleepDuration * 1_000_000_000)
//        
//        let value = a / b
//        return value
//    }
//}
//
//let operations = [
//    SlowDivideOperation(name: "operation-0", a: 5, b: 1, sleepDuration: 5),
//    SlowDivideOperation(name: "operation-1", a: 14, b: 7, sleepDuration: 1),
//    SlowDivideOperation(name: "operation-2", a: 8, b: 2, sleepDuration: 3),
//]
//
//Task {
//
//    print("Task start   : \(Date())")
//    
//    // 创建任务组 withTaskGroup  withThrowingTaskGroup
//    // 子任务返回类型   组返回类型
//    let allResults = await withTaskGroup(of: (String, Double).self,
//                                         returning: [String: Double].self,
//                                         body: { taskGroup in
//
//        taskGroup.async(priority: .high) {
//            ("11", 1)
//        }
//        
//        for operation in operations {
//            // 添加子任务
//            taskGroup.addTask {
//
//                // 执行操作
//                let value = await operation.execute()
//
//                // 返回子任务结果
//                return (operation.name, value)
//            }
//        }
//
//        // 收集所有子任务结果
//        var childTaskResults = [String: Double]()
//        for await result in taskGroup {
//            childTaskResults[result.0] = result.1
//        }
//
//        // 所有子任务完成  返回任务组结果
//        return childTaskResults
//    })
//
//    print("Task end     : \(Date())")
//    print("allResults   : \(allResults)")
//}
//
//// 非结构化并发
//let task = Task.init(priority: .high) {
//    // ...
//}
//task.cancel()
//
//Task.detached(priority: .high) {
//    // ...
//}
//
//// 行为体 actor
//// 保护并发应用中的可变状态 -- 为共享可变状态提供同步，并有独自的、与程序中剩余部分都分割的状态
//class RiskyCollector {
//    var deck: Set<String>
//
//    init(deck: Set<String>) {
//        self.deck = deck
//    }
//
//    func send(card selected: String, to person: RiskyCollector) -> Bool {
//        guard deck.contains(selected) else { return false }
//
//        deck.remove(selected)
//        person.transfer(card: selected)
//        return true
//    }
//
//    func transfer(card: String) {
//        deck.insert(card)
//    }
//}
//
//actor SafeCollector {
//    var deck: Set<String>
//
//    init(deck: Set<String>) {
//        self.deck = deck
//    }
//
//    func send(card selected: String, to person: SafeCollector) async -> Bool {
//        guard deck.contains(selected) else { return false }
//
//        deck.remove(selected)
//        await person.transfer(card: selected)
//        return true
//    }
//
//    func transfer(card: String) {
//        deck.insert(card)
//    }
//}
