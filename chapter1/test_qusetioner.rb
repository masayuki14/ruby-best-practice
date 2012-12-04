$:.unshift File.dirname(__FILE__)
require 'questioner'
require 'test/unit'
require 'test_unit_extensions'

class QusetionerTest < Test::Unit::TestCase
  def setup
    @questioner = Questioner.new
  end

  %w[y Y YES yes].each do |yes|
    must "return true when yes_or_no parses #{yes}" do
      assert @questioner.yes_or_no(yes), "#{yes.inspect} expected to parse as true"
    end
  end

  %w[n no NO nO].each do |no|
    must "return false when yes_or_no parses #{no}" do
      assert !@questioner.yes_or_no(no), "#{no.inspect} expected to parse as false"
    end
  end

  %w[Note Yesterday wxyz].each do |mu|
    must "return nil because #{mu} is not avariant of 'yes' or 'no'" do
      assert_nil @questioner.yes_or_no(mu), "#{mu.inspect} expected to parse as nil"
    end
  end
end
