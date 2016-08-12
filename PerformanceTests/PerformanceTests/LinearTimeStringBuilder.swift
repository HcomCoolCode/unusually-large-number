//
//  LinearTimeStringBuilder.swift
//  PerformanceTests
//
//  Created by Antonio Tanzola on 11/08/2016.
//  Copyright © 2016 Antonio Tanzola. All rights reserved.
//

import Foundation

/*
 'linearTimeStringBuilder' has an asymptotic tight bound Θ(n + d + m) where
    - 'd' is the number of symbols used in decimal notation (10)
    - 'm' is the number of digits of the largest number in the array (e.g. if 9563 is the largest number then 'm' = 4)
 
 For 'n>>d' and 'n>>m', 'd' and 'm' become constant factors and
 'linearTimeStringBuilder' runs in linear time - Θ(n)
 */
func linearTimeStringBuilder(withIntegers integers:[Int]) -> String
{
    return radixSort(withIntegers: integers).reversed().map{String($0)}.joined(separator: "")
}


//MARK: Private

//Θ(1)
private func numberOfDigits(inInteger integer: Int) -> Int
{
    return Int(floor(log10(Double(integer)) + 1))
}

//Θ(n)
private func radixSort(withIntegers integers:[Int]) -> [Int]
{
    var sortedIntegers = integers
    
    //Find the max number of digits in the provided numbers - Θ(n)
    let maxNumberOfDigits = integers.reduce(0){return max($0, numberOfDigits(inInteger: $1))}
    
    //Apply countingSort per each digit - Θ(n)
    for digitIndex in stride(from: (maxNumberOfDigits * 2 - 1), through: 0, by: -1) {
        sortedIntegers = countingSort(sortedIntegers, digitIndex: digitIndex)
    }
    
    return sortedIntegers
}

//Θ(n)
private func countingSort(_ numbers:[Int], digitIndex: Int) -> [Int]
{
    //Create empty work array for ten digits - Θ(1)
    var workArray = [Int](repeating: 0, count: 10)
    
    //Create empty array to store relavant digit for each number - Θ(1)
    var digits = [Int]()
    
    //Update workArray with occurrances of each digit - Θ(n)
    for number in numbers {
        //Calculate digit for digitIndex
        let numOfDigits = numberOfDigits(inInteger: number)
        let normalizedDigitIndex = numOfDigits - (digitIndex % numOfDigits) - 1
        let digit = (number/Int(pow(10, Double(normalizedDigitIndex)))) % 10
        
        //Store digit to avoid recalculation during second step of counting sort
        digits.append(digit)
        
        //Increase relevant workArray element
        workArray[digit] += 1
    }
    
    //Create a cumulative array starting from workArray - Θ(1)
    var cumulativeWorkArray = [Int](repeating: 0, count: 10)
    for i in 0...8 {
        cumulativeWorkArray[i+1] = cumulativeWorkArray[i] + workArray[i]
    }
    
    //Use the cumulative array to sort the number linearly - Θ(n)
    var sortedNumbers = [Int](repeating: 0, count: numbers.count)
    for i in 0..<numbers.count {
        sortedNumbers[cumulativeWorkArray[digits[i]]] = numbers[i]
        cumulativeWorkArray[digits[i]] += 1
    }
    
    return sortedNumbers
}
