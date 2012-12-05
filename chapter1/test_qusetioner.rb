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

  %w[y Y YES yes].each do |yes|
    must "return true when yes_or_no parses #{yes}" do
      assert @questioner.yes_or_no(yes), "#{yes.inspect} expected to parse as true"
    end
  end

  %w[y Y YES yes].each do |yes|
    must "return true when parsing #{yes}" do
      provide_input(yes)
      assert @questioner.ask(@question), "#{yes.inspect} expected to parse as true"
    end
  end

  %w[n no NO nO].each do |no|
    must "return false when yes_or_no parses #{no}" do
      assert !@questioner.yes_or_no(no), "#{no.inspect} expected to parse as false"
    end
  end

  %w[n no NO nO].each do |no|
    must "return false when parsing #{no}" do
      provide_input(no)
      assert !@questioner.ask(@question), "#{no.inspect} expected to parse as false"
    end
  end

  %w[Note Yesterday wxyz].each do |mu|
    must "return nil because #{mu} is not avariant of 'yes' or 'no'" do
      assert_nil @questioner.yes_or_no(mu), "#{mu.inspect} expected to parse as nil"
    end
  end

  must "respond 'Good I'm Glad' whe inquire_about_happiness gets 'yes'" do
    provide_input('yes')
    assert_equal "Good I'm Glad.", @questioner.inquire_about_happiness
  end

  must "respond 'That's so Bad.' when inquire_about_happiness gets 'no'" do
    provide_input('no')
    assert_equal "That's so Bad.", @questioner.inquire_about_happiness
  end

  def provide_input(string)
    @input << string
    @input.rewind
  end


  def expect_output(string)
    assert_equal string, @output.string
  end
end
