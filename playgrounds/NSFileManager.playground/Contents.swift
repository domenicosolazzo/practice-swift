//: Playground - noun: a place where people can play

import UIKit

// NSBundle
var bundle = NSBundle.mainBundle()
var resourcePath = bundle.resourcePath
var fm = NSFileManager.defaultManager()


// NSFileManager
var files = try fm.contentsOfDirectoryAtPath(resourcePath!)


