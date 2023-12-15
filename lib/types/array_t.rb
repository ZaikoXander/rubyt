# frozen_string_literal: true

require_relative 'any'

class ArrayT < Any
  class << self
    def t(value)
      raise RubytTypeError.new('ArrayT', value.class) unless value.is_a? ArrayT

      value
    end
  end

  private

  def valid_value?(value)
    value.is_a? Array
  end

  def validate_value(value)
    raise RubytTypeError.new('Array', value.class) unless valid_value? value
  end

  def setup_value(value)
    if value.is_a? ArrayT
      validate_value(value.t)

      return value.t
    end

    validate_value(value)

    value
  end

  public

  def initialize(value)
    super(setup_value(value))
  end
end
