import Algorithms

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into individual lines.
  var lines: [String] {
    data.split(separator: "\n").map(String.init)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var idsSum = 0

    for line in lines {
      let game = game(from: line)
      if game.isPossible(maxRed: 12, maxGreen: 13, maxBlue: 14) {
        idsSum += game.id
      }
    }

    return idsSum
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part2() -> Any {
    var powersSum = 0

    for line in lines {
      let game = game(from: line)
      
      let minCounts = game.minCounts()
      let power = minCounts.0 * minCounts.1 * minCounts.2

      powersSum += power
    }

    return powersSum
  }

  func game(from line: String) -> Game {
    let gameSplit = line.split(separator: ": ", maxSplits: 1)
    let gameId = Int(gameSplit.first!.split(separator: " ").last!)!
    let subsetStrings = gameSplit.last!.split(separator: "; ").map(String.init)

    let subsets = subsets(from: subsetStrings)

    return Game(id: gameId, subsets: subsets)
  }

  enum Color: String {
    case red
    case green
    case blue
  }

  struct Game {
    var id: Int
    var subsets: [[Color: Int]]

    func isPossible(maxRed: Int, maxGreen: Int, maxBlue: Int) -> Bool {
      for subset in subsets {
        if subset[.red] ?? 0 > maxRed ||
            subset[.green] ?? 0 > maxGreen ||
            subset[.blue] ?? 0 > maxBlue {
          return false
        }
      }

      return true
    }

    func minCounts() -> (Int, Int, Int) {
      var minRed = 0
      var minGreen = 0
      var minBlue = 0

      for subset in subsets {
        minRed = max(minRed, subset[.red] ?? 0)
        minGreen = max(minGreen, subset[.green] ?? 0)
        minBlue = max(minBlue, subset[.blue] ?? 0)
      }

      return (minRed, minGreen, minBlue)
    }
  }


  func subsets(from: [String]) -> [[Color: Int]] {
    from.map { stringSubset in
      stringSubset
        .split(separator: ", ")
        .map(String.init)
        .reduce(into: [:]) { partialResult, string in
          let split = string.split(separator: " ").map(String.init)
          let count = Int(split.first!)
          let color = Color(rawValue: split.last!)!

          partialResult[color] = count
        }
    }
  }
}
