# frozen_string_literal: true

require_relative "binary_expression_syntax"
require_relative "lexer"
require_relative "literal_expression_syntax"

# Creates the actual syntax tree representation
# from a list of tokens, provided by the lexer.
class Parser
  def initialize(text)
    lexer = Lexer.new(text)
    tokens = []
    loop do
      tok = lexer.next_token
      tokens.push(tok) unless %i[WhitespaceToken BadToken].include?(tok)
      break if tok.kind == :EndOfFileToken
    end
    @tokens = tokens.freeze
    @position = 0
  end

  private

  def peek(offset)
    index = @position + offset
    if index >= @tokens.length
      @tokens.last
    else
      @tokens[index]
    end
  end

  def current
    peek(0)
  end

  def next_token
    c = current
    @position += 1
    c
  end

  def match(kind)
    if current.kind == kind
      next_token
    else
      SyntaxToken.new(kind, current.position, nil, nil)
    end
  end

  public

  def parse
    parse_expression
  end

  def parse_expression
    left = parse_primary_expression

    while %i[PlusToken MinusToken].include?(current.kind)
      operator_token = next_token
      right = parse_primary_expression
      left = BinaryExpressionSyntax.new(left, operator_token, right)
    end

    left
  end

  def parse_primary_expression
    number_token = match(:NumberToken)
    LiteralExpressionSyntax.new(number_token)
  end
end
