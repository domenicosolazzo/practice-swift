// Trie Data Structure
// Source: http://goo.gl/515yko

import Foundation

// Trie node data structure
public class TrieNode{
    
    var key: String!
    var children: Array<TrieNode>
    var isFinal: Bool
    var level: Int
    
    init(){
        self.children = Array<TrieNode>()
        self.isFinal = false
        self.level = 0
    }
}

// Trie implementation
public class Trie {
    private var root: TrieNode!
    
    init(){
        root = TrieNode()
    }
    
    // Build a recursive tree of dictionary content
    func addWord(keyword: String){
        
        if (keyword.length == 0){
            return;
        }
        
        var current: TrieNode = root
        var searchKey: String!
        
        while(keyword.length != current.level){
            var childToUse: TrieNode!
            var searchKey = keyword.substringToIndex(current.level + 1)
            
            for child in current.children {
                if (child.key == searchKey){
                    childToUse = child
                    break
                }
            }
            
            // Create a new node
            if (childToUse == nil){
                childToUse = TrieNode()
                childToUse.key = searchKey
                childToUse.level = current.level + 1
                current.children.append(childToUse)
            }
            
            current = childToUse
            
            // Add final end of word check
            if (keyword.length == current.level) {
                current.isFinal = true
                print("end of the word reached")
                return;
            }
        }
        
    }
    
    // Find all words based on a prefix
    func findWord(keyword: String) -> Array<String>! {
        
        if (keyword.length == 0){
            return nil
        }
        
        var current: TrieNode = root
        var searchKey: String!
        var wordList: Array<String>! = Array<String>()
        
        while(keyword.length != current.level){
            var childToUse: TrieNode!
            var searchKey = keyword.substringToIndex(current.level + 1)
            
            // Iterate through any children
            for child in current.children {
                if (child.key == searchKey){
                    childToUse = child
                    current = childToUse
                    break
                }
            }
            
            // Prefix not found
            if (childToUse == nil){
                return nil
            }
        }
        
        // Retrieve keyword and any descendants
        if ((current.key == keyword) && (current.isFinal)){
            wordList.append(current.key)
        }
        
        // Add children that are words
        for child in current.children {
            if (child.isFinal == true){
                wordList.append(child.key)
            }
        }
        
        return wordList
    }
}

// Extend the native String class
extension String{
    // compute the length of string
    var length: Int {
        return Array(self).count
    }
    
    // returns characters of a string up to a specific index
    func substringToIndex(to: Int) -> String{
        return self.substringToIndex(advance(self.startIndex, to))
    }

}