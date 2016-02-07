//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

print(str)

var date = NSDate()

print(date)

"abc/def".componentsSeparatedByString("/")

__FILE__

__FILE__.componentsSeparatedByString("/")

let docsPath = NSSearchPathForDirectoriesInDomains(
    NSSearchPathDirectory.DocumentDirectory,
    NSSearchPathDomainMask.UserDomainMask,
    true)[0]

print(docsPath)

let tokens = docsPath.componentsSeparatedByString("/")

tokens.count

tokens[9]

