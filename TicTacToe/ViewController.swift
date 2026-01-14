import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var turnLabel: UILabel!
    @IBOutlet private var boardButtons: [UIButton]!
    
    private var game = TicTacToeModel()
    private var firstPlayer: TicTacToeModel.Player = .cross
    
    private var crossScore = 0
    private var noughtScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetGame()
    }
    
    @IBAction private func cellTapped(_ sender: UIButton) {
           let index = sender.tag

           guard game.play(at: index) else { return }

           render()

           if let winner = game.winner() {
               if winner == .cross { crossScore += 1 }
               else { noughtScore += 1 }
               showResult(title: "\(winner.rawValue) Wins!")
           } else if game.isDraw() {
               showResult(title: "Draw")
           }
       }

       private func render() {
           for (index, button) in boardButtons.enumerated() {
               button.setTitle(game.board[index]?.rawValue, for: .normal)
               button.isEnabled = (game.board[index] == nil)
           }

           turnLabel.text = "\(game.currentPlayer.rawValue)"
       }

       private func showResult(title: String) {
           let message = "Noughts: \(noughtScore)\nCrosses: \(crossScore)"

           let alert = UIAlertController(
               title: title,
               message: message,
               preferredStyle: .alert
           )

           alert.addAction(UIAlertAction(title: "Play Again", style: .default) { [weak self] _ in
               self?.switchFirstPlayerAndReset()
           })

           present(alert, animated: true)
       }

       private func resetGame() {
           game.reset(startingPlayer: firstPlayer)
           render()
       }

       private func switchFirstPlayerAndReset() {
           firstPlayer = firstPlayer.next
           resetGame()
       }
    
}
