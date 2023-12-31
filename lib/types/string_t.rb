# frozen_string_literal: true

require_relative 'any'
require_relative 'array_t'
require_relative 'errors/rubyt_type_error'

class StringT < Any
  class << self
    def t(*values)
      validated_values = ArrayT.new(
        values.map do |value|
          raise RubytTypeError.new(StringT, value.class) unless value.is_a? StringT

          value
        end
      )

      return validated_values.t.first if validated_values.t.length == 1

      validated_values
    end
  end

  private

  def valid_value?(value) = value.is_a? String

  def validate_value(value)
    raise RubytTypeError.new(String, value.class) unless valid_value? value
  end

  def setup_value(value)
    if value.is_a? StringT
      validate_value(value.t)

      return value.t
    end

    validate_value(value)

    value
  end

  public

  def initialize(value) = super(setup_value(value))

  def ==(other)
    other.is_a?(StringT) && other.t == @value
  end

  def !=(other)
    !(other.is_a?(StringT) && other.t == @value)
  end
end
