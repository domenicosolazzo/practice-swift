// Dictionary
import Cocoa

var dict: Dictionary<String, String> = Dictionary<String, String>()

/*
====== Initialization ======
*/
dict = ["First":"1", "Second":"2"]

/*
====== Counting ======
*/
var count = dict.count

/*
====== Updating an element ======
*/
dict["First"] = "First"
// Alternative syntax
dict.updateValue("Updated", forKey: "First")

/*
====== Remove an element ======
*/
dict["First"] = nil
// Alternative syntax
dict.removeValueForKey("Second")

/*
====== Iterating over a dictionary ======
*/
var cities = ["France":"Paris", "Italy":"Rome", "German":"Berlin"]
println("Dictionary")
for (country, capital) in cities{
    var tempCountry = country
    var tempCapital = capital
    println("\(country) - \(capital)")
}

// Iterating over the dictionary keys
println("Dictionary keys")
for country in cities.keys{
    var tempCountry = country
    println(tempCountry)
}

// Iterating over the dictionary values
println("Dictionary values")
for capital in cities.values{
    var tempCapital = capital
    println(tempCapital)
}