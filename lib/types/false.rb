# frozen_string_literal: true

require_relative 'any'
require_relative 'errors/rubyt_type_error'

class False < Any
  class << self
    def t(value)
      raise RubytTypeError.new('False', value.class) unless value.is_a? False

      value
    end
  end

  private

  def valid_value?(value)
    value.is_a? FalseClass
  end

  def validate_value(value)
    raise RubytTypeError.new('FalseClass', value.class) unless valid_value? value
  end

  def setup_value(value)
    if value.is_a? False
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
