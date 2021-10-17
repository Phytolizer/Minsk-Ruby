# frozen_string_literal: true

require_relative "code_analysis/syntax/lexer"

loop do
  print ">> "
  line = gets
  break if line.nil?

  lexer = Lexer.new(line.chomp)
  loop do
    tok = lexer.next_token
    break if tok.kind == :EndOfFileToken

    puts "#{tok.kind} '#{tok.text}' #{tok.value}"
  end
end
