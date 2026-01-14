import Foundation

struct TicTacToeModel {
    
    enum Player: String {
        case cross = "X"
        case nought = "O"
        
        var next: Player {
            self == .cross ? .nought : .cross
        }
    }
    
    private(set) var board: [Player?] = Array(repeating: nil, count: 9)
    private(set) var currentPlayer: Player = .cross
    
    private let winningCombinations: [[Int]] = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],  //rows
        [0, 3, 6], [1, 4, 7], [2, 5, 8], //columns
        [0, 4, 8], [2, 4, 6]            //diagonals
    ]
    
    mutating func reset(startingPlayer: Player) {
        board = Array(repeating: nil, count: 9)
        currentPlayer = startingPlayer
    }
    
    mutating func play(at index: Int) -> Bool {
        guard board[index] == nil else { return false }
        board[index] = currentPlayer
        currentPlayer = currentPlayer.next
        return true
    }
    
    func winner() -> Player? {
        for combination in winningCombinations {
            if let p = board[combination[0]],
                board[combination[1]] == p,
                board[combination[2]] == p {
                    return p
            }
        }
        return nil
            
    }
    
    func isDraw() -> Bool {
        winner() == nil && board.allSatisfy {
            $0 != nil
        }
    }
}

