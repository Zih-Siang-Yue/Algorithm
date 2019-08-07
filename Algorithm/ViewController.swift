//
//  ViewController.swift
//  Algorithm
//
//  Created by Sean on 2018/11/5.
//  Copyright © 2018年 Sean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sortedAry:[Int] = [12, 24, 37, 54, 67, 87, 92]
    var unsortedAry:[Int] = [89, 32, 1, 56, 70, 98, 29]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        algorithm()
        sort()
        gcd(m1: 4, n1: 9)
        print("pow: \(pow(x: 7.89, n: 3))")
    }
    
    func algorithm() {
        let randomIndex = Int(arc4random_uniform(UInt32(sortedAry.count)))
        let find = sortedAry[randomIndex]
        let timeComplexity = getItemFromAry(index: 4)
        print("Time complexity in array reading: \(timeComplexity)")
        
        
        let optional1 = simpleSearch(find: find)
        if let timeComplexity1 = optional1 {
            print("Time complexity in simple search: \(timeComplexity1)")
        }
        else {
            print("The value can't be found by simple search")
        }
        
        let option2 = binarySearch(find: find)
        if let timeComplexity2 = option2 {
            print("Time complexity in binary search: \(timeComplexity2)")
        }
        else {
            print("The value can't be found by binary search")
        }
        
        print("=====================================================")
    }
    
    func sort() {
        let timeComplexity1 = selectionSort(ary: unsortedAry)
        print("Time complexity in selection sort method: \(timeComplexity1)")
        
        let timeComplexity2 = insertionSort(ary: unsortedAry)
        print("Time complexity in insertion sort method: \(timeComplexity2)")
        
        var ary = [8, 1, 92, 68, 13, 42, 56, 14, 33]
        mergeSort(ary: &ary)
        
        print("fibo: \(fibonacci(21))")
        print("optimization fibo: \(optimizeFibo(21))")
    }
    
    
    //陣列讀取
    func getItemFromAry(index: Int) -> Int {
        return 1
    }

    //簡易搜尋
    func simpleSearch(find: Int) -> Int? {
        for i in 0 ..< sortedAry.count {
            if sortedAry[i] == find {
                return i + 1
            }
        }
        return nil
    }
    
    //二分搜尋
    func binarySearch(find: Int) -> Int? {
        var low: Int = 0
        var high: Int = sortedAry.count - 1
        var times = 0
        
        while low <= high {
            let mid = (low + high) / 2
            times += 1
            if sortedAry[mid] > find {
                high = mid - 1
            }
            else if sortedAry[mid] < find {
                low = mid + 1
            }
            else if sortedAry[mid] == find {
                print("This item is what we find in binary search: \(sortedAry[mid])")
                return times
            }
        }
        return nil
    }
    
    //選擇排序法
    func selectionSort(ary: [Int]) -> Int {
        var unsorted = ary
        var times: Int = 0
        var minIndex: Int = 0
        for i in 0 ..< unsorted.count {
            minIndex = i
            for j in i+1 ..< unsorted.count {
                times += 1
                if unsorted[minIndex] > unsorted[j] {
                    minIndex = j
                }
            }
            
            (unsorted[i], unsorted[minIndex]) = (unsorted[minIndex], unsorted[i])
        }
        
        print("sorted ary by selection sort:\(unsorted)")
        return times
    }
    
    //插入排序法
    func insertionSort(ary: [Int]) -> Int {
        var unsorted = ary
        var times: Int = 0
        for i in 0 ..< unsorted.count {
            var position = i
            while position > 0 && unsorted[position] < unsorted[position - 1] {
                (unsorted[position], unsorted[position - 1]) = (unsorted[position - 1], unsorted[position])
                position -= 1
                times += 1
            }
        }
        
        print("sorted ary by insertion sort:\(unsorted)")
        return times
    }

    //合併排序法
    func mergeSort(ary: inout [Int]) {
        //0. 注意要 inout 直接改變
        //1. 判斷ary裡的item是否大於一個? 若大於1個 先做分割
        //2. 分割：數量/2 分為左邊和右邊
        //3. 合併：準備三個Index 變數, left, right, merge
        //4. while判斷 三種狀況, 並將最小的塞入原本傳入的(inout)ary 記得index要 += 1
        if ary.count > 1 {
            let mid = ary.count / 2
            var leftAry = Array(ary[..<mid])
            var rightAry = Array(ary[mid...])
            mergeSort(ary: &leftAry)
            mergeSort(ary: &rightAry)
            
            var leftIndex = 0
            var rightIndex = 0
            var mergeIndex = 0
            
            while leftIndex < leftAry.count && rightIndex < rightAry.count {
                if leftAry[leftIndex] < rightAry[rightIndex] {
                    ary[mergeIndex] = leftAry[leftIndex]
                    leftIndex += 1
                }
                else {
                    ary[mergeIndex] = rightAry[rightIndex]
                    rightIndex += 1
                }
                mergeIndex += 1
            }
            
            while leftIndex < leftAry.count {
                ary[mergeIndex] = leftAry[leftIndex]
                leftIndex += 1
                mergeIndex += 1
            }
            
            while rightIndex < rightAry.count {
                ary[mergeIndex] = rightAry[rightIndex]
                rightIndex += 1
                mergeIndex += 1
            }
            
            print("sorted ary: \(ary)")
        }
    }
    
    //快速排序法
//    func quickSort(ary: [Int]) -> Int {
//
//    }
    
    //Fibonacci 費波那契數列
    func fibonacci(_ n: Int) -> Int {
        if n == 0 {
            return 0
        }
        else if n == 1 {
            return 1
        }
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
    
    //Fibonacci 優化解法
    func optimizeFibo(_ n: Int) -> Int {
        var dic = [0:0, 1:1]
        for _ in 2...n {
            let sum = dic[0]! + dic[1]!
            dic[0] = dic[1]
            dic[1] = sum
        }
        return dic[1]!
    }
    
    //MARK: O(log n) 時間複雜度的演算
    //歐西里斯算法, 取最大公因數
    func gcd(m1: Int, n1: Int) {
        var m = m1
        var n = n1
        var rem:Int = 0
        
        while (n > 0) {
            rem = m % n
            print("rem: \(rem)")
            m = n
            n = rem
        }
        print("m: \(m)")
    }
    
    //冪運算
    func pow(x: Double, n: Int) -> Double {
        if n == 0 {
            return 1
        }
        else if n == 1 {
            return x
        }
        
        if isEven(n: n) {
            return pow(x: x*x, n: n / 2)
        }
        else {
            return pow(x: x*x, n: n / 2) * x
        }
    }

    func isEven(n: Int) -> Bool {
        if n % 2 == 0 {
            return true
        }
        else {
            return false
        }
    }
}

