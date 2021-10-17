# frozen_string_literal: true

require_relative "expression_syntax"

# A literal expression.
#
# `3`
class LiteralExpressionSyntax < ExpressionSyntax
  def initialize(literal_token)
    super
    @literal_token = literal_token
  end

  def kind
    :NumberExpression
  end

  attr_reader :literal_token

  def children
    [@literal_token]
  end
end
