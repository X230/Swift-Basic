//: [Previous](@previous)

import Foundation

class Node{
    var value : Int
    var next : Node? = nil
    
    init(value: Int){
        self.value = value
    }
}

var head = Node(value:1)
var n1 = Node(value:2)
var n2 = Node(value:3)
var n3 = Node(value:3)
var n4 = Node(value:4)
var n5 = Node(value:5)
var n6 = Node(value:5)

head.next = n1
n1.next = n2
n2.next = n3
n3.next = n4
n4.next = n5
n5.next = n6

//print(head.value)
//while let node = head.next{
//    print(node.value)
//    head = node
//}

var cur : Node?, next : Node?, pre : Node

cur = head
pre = cur!
if head.next != nil{
    next = head.next
}
var count = 0
while next?.next != nil{
    if cur?.value == next?.value{
        next = next?.next
        count = 1
    }
    else{
        if count == 1{
            pre.next = next
            count = 0
        }
        else{
            pre = cur!
        }
        
        cur = next
        next = next?.next
    }
}

if count == 1{
    pre.next = nil
}

print(head.value)
while let node = head.next{
    print(node.value)
    head = node
}
    
1 2 3 3 4 5 5



var arr = [3, 1, 2, 5, -1,  99, 22, 12, 33, 21]

for i in 1..<arr.count{
    var pre = i - 1
    for j in (0...pre).reversed(){
        if arr[pre+1] < arr[j]{
            let temp = arr[pre+1]
            arr[pre+1] = arr[j]
            arr[j] = temp
            pre -= 1
        }
    }
}
print(arr)

for i in 1..<arr.count{
    let curElement = arr[i]
    for j in 0...i-1{
        if curElement < arr[j]{
            arr.remove(at: i)
            arr.insert(curElement, at: j)
            break
        }
    }
}
print(arr)

for i in 0..<arr.count{
    var minIndex = i
    for j in i..<arr.count{
        minIndex = arr[minIndex] > arr[j] ? j : minIndex
    }
    let temp = arr[i]
    arr[i] = arr[minIndex]
    arr[minIndex] = temp
}
print(arr)
