@testable import ChanceKit

typealias LexemeParenthesisFixture = (
  withoutLexemes: [String],
  withoutTokens: [Tokenable],
  lexeme: String,
  token: Parenthesis,
  withLexemes: [String],
  withTokens: [Tokenable],
  droppedLexemes: [String],
  droppedTokens: [Tokenable]
)

let lexemeParenthesisFixtures: [LexemeParenthesisFixture] = [
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["("],
    withTokens: [Parenthesis.open],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: [],
    withoutTokens: [],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: [")"],
    withTokens: [Parenthesis.close],
    droppedLexemes: [],
    droppedTokens: []
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["(", "("],
    withTokens: [Parenthesis.open, Parenthesis.open],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: ["("],
    withoutTokens: [Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["(", ")"],
    withTokens: [Parenthesis.open, Parenthesis.close],
    droppedLexemes: ["("],
    droppedTokens: [Parenthesis.open]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: [")", "×", "("],
    withTokens: [Parenthesis.close, Operator.multiplication, Parenthesis.open],
    droppedLexemes: [")", "×"],
    droppedTokens: [Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: [")"],
    withoutTokens: [Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: [")", ")"],
    withTokens: [Parenthesis.close, Parenthesis.close],
    droppedLexemes: [")"],
    droppedTokens: [Parenthesis.close]
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["+", "("],
    withTokens: [Operator.addition, Parenthesis.open],
    droppedLexemes: ["+"],
    droppedTokens: [Operator.addition]
  ),
  (
    withoutLexemes: ["+"],
    withoutTokens: [Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["+", ")"],
    withTokens: [Operator.addition, Parenthesis.close],
    droppedLexemes: ["+"],
    droppedTokens: [Operator.addition]
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["÷", "("],
    withTokens: [Operator.division, Parenthesis.open],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),
  (
    withoutLexemes: ["÷"],
    withoutTokens: [Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["÷", ")"],
    withTokens: [Operator.division, Parenthesis.close],
    droppedLexemes: ["÷"],
    droppedTokens: [Operator.division]
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["×", "("],
    withTokens: [Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),
  (
    withoutLexemes: ["×"],
    withoutTokens: [Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["×", ")"],
    withTokens: [Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["×"],
    droppedTokens: [Operator.multiplication]
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["-", "("],
    withTokens: [Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["-"],
    droppedTokens: [Operator.subtraction]
  ),
  (
    withoutLexemes: ["-"],
    withoutTokens: [Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["-", ")"],
    withTokens: [Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["-"],
    droppedTokens: [Operator.subtraction]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.constant(0)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["0", "×", "("],
    withTokens: [Operand.constant(0), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["0", "×"],
    droppedTokens: [Operand.constant(0), Operator.multiplication]
  ),
  (
    withoutLexemes: ["0"],
    withoutTokens: [Operand.constant(0)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["0", ")"],
    withTokens: [Operand.constant(0), Parenthesis.close],
    droppedLexemes: ["0"],
    droppedTokens: [Operand.constant(0)]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.constant(1)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "×", "("],
    withTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Operand.constant(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1"],
    withoutTokens: [Operand.constant(1)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", ")"],
    withTokens: [Operand.constant(1), Parenthesis.close],
    droppedLexemes: ["1"],
    droppedTokens: [Operand.constant(1)]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.constant(9)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["9", "×", "("],
    withTokens: [Operand.constant(9), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["9", "×"],
    droppedTokens: [Operand.constant(9), Operator.multiplication]
  ),
  (
    withoutLexemes: ["9"],
    withoutTokens: [Operand.constant(9)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["9", ")"],
    withTokens: [Operand.constant(9), Parenthesis.close],
    droppedLexemes: ["9"],
    droppedTokens: [Operand.constant(9)]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "×", "(", "("],
    withTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open, Parenthesis.open],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", "×", "("],
    withoutTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "×", "(", ")"],
    withTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open, Parenthesis.close],
    droppedLexemes: ["1", "×", "("],
    droppedTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.constant(1), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", ")", "×", "("],
    withTokens: [Operand.constant(1), Parenthesis.close, Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1", ")", "×"],
    droppedTokens: [Operand.constant(1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", ")"],
    withoutTokens: [Operand.constant(1), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", ")", ")"],
    withTokens: [Operand.constant(1), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1", ")"],
    droppedTokens: [Operand.constant(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.constant(1), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "+", "("],
    withTokens: [Operand.constant(1), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Operand.constant(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "+"],
    withoutTokens: [Operand.constant(1), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "+", ")"],
    withTokens: [Operand.constant(1), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1", "+"],
    droppedTokens: [Operand.constant(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.constant(1), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "÷", "("],
    withTokens: [Operand.constant(1), Operator.division, Parenthesis.open],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Operand.constant(1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "÷"],
    withoutTokens: [Operand.constant(1), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "÷", ")"],
    withTokens: [Operand.constant(1), Operator.division, Parenthesis.close],
    droppedLexemes: ["1", "÷"],
    droppedTokens: [Operand.constant(1), Operator.division]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.constant(1), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "×", "("],
    withTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Operand.constant(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "×"],
    withoutTokens: [Operand.constant(1), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "×", ")"],
    withTokens: [Operand.constant(1), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1", "×"],
    droppedTokens: [Operand.constant(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.constant(1), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1", "-", "("],
    withTokens: [Operand.constant(1), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Operand.constant(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1", "-"],
    withoutTokens: [Operand.constant(1), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1", "-", ")"],
    withTokens: [Operand.constant(1), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1", "-"],
    droppedTokens: [Operand.constant(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.constant(10)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["10", "×", "("],
    withTokens: [Operand.constant(10), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["10", "×"],
    droppedTokens: [Operand.constant(10), Operator.multiplication]
  ),
  (
    withoutLexemes: ["10"],
    withoutTokens: [Operand.constant(10)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["10", ")"],
    withTokens: [Operand.constant(10), Parenthesis.close],
    droppedLexemes: ["10"],
    droppedTokens: [Operand.constant(10)]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.constant(11)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["11", "×", "("],
    withTokens: [Operand.constant(11), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["11", "×"],
    droppedTokens: [Operand.constant(11), Operator.multiplication]
  ),
  (
    withoutLexemes: ["11"],
    withoutTokens: [Operand.constant(11)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["11", ")"],
    withTokens: [Operand.constant(11), Parenthesis.close],
    droppedLexemes: ["11"],
    droppedTokens: [Operand.constant(11)]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.constant(19)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["19", "×", "("],
    withTokens: [Operand.constant(19), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["19", "×"],
    droppedTokens: [Operand.constant(19), Operator.multiplication]
  ),
  (
    withoutLexemes: ["19"],
    withoutTokens: [Operand.constant(19)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["19", ")"],
    withTokens: [Operand.constant(19), Parenthesis.close],
    droppedLexemes: ["19"],
    droppedTokens: [Operand.constant(19)]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Operand.roll(1, 1)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "×", "("],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1"],
    withoutTokens: [Operand.roll(1, 1)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", ")"],
    withTokens: [Operand.roll(1, 1), Parenthesis.close],
    droppedLexemes: ["1d1"],
    droppedTokens: [Operand.roll(1, 1)]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [Operand.rollPositiveSides(1)],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "×", "("],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d"],
    withoutTokens: [Operand.rollPositiveSides(1)],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", ")"],
    withTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    droppedLexemes: ["1d"],
    droppedTokens: [Operand.rollPositiveSides(1)]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "×", "(", "("],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open, Parenthesis.open],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", "×", "("],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "×", "(", ")"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open, Parenthesis.close],
    droppedLexemes: ["1d1", "×", "("],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "×", "(", "("],
    withTokens: [
      Operand.rollPositiveSides(1),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d", "×", "("],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "×", "(", ")"],
    withTokens: [
      Operand.rollPositiveSides(1),
      Operator.multiplication,
      Parenthesis.open,
      Parenthesis.close,
    ],
    droppedLexemes: ["1d", "×", "("],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Operand.roll(1, 1), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", ")", "×", "("],
    withTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d1", ")", "×"],
    droppedTokens: [Operand.roll(1, 1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", ")"],
    withoutTokens: [Operand.roll(1, 1), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", ")", ")"],
    withTokens: [Operand.roll(1, 1), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1d1", ")"],
    droppedTokens: [Operand.roll(1, 1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", ")", "×", "("],
    withTokens: [
      Operand.rollPositiveSides(1),
      Parenthesis.close,
      Operator.multiplication,
      Parenthesis.open,
    ],
    droppedLexemes: ["1d", ")", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", ")"],
    withoutTokens: [Operand.rollPositiveSides(1), Parenthesis.close],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", ")", ")"],
    withTokens: [Operand.rollPositiveSides(1), Parenthesis.close, Parenthesis.close],
    droppedLexemes: ["1d", ")"],
    droppedTokens: [Operand.rollPositiveSides(1), Parenthesis.close]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Operand.roll(1, 1), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "+", "("],
    withTokens: [Operand.roll(1, 1), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Operand.roll(1, 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d1", "+"],
    withoutTokens: [Operand.roll(1, 1), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "+", ")"],
    withTokens: [Operand.roll(1, 1), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1d1", "+"],
    droppedTokens: [Operand.roll(1, 1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.addition],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "+", "("],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition, Parenthesis.open],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d", "+"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.addition],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "+", ")"],
    withTokens: [Operand.rollPositiveSides(1), Operator.addition, Parenthesis.close],
    droppedLexemes: ["1d", "+"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.addition]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Operand.roll(1, 1), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "÷", "("],
    withTokens: [Operand.roll(1, 1), Operator.division, Parenthesis.open],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Operand.roll(1, 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d1", "÷"],
    withoutTokens: [Operand.roll(1, 1), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "÷", ")"],
    withTokens: [Operand.roll(1, 1), Operator.division, Parenthesis.close],
    droppedLexemes: ["1d1", "÷"],
    droppedTokens: [Operand.roll(1, 1), Operator.division]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.division],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "÷", "("],
    withTokens: [Operand.rollPositiveSides(1), Operator.division, Parenthesis.open],
    droppedLexemes: ["1d", "÷"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.division]
  ),
  (
    withoutLexemes: ["1d", "÷"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.division],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "÷", ")"],
    withTokens: [Operand.rollPositiveSides(1), Operator.division, Parenthesis.close],
    droppedLexemes: ["1d", "÷"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.division]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "×", "("],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", "×"],
    withoutTokens: [Operand.roll(1, 1), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "×", ")"],
    withTokens: [Operand.roll(1, 1), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1d1", "×"],
    droppedTokens: [Operand.roll(1, 1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "×", "("],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.open],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d", "×"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.multiplication],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "×", ")"],
    withTokens: [Operand.rollPositiveSides(1), Operator.multiplication, Parenthesis.close],
    droppedLexemes: ["1d", "×"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.multiplication]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Operand.roll(1, 1), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d1", "-", "("],
    withTokens: [Operand.roll(1, 1), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Operand.roll(1, 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d1", "-"],
    withoutTokens: [Operand.roll(1, 1), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d1", "-", ")"],
    withTokens: [Operand.roll(1, 1), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1d1", "-"],
    droppedTokens: [Operand.roll(1, 1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    lexeme: "(",
    token: Parenthesis.open,
    withLexemes: ["1d", "-", "("],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction, Parenthesis.open],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.subtraction]
  ),
  (
    withoutLexemes: ["1d", "-"],
    withoutTokens: [Operand.rollPositiveSides(1), Operator.subtraction],
    lexeme: ")",
    token: Parenthesis.close,
    withLexemes: ["1d", "-", ")"],
    withTokens: [Operand.rollPositiveSides(1), Operator.subtraction, Parenthesis.close],
    droppedLexemes: ["1d", "-"],
    droppedTokens: [Operand.rollPositiveSides(1), Operator.subtraction]
  ),
  // TODO: Operand.rollNegativeSides
]
