//
//  NLogNTimeStringBuilder.swift
//  PerformanceTests
//
//  Created by Antonio Tanzola on 12/08/2016.
//  Copyright © 2016 Antonio Tanzola. All rights reserved.
//

import Foundation

func nLogNTimeStringBuilder(withIntegers integers:[Int]) -> String
{
    let sortedArray = integers.map{String($0)}.sorted{$1+$0<$0+$1}
    return sortedArray.joined(separator: "")
}
