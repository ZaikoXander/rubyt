# frozen_string_literal: true

require_relative 'any'
require_relative 'errors/rubyt_type_error'

class HashT < Any
  class << self
    def t(value)
      raise RubytTypeError.new('HashT', value.class) unless value.is_a? HashT

      value
    end
  end

  private

  def valid_value?(value)
    value.is_a? Hash
  end

  def validate_value(value)
    raise RubytTypeError.new('Hash', value.class) unless valid_value? value
  end

  def setup_value(value)
    if value.is_a? HashT
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
