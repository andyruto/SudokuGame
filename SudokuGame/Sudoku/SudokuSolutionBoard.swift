//
//  SudokuSolutionBoard.swift
//  SudokuGame
//
//  Created by Andreas Gantner on 22.11.19
//  Last edit by Andreas Gantner on 27.11.19
//  Copyright © 2019 GantnerProjects. All rights reserved.
//

import Foundation;

public class SudokuSolutionBoard {
    private var sudokuBoard: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9);
    
    public init() {
        initSudokuBoard();
    }
    
    private func initSudokuBoard() {
        var counter: Int = 0;
        
        while(counter < sudokuBoard.count) {
            sudokuBoard[counter] = getValidLine();
            
            if (isVerticallyValid() && isEverySquareValid()) {
                counter+=1;
            }
        }
    }
    
    private func getValidLine() -> [Int] {
        var tempLine: [Int] = Array(repeating: 0, count: 9);
        var i: Int = 0;
        
        
        while (i < 9) {
            let randomNumber: Int = Int.random(in: 1...9);
            var exists: Bool = false;
            
            for j in 0...8 {
                if (randomNumber == tempLine[j]){
                    exists = true;
                }
            }
            
            if (!exists) {
                tempLine[i] = randomNumber;
                i+=1;
            }
        }
        
        return tempLine;
    }
    
    private func isVerticallyValid() -> Bool {
        for i in 0...8 {
            for j in 0...8 {
                for z in 0...8 {
                    if (sudokuBoard[j][i] > 0) {
                        if (sudokuBoard[j][i] == sudokuBoard[z][i] && j != z) {
                            return false;
                        }
                    }
                }
            }
        }
        
        return true;
    }
    
    private func isHorizontallyValid() -> Bool {
        for i in 0...8 {
            for j in 0...8 {
                for z in 0...8 {
                    if (sudokuBoard[i][j] > 0) {
                        if (sudokuBoard[i][j] == sudokuBoard[i][z] && j != z) {
                            return false;
                        }
                    }
                }
            }
        }
        
        return true;
    }
    
    private func isEverySquareValid() -> Bool {
        for i in 0...2 {
            for j in 0...2 {
                var squareElements: [Int] = Array(repeating: 0, count: 9);
                var elementsCounter: Int = 0;
                
                while (elementsCounter < squareElements.count) {
                    squareElements[elementsCounter] = sudokuBoard[elementsCounter/3+i*3][elementsCounter%3+j*3];
                    
                    elementsCounter+=1;
                }
                
                for z in 0...8 {
                    for y in 0...8 {
                        if (squareElements[z] > 0) {
                            if (squareElements[z] == squareElements[y] && y != z) {
                                return false;
                            }
                        }
                    }
                }
            }
        }
        
        return true;
    }
    
    public func getBoard() -> [[Int]] {
        return sudokuBoard;
    }
}
