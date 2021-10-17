# frozen_string_literal: true

require_relative "syntax_token"

# The Minsk lexer.
#
# Converts raw text into tokens.
class Lexer
  def initialize(text)
    @text = text
    @position = 0
  end

  private

  def current
    if @position >= @text.length
      "\0"
    else
      @text[@position]
    end
  end

  public

  def next_token
    if current =~ /[0-9]/
      start = @position
      @position += 1 while current =~ /[0-9]/

      text = @text[start...@position]
      value = text.to_i
      return SyntaxToken.new(:NumberToken, start, text, value)
    end

    if current =~ /[ \t]/
      start = @position
      @position += 1 while current =~ /[ \t]/

      text = @text[start...@position]
      return SyntaxToken.new(:WhitespaceToken, start, text, nil)
    end

    tok = case current
          when "+"
            SyntaxToken.new(:PlusToken, @position, "+", nil)
          when "-"
            SyntaxToken.new(:MinusToken, @position, "-", nil)
          when "*"
            SyntaxToken.new(:StarToken, @position, "*", nil)
          when "/"
            SyntaxToken.new(:SlashToken, @position, "/", nil)
          when "("
            SyntaxToken.new(:OpenParenthesisToken, @position, "(", nil)
          when ")"
            SyntaxToken.new(:CloseParenthesisToken, @position, ")", nil)
          when "\0"
            SyntaxToken.new(:EndOfFileToken, @position, "", nil)
          else
            SyntaxToken.new(:BadToken, @position, current, nil)
          end
    @position += 1
    tok
  end
end
