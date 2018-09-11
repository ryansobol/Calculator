public struct Expression {
  let infixTokens: [Tokenable]

  public init(_ infixTokens: [String]) throws {
    self.infixTokens = try infixTokens.map { infixToken in
      if let parenthesis = Parenthesis(rawValue: infixToken) {
        return parenthesis
      }

      if let operation = Operator(rawValue: infixToken) {
        return operation
      }

      if let number = Int(infixToken) {
        return Operand.number(number)
      }

      throw ExpressionError.invalidToken(infixToken)
    }
  }

  init(_ infixTokens: [Tokenable]) {
    self.infixTokens = infixTokens
  }

// MARK: - CustomStringConvertible

extension Expression: CustomStringConvertible {
  public var description: String {
    let result = infixTokens.reduce("") { accumulation, infixToken in
      let description: String

      if let operatorToken = infixToken as? Operator {
        description = " \(String(describing: operatorToken)) "
      }
      else {
        description = String(describing: infixToken)
      }

      return accumulation + description
    }

    return result.trimmingCharacters(in: .whitespaces)
  }
}

// MARK: - Alteration

extension Expression {
  public func pushed(_ infixToken: String) throws -> Expression {
    if let parenthesis = Parenthesis(rawValue: infixToken) {
      let infixTokens = pushed(parenthesisToken: parenthesis)

      return Expression(infixTokens)
    }

    if let `operator` = Operator(rawValue: infixToken) {
      let infixTokens = pushed(operatorToken: `operator`)

      return Expression(infixTokens)
    }

    if let digit = Int(infixToken) {
      let infixTokens = try pushed(digit: digit)

      return Expression(infixTokens)
    }

    throw ExpressionError.invalidToken(infixToken)
  }

  func pushed(parenthesisToken: Parenthesis) -> [Tokenable] {
    var infixTokens = self.infixTokens

    if parenthesisToken == .close {
      infixTokens.append(parenthesisToken)

      return infixTokens
    }

    if let lastParenthesis = infixTokens.last as? Parenthesis, lastParenthesis == .close {
      infixTokens.append(Operator.multiplication)
    }
    else if infixTokens.last is Operand {
      infixTokens.append(Operator.multiplication)
    }

    infixTokens.append(parenthesisToken)

    return infixTokens
  }

  func pushed(operatorToken: Operator) -> [Tokenable] {
    var infixTokens = self.infixTokens

    if infixTokens.last is Operator {
      infixTokens.removeLast()
    }

    infixTokens.append(operatorToken)

    return infixTokens
  }

  func pushed(digit: Int) throws -> [Tokenable] {
    var infixTokens = self.infixTokens

    switch infixTokens.last {
    case nil:
      infixTokens.append(Operand.number(digit))

    case let lastParenthesis as Parenthesis:
      if lastParenthesis == .close {
        infixTokens.append(Operator.multiplication)
      }

      infixTokens.append(Operand.number(digit))

    case let lastOperator as Operator:
      let tokenCount = infixTokens.count

      if tokenCount == 1 && lastOperator == .addition {
        infixTokens.removeLast()
      }

      var digit = digit

      if tokenCount == 1 && lastOperator == .subtraction {
        infixTokens.removeLast()

        digit.negate()
      }

      infixTokens.append(Operand.number(digit))

    case let lastOperand as Operand:
      let nextOperand = try lastOperand.pushed(String(digit))

      infixTokens.removeLast()
      infixTokens.append(nextOperand)

    default:
      preconditionFailure()
    }

    return infixTokens
  }
}

// MARK: - Evaluation

// https://www.youtube.com/watch?v=vXPL6UavUeA
// https://www.youtube.com/watch?v=MeRb_1bddWg
extension Expression {
  public func evaluate() throws -> Int {
    var operands = [Operand]()

    let postfixTokens = try toPostfixTokens()

    for currentToken in postfixTokens {
      switch currentToken {
      case let currentOperand as Operand:
        operands.append(currentOperand)

      case let currentOperator as Operator:
        guard let operand2 = operands.popLast() else {
          throw ExpressionError.missingOperand
        }

        guard let operand1 = operands.popLast() else {
          throw ExpressionError.missingOperand
        }

        let newOperand = try currentOperator.evaluate(operand1, operand2)

        operands.append(newOperand)

      default:
        throw ExpressionError.internalError(#line, #function, #file)
      }
    }

    if operands.isEmpty {
      return 0
    }

    if operands.count > 1 {
      throw ExpressionError.missingOperator
    }

    return try operands[0].value()
  }

  func toPostfixTokens() throws -> [Tokenable] {
    var markables = [Markable]()
    var postfixTokens = [Tokenable]()

    for currentToken in infixTokens {
      switch currentToken {
      case is Operand:
        postfixTokens.append(currentToken)

      case let currentParenthesis as Parenthesis:
        switch currentParenthesis {
        case .open:
          markables.append(currentParenthesis)

        case .close:
          while true {
            guard let topMarkable = markables.popLast() else {
              throw ExpressionError.missingParenthesisOpen
            }

            if let topParenthesis = topMarkable as? Parenthesis, topParenthesis == Parenthesis.open {
              break
            }

            postfixTokens.append(topMarkable)
          }
        }

      case let currentOperator as Operator:
        while let topMarkable = markables.last {
          if let topParenthesis = topMarkable as? Parenthesis, topParenthesis == .open {
            break
          }

          guard let topOperator = topMarkable as? Operator else {
            throw ExpressionError.internalError(#line, #function, #file)
          }


          if currentOperator.hasPrecedence(topOperator) {
            break
          }

          postfixTokens.append(topOperator)
          markables.removeLast()
        }

        markables.append(currentOperator)

      default:
        throw ExpressionError.internalError(#line, #function, #file)
      }
    }

    if markables.isEmpty {
      return postfixTokens
    }

    while let topMarkable = markables.popLast() {
      if let topParenthesis = topMarkable as? Parenthesis, topParenthesis == .open {
        throw ExpressionError.missingParenthesisClose
      }

      guard let topOperator = topMarkable as? Operator else {
        throw ExpressionError.internalError(#line, #function, #file)
      }

      postfixTokens.append(topOperator)
    }

    return postfixTokens
  }
}
