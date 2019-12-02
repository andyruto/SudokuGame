//
//  SudokuGameBoard.swift
//  SudokuGame
//
//  Created by Andreas Gantner on 27.11.19
//  Last edit by Andreas Gantner on 27.11.19
//  Copyright © 2019 GantnerProjects. All rights reserved.
//

import Foundation

public class SudokuGameBoard {
    private let sudokuBoard: [[Int]];
    private var sudokuGameBoard: [[Int]];
    
    public init (template: [[Int]]) {
        sudokuBoard = template;
        sudokuGameBoard = template;
        initGameBoard();
    }
    
    private func initGameBoard() {
        let x_cord: Int = Int.random(in: 0...8);
        let y_cord: Int = Int.random(in: 0...8);
        
        sudokuGameBoard[y_cord][x_cord] = 0;
        
        if (SudokuSolver.checkIfSolvable(sudokuBoard: sudokuGameBoard) && SudokuSolver.solutionBoard == sudokuBoard) {
            print("Is solvable!!!");
        }
    }
    
    public func getGameBoard() -> [[Int]] {
        return sudokuGameBoard;
    }
}
