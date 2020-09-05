import GameplayKit

struct Roll {
  let times: Int
  let sides: Int
}

// MARK: - Operand2, Equatable

extension Roll: Operand2, Equatable {
  // MARK: - Tokenable

  var description: String {
    return "\(self.times)d\(self.sides)"
  }

  // MARK: - Initialization

  private static let regex = NSRegularExpression(#"\A(-?\d+)d(-?\d+)\Z"#)

  init?(rawLexeme: String) {
    guard let result = Self.regex.firstMatch(in: rawLexeme) else {
      return nil
    }

    guard let rawTimes = result.substring(at: 1, in: rawLexeme) else {
      return nil
    }

    guard let times = Int(rawTimes) else {
      return nil
    }

    self.times = times

    guard let rawSides = result.substring(at: 2, in: rawLexeme) else {
      return nil
    }

    guard let sides = Int(rawSides) else {
      return nil
    }

    self.sides = sides
  }

  // MARK: - Inclusion

  func combined(_ other: Constant) throws -> Operand2 {
    let lexemeOther = String(describing: other)

    guard let sidesResult = Int(String(self.sides) + lexemeOther) else {
      throw ExpressionError.invalidCombinationOperands(String(describing: self), lexemeOther)
    }

    return Roll(times: self.times, sides: sidesResult)
  }

  func combined(_ other: Roll) throws -> Operand2 {
    if self.sides != other.sides {
      throw ExpressionError.invalidCombinationOperands(
        String(describing: self),
        String(describing: other)
      )
    }

    let (timesResult, didOverflow) = self.times.addingReportingOverflow(other.times)

    if didOverflow {
      throw ExpressionError.invalidCombinationOperands(
        String(describing: self),
        String(describing: other)
      )
    }

    return Roll(times: timesResult, sides: self.sides)
  }

  func combined(_ other: RollNegativeSides) throws -> Operand2 {
    throw ExpressionError.invalidCombinationOperands(
      String(describing: self),
      String(describing: other)
    )
  }

  func combined(_ other: RollPositiveSides) throws -> Operand2 {
    throw ExpressionError.invalidCombinationOperands(
      String(describing: self),
      String(describing: other)
    )
  }

  // MARK: - Exclusion

  func dropped() -> Tokenable? {
    let quotient = self.sides / 10

    if quotient != 0 {
      return Roll(times: self.times, sides: quotient)
    }

    let remainder = self.sides % 10

    if remainder < 0 {
      return RollNegativeSides(times: self.times)
    }

    return RollPositiveSides(times: self.times)
  }

  // MARK: - Evaluation

  func value() throws -> Int {
    if self.times == 0 || self.sides == 0 {
      return 0
    }

    // Because abs(Int.min) > Int.max
    if self.times == Int.min || self.sides == Int.min {
      throw ExpressionError.operationOverflow
    }

    var result = 0

    // TODO: Allow users to cancel long-running loops (i.e. large times)
    // Idea 1:
    //  - A concurrent, userInitiated dispatch queue
    //  - A concurrentPerform(iterations:) block within queue.sync(execute:)
    //  - A semaphore to protect the shared state
    // Compile Error:
    //  - queue.sync(execute:) can't cancel blocks
    //  - concurrentPerform(iterations:) doesn't accept an error throwing block
    //
    // Idea 2:
    //  - A serial, userInitiated dispatch queue
    //  - A single, cancelable work item block passed to queue.sync(execute:)
    //  - A single for...in loop within the work item's block
    // Compile Error:
    //  - DispatchWorkItem(block:) doesn't accept an error throwing block
    //
    // Idea 3:
    //  - A serial, userInitiated dispatch queue
    //  - A single for...in loop within try queue.sync(execute:)
    // Runtime Error:
    //  - queue.sync(execute:) can't cancel blocks
    //
    // Idea 4:
    //  - Async execution of expression.interpret(completion: (result: Int?, error: Error?) -> Void) -> DispatchWorkItem
    //  - Inside expression.interpret, create a serial, userInitiated dispatch queue
    //  - A single, cancelable work item block passed to queue.async(execute:)
    //  - Return a reference to the DispatchWorkItem
    //  - The final result is passed to the completion handler as an argument
    //  - Any error is caught and passed to the completion handler as an argument
    //  - Perhaps periodically check if the work item isCanceled in this method and throw an error
    for _ in 1...abs(self.times) {
      // Each iteration instantiates a new object because each die is an independent source of
      // random numbers. That is, the sequence of numbers generated by one die has no effect on
      // the sequence generated by another.
      let randomDistribution = GKRandomDistribution(forDieWithSideCount: abs(self.sides))

      let nextInt = randomDistribution.nextInt()

      let (newResult, didOverflow) = result.addingReportingOverflow(nextInt)

      if didOverflow {
        throw ExpressionError.operationOverflow
      }

      result = newResult
    }

    if self.times < 0 && self.sides < 0 || self.times > 0 && self.sides > 0 {
      return result
    }

    // Because Int.min.negate() > Int.max
    if result == Int.min {
      throw ExpressionError.operationOverflow
    }

    result.negate()

    return result
  }

  // MARK: - Operation

  func negated() throws -> Operand2 {
    // Because -Int.min > Int.max
    if self.sides == Int.min {
      throw ExpressionError.operationOverflow
    }

    return Roll(times: self.times, sides: -self.sides)
  }
}
