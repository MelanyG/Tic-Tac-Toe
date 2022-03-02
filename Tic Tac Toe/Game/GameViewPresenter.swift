//
//  GameViewPresenter.swift
//  Tic Tac Toe
//
//  Created by Melany on 01.03.2022.
//

import Foundation

protocol GameViewPresentable {
    var controller: GameViewControllable? { get set }
    
    func itemSelected(tag: Int)
}

enum TicToePlayer: Int {
    case cross = 1
    case zero
}

class GameViewPresenter: GameViewPresentable {
    weak var controller: GameViewControllable?
    
    var gameIsActive = true

    var activePlayer: TicToePlayer = .cross
    
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    func itemSelected(tag: Int) {

        if gameState.indices.contains(tag - 1), gameState[tag - 1] == 0 && gameIsActive == true {
            gameState[tag - 1] = activePlayer.rawValue
            controller?.updateItem(tag: tag, model: SectionViewModel(activePlayer: activePlayer.rawValue, win: false))
        }
        
        for combination in winningCombinations {
            if gameState[combination[0]] != 0 &&
                gameState[combination[0]] == gameState[combination[1]] &&
                gameState[combination[1]] == gameState[combination[2]] {
                // We have winner so we update UI and finish game
                controller?.updateItem(tag: combination[0] + 1, model: SectionViewModel(activePlayer: activePlayer.rawValue, win: true))
                controller?.updateItem(tag: combination[1] + 1, model: SectionViewModel(activePlayer: activePlayer.rawValue, win: true))
                controller?.updateItem(tag: combination[2] + 1, model: SectionViewModel(activePlayer: activePlayer.rawValue, win: true))
                gameIsActive = false
                
                return
            }
        }
        // Change currentl player
        activePlayer = activePlayer == .cross ? .zero : .cross
        // Here we identify whether there are any other options to move on or finish game
        gameIsActive = gameState.filter { $0 == 0 }.count > 0
        
        guard gameIsActive else {
            return
        }
        
        switch activePlayer {
            case .zero:
                executeComputorPart()
            
            default: break
        }
    }
    
    func executeComputorPart() {
        // Here we immitate computer part
        controller?.blockUI()
        let step = getRandomStep()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.itemSelected(tag: step)
            self.controller?.unblockUI()
        }
    }


    func getRandomStep() -> Int {
        let indexes = gameState.indices.filter { gameState[$0] == 0 }
        let tag = Int.random(in: 0..<indexes.count)
        return indexes[tag] + 1
    }
}



