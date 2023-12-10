# frozen_string_literal: true

require_relative 'errors/rubyt_type_error'

class Any
  class << self
    def t(value)
      raise RubytTypeError.new('Any', value.class) unless value.is_a? Any

      value
    end
  end

  private

  def valid_value?(value); end

  def validate_value(value); end

  def setup_value(value)
    if value.is_a? Any
      validate_value(value.t)

      return value.t
    end

    validate_value(value)

    value
  end

  public

  def initialize(value = nil)
    @value = setup_value(value)
  end

  def t
    @value
  end

  def t=(value)
    @value = setup_value(value)
  end

  def to_s
    @value.to_s
  end
end
