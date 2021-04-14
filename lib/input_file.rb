# frozen_string_literal: true

class InputFile
  attr_accessor :file_data, :data
  def initialize(file_name)
    @file_data = File.read(file_name)
    @data = data_to_h
  end

  private

  def data_to_h
    file_data.split("\n").map do |el|
      match = el.match(/^(?<user_data>.*),(?<ticket>\d*)/i)
      [match[:user_data], match[:ticket]]
    end
  end
end
