//
//  main.swift
//  SudokuGame
//
//  Created by Andreas Gantner on 21.11.19.
//  Last edit by Andreas Gantner on 27.11.19
//  Copyright © 2019 GantnerProjects. All rights reserved.
//

import Foundation;

private func printTimeElapsedWhenRunningCode(title:String, operation:()->()) {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Time elapsed for \(title): \(timeElapsed) s.")
}

private func timeElapsedInSecondsWhenRunningCode(operation: ()->()) -> Double {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return Double(timeElapsed)
}

printTimeElapsedWhenRunningCode(title:"creating a Sudoku") {
    let game: SudokuGame = SudokuGame();
    let debugBoard: [[Int]] = game.getBoard();
    var output: [String] = Array(repeating: "", count: 17);
    var i: Int = 0;
    var boardLine: Int = 0;

    while (i < output.count) {
        for j in 0...8 {
            output[i].append(" \(debugBoard[boardLine][j]) #");
        }
        
        var counter: Int = 0;
        
        while (counter < output[0].count && i < 15) {
            output[i+1].append("#");
            counter+=1;
        }
        
        i+=2;
        boardLine+=1;
    }

    i = 0;

    while (i < output.count) {
        print(output[i]);
        i+=1;
    }
}
