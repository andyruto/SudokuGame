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
    private var sudokuBoard: [[Int]];
    
    public init (template: [[Int]]) {
        sudokuBoard = template;
        initGameBoard();
    }
    
    private func initGameBoard() {
        
    }
}
