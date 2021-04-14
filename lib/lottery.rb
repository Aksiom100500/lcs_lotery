# frozen_string_literal: true

require_relative 'input_file'
require_relative 'output_file'
require_relative 'validate'

class Lottery
  attr_accessor :data, :file_data
  def initialize(**data)
    raise 'LCS or file name is blank' if data[:lcs].empty? || data[:file_name].empty?

    @data = data
    @file_data = InputFile.new(data[:file_name]).data
  end

  def result
    analize_data.map{ |el| el.join(',') }.join("\n")
  end

  private

  def analize_data
    file_data.each_with_object(Hash.new(0)) do |arr, hash|
      user_data = arr[0]
      credits = count_credis(arr[1]).size ||= 0
      hash[user_data] = hash[user_data].nil? ? credits : hash[user_data] + credits
    end
  end

  def count_credis(ticket)
    data[:lcs].split('') & ticket.split('')
  end
end
