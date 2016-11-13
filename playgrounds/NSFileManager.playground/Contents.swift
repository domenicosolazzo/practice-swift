//: Playground - noun: a place where people can play

import UIKit

// NSBundle
var bundle = Bundle.main
var resourcePath = bundle.resourcePath
var fm = FileManager.default


// NSFileManager

var files = try fm.contentsOfDirectory(atPath: resourcePath!)


