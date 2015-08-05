//: Playground - noun: a place where people can play

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
}