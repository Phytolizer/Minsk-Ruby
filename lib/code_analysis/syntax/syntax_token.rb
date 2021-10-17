# frozen_string_literal: true

# A single element of the Minsk language.
class SyntaxToken
  def initialize(kind, position, text, value)
    @kind = kind
    @position = position
    @text = text
    @value = value
  end

  attr_reader :kind, :position, :text, :value
end
