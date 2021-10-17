# frozen_string_literal: true

require_relative "expression_syntax"

# A binary expression.
#
# `x + y`
class BinaryExpressionSyntax < ExpressionSyntax
  def initialize(left, operator_token, right)
    super
    @left = left
    @operator_token = operator_token
    @right = right
  end

  def kind
    :BinaryExpression
  end

  attr_reader :left, :operator_token, :right

  def children
    [@left, @operator_token, @right]
  end
end
