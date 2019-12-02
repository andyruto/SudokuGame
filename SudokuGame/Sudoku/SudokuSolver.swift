//
//  SudokuSolver.swift
//  SudokuGame
//
//  Created by Andreas Gantner on 01.12.19.
//  Copyright © 2019 GantnerProjects. All rights reserved.
//

import Foundation

public class SudokuSolver {
    private static var iterations: Int = 9;
    private static var field: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9);
    private static var possibilities = Array(repeating: Array(repeating: Array(repeating: 0, count: 9), count: 9), count: 9);
    public static var solutionBoard: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9);
    
    public static func checkIfSolvable(sudokuBoard: [[Int]]) -> Bool {
        field = sudokuBoard;
        
        for _ in 0...iterations {
            restrictPossibilities();
        }
        
        for _ in 0...iterations {
            searchInPossibilities();
        }
        
        solutionBoard = field;
        return true;
    }
    
    private static func restrictPossibilities() {
        for k: Int in 0...8 {
            for l: Int in 0...8 {
                if (field[k][l] == 0) {
                    restrictPossibilities(i: k,j: l);
                }
            }
        }
    }
    
    private static func restrictPossibilities(i: Int, j: Int) {
        if (isDetermined(i: i, j: j)) {
            return;
        }
        
        let comp: [[Int]] = getCompetitors(i: i,j: j);
        
        for k: Int in 0...8 {
            for l: Int in 0...8 {
                if (comp[k][l] == 0) {
                    continue;
                }
                
                if (isDetermined(i: k, j: l)) {
                    possibilities[i][j][field[k][l]-1] = 0;
                }
            }
        }
        
        if (isDetermined(i: i, j: j)) {
            field[i][j] = getFieldFromPossibility(i: i, j: j);
        }
    }
    
    private static func searchInPossibilities() {
        for i:Int in 0...8 {
            for j:Int in 0...8 {
                if (!isDetermined(i: i, j: j)) {
                    searchInPossibilities(i: i, j: j);
                }
            }
        }
    }

    private static func searchInPossibilities(i: Int, j: Int) {
        var count: Int = 0;
        // horizontal:
        for k: Int in 0...8 {  // k+1 = possible value (possibilities) at (i,j)
            if (possibilities[i][j][k] == 1) {
                count = 0;
                
                for l: Int in 0...8 {
                    if (l != j) {
                        if (possibilities[i][l][k] == 1) {
                            count+=1;
                        }
                    }
                }
                
                if (count == 0) {
                    field[i][j] = k+1;
                    
                    for m: Int in 0...8 {
                        if (m == k) {
                            possibilities[i][j][m] = 1;
                        }
                        else {
                            possibilities[i][j][m] = 0;
                        }
                    }
                    
                    restrictPossibilities();
                    return;
                }
            }
        }
        // vertical:
        for k: Int in 0...8 {  // k+1 = possible value (possibilities) at (i,j)
            if (possibilities[i][j][k] == 1) {
                count = 0;
                
                for l: Int in 0...8 {
                    if (l != i) {
                        if (possibilities[l][j][k] == 1) {
                            count+=1;
                        }
                    }
                }
                
                if (count == 0) {
                    field[i][j] = k+1;
                    
                    for m: Int in 0...8 {
                        if (m == k) {
                            possibilities[i][j][m] = 1;
                        }
                        else {
                            possibilities[i][j][m] = 0;
                        }
                    }
                    
                    restrictPossibilities();
                    return;
                }
            }
        }
        // square:
        let square: [[Int]] = getFieldsInSquare(i: i, j: j);
        for k: Int in 0...8 {  // k+1 = possible value (possibilities) bei (i,j)
            if (possibilities[i][j][k] == 1) {
                count = 0;
                
                for m: Int in 0...8 {
                    for n: Int in 0...8 {
                        if (square[m][n] != 0) {
                            if (possibilities[m][n][k] == 1) {
                                count+=1;
                            }
                        }
                    }
                }
                
                if (count == 0) {
                    field[i][j] = k+1;
                    
                    for p: Int in 0...8 {
                        if (p == k) {
                            possibilities[i][j][p] = 1;
                        }
                        else {
                            possibilities[i][j][p] = 0;
                        }
                    }
                    
                    restrictPossibilities();
                    return;
                }
            }
        }
    }
    
    private static func getCompetitors(i: Int, j: Int) -> [[Int]] {
        // returns 1, if (k,l) belongs to horizontal, vertical or
        // square group of (i,j)
        var result: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9);
        // horizontal:
        for k: Int in 0...8 {
            result[i][k] = 1;
        }
        // vertical:
        for l: Int in 0...8 {
            result[l][j] = 1;
        }
        // square:
        if (0 <= i && i < 3) {
            if (0 <= j && j < 3) {
                for k: Int in 0...2 {
                    for l: Int in 0...2 {
                        result[k][l] = 1;
                    }
                }
            }
            if (3 <= j && j < 6){
                for k: Int in 0...2 {
                    for l: Int in 3...5 {
                        result[k][l] = 1;
                    }
                }
            }
            if (6 <= j && j < 9) {
                for k: Int in 0...2 {
                    for l: Int in 6...8 {
                        result[k][l] = 1;
                    }
                }
            }
        }
        if (3 <= i && i < 6) {
            if (0 <= j && j < 3) {
                for k: Int in 3...5 {
                    for l: Int in 0...2 {
                        result[k][l] = 1;
                    }
                }
            }
            if (3 <= j && j < 6) {
                for k: Int in 3...5 {
                    for l: Int in 3...5 {
                        result[k][l] = 1;
                    }
                }
            }
            if (6 <= j && j < 9) {
                for k: Int in 3...5 {
                    for l: Int in 6...8 {
                        result[k][l] = 1;
                    }
                }
            }
        }
        if (6 <= i && i < 9) {
            if (0 <= j && j < 3) {
                for k: Int in 6...8 {
                    for l: Int in 0...2 {
                        result[k][l] = 1;
                    }
                }
            }
            if (3 <= j && j < 6) {
                for k: Int in 6...8 {
                    for l: Int in 3...5 {
                        result[k][l] = 1;
                    }
                }
            }
            if (6 <= j && j < 9) {
                for k: Int in 6...8 {
                    for l: Int in 6...8 {
                        result[k][l] = 1;
                    }
                }
            }
        }
        
        result[i][j] = 0;  // The field itself is not a rival
        return result;
    }
    
    private static func isDetermined(i: Int, j: Int) -> Bool {
        var count: Int = 0;
        
        for k: Int in 0...8 {
            if (possibilities[i][j][k] == 1) {
                count+=1;
            }
        }
        
        if (count == 1) {
            return true;
        }
        
        return false;
    }
    
    private static func getFieldFromPossibility(i: Int, j: Int) -> Int {
        var result: Int = 0;
        
        for k: Int in 0...8 {
            if (possibilities[i][j][k] == 1) {
                result = k + 1;
            }
        }
        
        return result;
    }
    
    private static func getFieldsInSquare(i: Int, j: Int) -> [[Int]] {
        var result: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9);
        
        if (0 <= i && i < 3) {
            if (0 <= j && j < 3) {
                for k: Int in 0...2 {
                    for l: Int in 0...2 {
                        result[k][l] = 1;
                    }
                }
            }
            if (3 <= j && j < 6) {
                for k: Int in 0...2 {
                    for l: Int in 3...5 {
                        result[k][l] = 1;
                    }
                }
            }
            if (6 <= j && j < 9) {
                for k: Int in 0...2 {
                    for l: Int in 6...8 {
                        result[k][l] = 1;
                    }
                }
            }
        }
        if (3 <= i && i < 6) {
            if (0 <= j && j < 3) {
                for k: Int in 3...5 {
                    for l: Int in 0...2 {
                        result[k][l] = 1;
                    }
                }
            }
            if (3 <= j && j < 6) {
                for k: Int in 3...5 {
                    for l: Int in 3...5 {
                        result[k][l] = 1;
                    }
                }
            }
            if (6 <= j && j < 9) {
                for k: Int in 3...5 {
                    for l: Int in 6...8 {
                        result[k][l] = 1;
                    }
                }
            }
        }
        if (6 <= i && i < 9) {
            if (0 <= j && j < 3) {
                for k: Int in 6...8 {
                    for l: Int in 0...2 {
                        result[k][l] = 1;
                    }
                }
            }
            if (3 <= j && j < 6) {
                for k: Int in 6...8 {
                    for l: Int in 3...5 {
                        result[k][l] = 1;
                    }
                }
            }
            if (6 <= j && j < 9) {
                for k: Int in 6...8 {
                    for l: Int in 6...8 {
                        result[k][l] = 1;
                    }
                }
            }
        }
        
        result[i][j] = 0;  // The field itself isn't a rival
        return result;
    }

}
