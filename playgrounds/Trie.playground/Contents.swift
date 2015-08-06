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