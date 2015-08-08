// Graphs
// Source: 

// Basic vertex data structure
public class Vertex {
    var key: String?
    
    // Adjacency lists
    var neighbors: Array<Edge>
    
    init(){
        self.neighbors = Array<Edge>()
    }
    
}

// Edge data structure
public class Edge {
    var neighbor: Vertex
    var weight: Int
    
    init() {
        weight = 0
        self.neighbor = Vertex()
    }
}



