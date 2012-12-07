$:.unshift File.dirname(__FILE__)
require 'questioner'
require 'test/unit'
require 'test_unit_extensions'
require 'flexmock/test_unit'
require 'stringio'

class QusetionerTest < Test::Unit::TestCase
  def setup
    @input  = StringIO.new
    @output = StringIO.new
    @questioner = Questioner.new(@input, @output)
    @question   = "Are you happy?"
  end

  %w[y Y YES yes Yes yeS].each do |yes|
    must "return true when parsing #{yes}" do
      provide_input(yes)
      assert @questioner.ask(@question), "#{yes.inspect} expected to be true"
      expect_output(@question)
    end
  end

  %w[n no NO nO N].each do |no|
    must "return false when parsing #{no}" do
      provide_input(no)
      assert !@questioner.ask(@question), "#{no.inspect} expected to be false"
      expect_output(@question)
    end
  end

  [['y', true],['n', false]].each do |input,state|
    must "continue to ask for input until given #{input}" do
      provide_input("Note\nYesterday\nwxyz\n#{input}")
      assert_equal state, @questioner.ask(@question)
      expect_output("#{@question}\nI don't understand.\n"*3 + "#{@question}\n")
    end
  end

  def provide_input(string)
    @input << string
    @input.rewind
  end


  def expect_output(string)
    assert_equal string.chomp, @output.string.chomp
  end
end
