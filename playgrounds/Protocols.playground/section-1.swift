// Playground: Protocols
/**
A protocol defines a blueprint of methods, properties, and other
requirements that suit a particular task or piece of functionality. The
protocol doesn’t actually provide an implementation for any of these
requirements—it only describes what an implementation will look like. The
protocol can then be adopted by a class, structure, or enumeration to
provide an actual implementation of those requirements. Any type that
satisfies the requirements of a protocol is said to conform to that
protocol.

syntax
protocol SomeProtocol{
    // protocol definition here
}
*/
import Cocoa

/*
=== Property Requirements ===
*/
protocol SomeProtocol{
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int{get}
}

protocol FullyNamed{
    var fullName: String {get}
}

struct Person: FullyNamed{
    var fullName: String
}
let john = Person(fullName: "Domenico")
println(john.fullName)

/*
=== Method Requirements ===
*/
protocol RandomNumberGenerator{
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator{
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double{
        lastRandom = ( (lastRandom * a + c) % m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
println("Here's a random number: \(generator.random())")
println("Here's a random number: \(generator.random())")

// Mutable func
protocol Togglable{
    mutating func toggle()
}

enum OnOffSwitch: Togglable{
    case Off, On
    mutating func toggle(){
        switch self{
            case Off:
              self = On
            case On:
              self = Off
        }
    }
}
var ligthSwitch = OnOffSwitch.Off
ligthSwitch.toggle()

/*
=== Protocols as Types ===
*/
class Dice{
    let sides:Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator){
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int{
        return Int(self.generator.random() * Double(self.sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator:LinearCongruentialGenerator())
for _ in 1...5{
    println("Random dice roll is \(d6.roll())")
}

/*
=== Delegation ===

Delegation is a design pattern that enables a class or structure to hand
off (or delegate) some of its responsibilities to an instance of another
type. This design pattern is implemented by defining a protocol that
encapsulates the delegated responsibilities, such that a conforming type
(known as a delegate) is guaranteed to provide the functionality that has
been delegated. Delegation can be used to respond to a particular action,
or to retrieve data from an external source without needing to know the
underlying type of that source.
*/
protocol DiceGame{
    var dice: Dice{get}
    func play()
}

protocol DiceGameDelegate{
    func gameDidStart(game:DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game:DiceGame)
}

class SnakesAndLadders: DiceGame{
    let finalSquare = 25
    let dice = Dice(sides:6, generator:LinearCongruentialGenerator())
    
    var square = 0
    var board: Int[]
    
    init(){
        board = Int[](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    
    func play(){
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare{
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate{
    var numberOfTurns = 0
    func gameDidStart(game:DiceGame){
        numberOfTurns = 0
        if game is SnakesAndLadders{
            println("Started a new game of Snakes and Ladders")
        }
        println("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int){
        +numberOfTurns
        println("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(game: DiceGame){
        println("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

/*
=== Protocol Composition ===
*/
protocol Named{
    var name:String {get}
}

protocol Aged{
    var age:Int {get}
}


struct MyPerson: Named, Aged{
    var name:String
    var age:Int
}


func wishHappyBirthday(celebrator: protocol<Named, Aged>){
    println("Happy birthday (\(celebrator.age)) \(celebrator.name)")
}

