# frozen_string_literal: true

class Validate
  attr_accessor :data, :messages
  def initialize(data)
    @data = data
    @messages = []
    validate_data
  end

  private

  def validate_data
    validate_presence
    validate_fields
  end

  def validate_fields
    messages << 'Winning number shouldn\'t include letters or symbols' if data[:lcs][/\d*/].size != data[:lcs].size
    messages << 'File isn\'t exist' unless File.exist?(data[:file_name])
    try_raise!(messages)
  end

  def validate_presence
    data.map { |k, v| messages << "#{k.capitalize} is blank" if v.nil? || v.empty? }
    try_raise!(messages)
  end

  def try_raise!(messages)
    return if messages.empty?

    raise "#{messages.join(', ')}."
  end
end
