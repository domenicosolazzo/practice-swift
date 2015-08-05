// Binary Search Tree
// Source: http://goo.gl/ozM0Pv

import Foundation


// A simple array of unsorted integers
let numberList: Array<Int> = [8, 2, 10, 9, 11, 1, 7]

// Generic binary search tree
public class AVLTree<T: Comparable> {
    
    var key: T?
    var left: AVLTree?
    var right: AVLTree?
    
    init(){
    
    }
    
    // Add item based on its value
    func addNode(key: T){
        
        // Check for the head node
        if (self.key == nil) {
            self.key = key
            return
        }
        
        // Check the left side of the tree
        if (key < self.key) {
            
            if (self.left != nil) {
                left!.addNode(key)
            }else{
                
                // Create a new left node
                var leftChild: AVLTree = AVLTree()
                leftChild.key = key
                self.left = leftChild
            
            }
        }
        
        // Check the right side of the tree
        if (key > self.key){
            if (self.right != nil){
                right!.addNode(key)
            }else{
            
                // Create a new right node
                var rightChild: AVLTree = AVLTree()
                rightChild.key = key
                self.right = rightChild
            }
        }
    }
    
    // Print the BST
    public static func printBST(node:AVLTree<T>, level:Int){
        var l = level
        print("Level \(l)")
        if (node.key != nil){
           println("Key: \(node.key!) => Level: \(l)")
        }
        
        l++
        // Print left side
        if (node.left != nil){
            printBST(node.left!, level:l)
        }
        
        // Print right side
        if (node.right != nil){
            printBST(node.right!, level:l)
        }
        
    }
    
}

// Create a new BST instance
var root = AVLTree<Int>()

// Sort each item in the list
for number in numberList {
    root.addNode(number)
}

// Print the BST
AVLTree.printBST(root, level: 0)