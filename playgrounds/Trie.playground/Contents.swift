// Trie Data Structure
// Source:
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
}