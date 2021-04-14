# frozen_string_literal: true

require_relative 'lib/lottery'
require_relative 'lib/output_file'

class Main
  def initialize
    puts '-----------------------------------------------------------------'
    puts 'It\'s the LCS lottery programm'
    puts '-----------------------------------------------------------------'
    run_lottery
  end

  private

  def run_lottery
    data = data_input_dialog
    Validate.new(data)
    @result = Lottery.new(**data).result
    data_output_dalog
  rescue StandardError => e
    puts '----------------------There are some errors---------------------'
    puts e
    puts (e.backtrace or []).join("\n")
    puts '---------------------------Try again----------------------------'
    # run_lottery
  end

  def data_input_dialog
    puts 'push enter to input params(or type \'d\' for default scenario):'
    if gets.chomp == 'd'
      { lcs: '456000123', file_name: 'input.txt' }
    else
      { lcs: input_data('winner number'),
        file_name: input_data('file name') }
    end
  end

  def input_data(text)
    puts "Please input #{text}:"
    data = gets.chomp
    exit! if %w[exit close].include?(data)
    data
  end

  def data_output_dalog
    puts '------------------Winners successfully founded------------------'
    handle_output
  end

  def handle_output
    puts 'push enter to create file (or type \'c\' for only console output):'
    unless gets.chomp == 'c'
      OutputFile.new(@result)
      puts '--------------------------File created--------------------------'
    end
    puts 'Example:'
    puts @result
  end
end

Main.new
