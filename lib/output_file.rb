# frozen_string_literal: true

class OutputFile
  attr_accessor :data, :file_data
  def initialize(data)
    @data = data
    create_file
  end

  private

  def create_file
    File.open('output.txt', 'w') { |f| f.write(data) }
  end
end
