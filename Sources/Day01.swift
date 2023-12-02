import Algorithms
import Foundation


public extension CharacterSet {

  func contains(_ character: Character) -> Bool {
    character.unicodeScalars.allSatisfy(contains)
  }

  func containsAll(in string: String) -> Bool {
    string.unicodeScalars.allSatisfy(contains)
  }
}

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
      data.split(separator: "\n").map(String.init)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    entities.reduce(into: 0) { sum, row in
      let digits = row.filter { char in
        CharacterSet.decimalDigits.contains(char)
      }
      .map(String.init)
      .reduce("", +)

      let firstAndLast = String(digits.first!) + String(digits.last!)

      sum += Int(firstAndLast) ?? 0
    }
  }

  func part2() -> Any {
    entities.reduce(into: 0) { sum, row in
      let replaced = row.replaceTextNumbers()
      let digits = replaced.filter { char in
        CharacterSet.decimalDigits.contains(char)
      }
      .map(String.init)
      .reduce("", +)

      let firstAndLast = String(digits.first!) + String(digits.last!)


      sum += Int(firstAndLast) ?? 0
    }
  }
}

extension String {
  func replaceTextNumbers() -> String {
    let numbersMap = ["one": "o1e", "two": "t2o", "three": "t3e", "four": "f4r", "five": "f5e", "six": "s6x", "seven": "s7n", "eight": "e8t", "nine": "n9e"]

    var modifiedString = self

    for (word, replacement) in numbersMap {
        modifiedString = modifiedString.replacingOccurrences(of: word, with: replacement)
    }

    return modifiedString
  }
}
