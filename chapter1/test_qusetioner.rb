$:.unshift File.dirname(__FILE__)
require 'questioner'
require 'test/unit'
require 'test_unit_extensions'
require 'flexmock/test_unit'
require 'stringio'

class QusetionerTest < Test::Unit::TestCase
  def setup
    @input  = flexmock('input')
    @output = flexmock('output')
    @questioner = Questioner.new(@input, @output)
    @question   = "Are you happy?"
  end

  %w[y Y YES yes Yes yeS].each do |yes|
    must "return true when parsing #{yes}" do
      expect_output(@question)
      provide_input(yes)
      assert @questioner.ask(@question), "Expected #{yes} to be true"
    end
  end

  %w[n no NO nO N].each do |no|
    must "return false when parsing #{no}" do
      expect_output(@question)
      provide_input(no)
      assert !@questioner.ask(@question), "Expected #{no} to be false"
    end
  end

  [['y', true],['n', false]].each do |input,state|
    must "continue to ask for input until given #{input}" do
      %w[Note Yesterday wxyz].each do |i|
        expect_output(@question)
        provide_input(i)
        expect_output("I don't understand.")
      end

      expect_output(@question)
      provide_input(input)

      assert_equal state, @questioner.ask(@question)
    end
  end

  def provide_input(string)
    @input.should_receive(:gets => string).once
  end


  def expect_output(string)
    @output.should_receive(:puts => string).with(string).once
  end
end
