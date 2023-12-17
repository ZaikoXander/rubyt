# frozen_string_literal: true

require_relative 'any'
require_relative 'errors/rubyt_type_error'

class IntegerT < Any
  class << self
    def t(value)
      raise RubytTypeError.new(IntegerT, value.class) unless value.is_a? IntegerT

      value
    end
  end

  private

  def valid_value?(value) = value.is_a? Integer

  def validate_value(value)
    raise RubytTypeError.new(Integer, value.class) unless valid_value? value
  end

  def setup_value(value)
    if value.is_a? IntegerT
      validate_value(value.t)

      return value.t
    end

    validate_value(value)

    value
  end

  public

  def initialize(value) = super(setup_value(value))
end
