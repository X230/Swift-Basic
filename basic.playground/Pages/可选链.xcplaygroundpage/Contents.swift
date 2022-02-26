
import Foundation

/// 可选项  调用属性 方法 下标  如果为nil  调用失败返回nil   如果不为nil 返回可选类型结果
///
/// ？ 可选项如果为nil   可选链整体调用失败  返回nil
/// ！运行时错误
class Person1 {
    var residence: Residence1?
}
 
class Residence1 {
    var numberOfRooms = 1
}

let john = Person1()
// 强制展开 可选项为nil  运行时错误
//let roomCount = john.residence!.numberOfRooms

// 可选链方式  调用失败  返回nil
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
}
else {
    print("Unable to retrieve the number of rooms.")
}

// 可选链 访问属性
class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(String(describing: buildingNumber)) \(String(describing: street))"
        } else {
            return nil
        }
    }
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Person {
    var residence: Residence?
}

// 调用属性
let john1 = Person()
if let roomCount = john1.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// 给属性赋值   如果可选项时nil  则赋值会失败  = 右边不会执行
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john1.residence?.address = someAddress

// 赋值失败 返回nil  成功 void
let b: Void? = john1.residence?.address = someAddress

// 调用方法   如果方法没有返回值 则结果是 Void? 可选类型
if john1.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

// 使用下标
if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

john1.residence?[0] = Room(name: "Bathroom")

// 可选类型下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72   // 失败 testScores["Brian"]? 为 nil

// 多层可选链
if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

// 调用方法
if let beginsWithThe = john1.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
