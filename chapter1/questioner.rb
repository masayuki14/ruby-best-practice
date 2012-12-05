class Questioner

  def initialize(input=STDIN, output=STDOUT)
    @input  = input
    @output = output
  end

  def inquire_about_happiness
    ask("Are you happy?") ? "Good I'm Glad." : "That's so Bad."
  end

  def ask(question)
    @output.puts question
    response = yes_or_no(@input.gets.chomp)
    response.nil? ? ask(question): response
  end

  def yes_or_no(response)
    case(response)
    when /^y(es)?$/i
      true
    when /^no?$/i
      false
    end
  end

end
