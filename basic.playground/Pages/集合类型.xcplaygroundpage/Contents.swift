import Foundation

/**
    Array                  index   value         有序
    Set                     item                      无序  唯一
    Dictionary          key-value              无序  key唯一
 
 都要明确能存的值的类型  能存的 key  -- 集合中不会意外的插入错误的类型    取值时能取回确定的类型
 
 创建为常量 则集合的大小和内容不可变
 */

///- 创建数组
let emptyIntArr = [Int]()

var foodsArr : [String] = ["egg", "milk"]

// 容量 5 默认值 -1
var defaultValueArr = Array(repeating: -1, count: 5)

///- 访问
let count = foodsArr.count
let isEmpty = foodsArr.isEmpty
let firstFood = foodsArr[0]

///- 添加元素
foodsArr.append("apple")
foodsArr.append(contentsOf: ["banana", "suger"])

// 拼接数组
var newArr = defaultValueArr + [1, 2]

// 不同类型的 不能拼接
//newArr = newArr + foodsArr
// 常量数组不能添加
//emptyIntArr += [1]

// 插入
foodsArr.insert("cheese", at: 1)
foodsArr.insert(contentsOf: ["butter","peer"], at: 3);

///- 修改
newArr[0] = 10
newArr[2...4] = [2,3]   // 用 2 3 替换 -1 -1 -1
print(newArr)

newArr.replaceSubrange(0...1, with: [4,5,6])

/// -移除
foodsArr.remove(at: 0)
let beRemoved = foodsArr.removeLast()
newArr.removeSubrange(0..<1)
foodsArr.removeAll { item in
    item.hasPrefix("sug")
}

///- 遍历
for food in foodsArr{
    print(food)
}

for (index, food) in foodsArr.enumerated(){
    print("food:" + food + " index:\(index)")
}

for (index, char) in "swift".enumerated(){
    print("char : \(char) index : \(index)")
}

let filtArr = foodsArr.filter { value in
    return value.contains("ee")
}

/// ------------- Set  同一类型  无序  不重复  必须遵循 Hashable (基础类型都遵循) Hashable遵循Equatable协议-----------------------

//- 创建
var emptySet = Set<String>()

var nameSet : Set<String> = ["joe", "hack"]

//- 访问
let setCount = nameSet.count
let setIsEmpty = nameSet.isEmpty

let isContain = nameSet.contains("joe")
let isContain1 = nameSet.contains { name in
    name.hasPrefix("ha")
}

//- 添加
nameSet.insert("json")

//- 移除
let removed : String? = nameSet.remove("jow")

//- 遍历  无序
for name in nameSet{
    print(name)
}

for name in nameSet.sorted(){
    print(name)
}

//- 集合操作   交集 并集 差集 补集 对称差集
var num1Set : Set<Int> = [1, 2, 3]
var num2Set : Set<Int> = [1, 2, 3, 4, 5]
var num3Set : Set<Int> = [3, 4, 5]

let bothContain = num1Set.intersection(num3Set)   // 3     交集  都包含的
let union = num1Set.union(num3Set).sorted()       // 1...5 并集
let diff = num1Set.symmetricDifference(num3Set)   // 1254  对称差集 非共有部分
let chaji = num1Set.subtracting(num3Set)          // 1 2   差集 A中B没有的部分

//- 成员关系和相等性   包含（子集 超集） 相离
var num4Set : Set<Int> = [4, 5, 6]

let isEquals = num1Set == num4Set                         // 判断是否相等 元素完全相同
let isSubsets = num1Set.isSubset(of: num2Set)             // A 是否是 B 的子集
let isStrictSubs = num1Set.isStrictSubset(of: num2Set)    // A 是否是 B 的子集 并且 A != B
let isSuper = num2Set.isSuperset(of: num1Set)             // A 是否是 B 的超集  A包含B的所有
let isStrictSuper = num2Set.isStrictSuperset(of: num1Set) // A 是否是 B 的超集 并且 A != B
let isDisjoint = num1Set.isDisjoint(with: num4Set)        // A 与 B 相离  没有公共部分

// -------------- Dictionary(map) ----------------------
// key必须遵循 Hashable  key 唯一   无序

//- 创建
var empDict = [Int : String]()

var cityDict : [String: String] = ["cs" : "长沙", "xt" : "湘潭"]

//- 访问
let empDic = cityDict.isEmpty
let dicCount = cityDict.count

let contain = cityDict.contains { (key, value) in
    return key == "cs" && value == "长沙"
}

let arrK = cityDict.keys
let arrV = cityDict.values.sorted()

//- 添加 修改
cityDict["nx"] = "宁乡"
cityDict["nx"] = "南县"
cityDict["yy"] = nil     // 不报错  不会执行插入

let oldValue : String? = cityDict.updateValue("宁乡", forKey: "nx")
print(cityDict)

//- 移除
cityDict.removeValue(forKey: "nx")
cityDict["nx"] = nil

//- 遍历
for (key, value) in cityDict{
    print("key:\(key), value:\(value)")
}
