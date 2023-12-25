# frozen_string_literal: true

require_relative 'any'
require_relative 'errors/rubyt_type_error'

class Boolean < Any
  class << self
    def t(value)
      raise RubytTypeError.new(Boolean, value.class) unless value.is_a? Boolean

      value
    end
  end

  private

  def valid_value?(value)
    valid_classes = [TrueClass, FalseClass]
    valid_classes.include? value.class
  end

  def validate_value(value)
    raise RubytTypeError.new('TrueClass or FalseClass', value.class) unless valid_value? value
  end

  def setup_value(value)
    if value.is_a? Boolean
      validate_value(value.t)

      return value.t
    end

    validate_value(value)

    value
  end

  public

  def initialize(value) = super(setup_value(value))
end
