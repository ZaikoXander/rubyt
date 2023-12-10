# frozen_string_literal: true

require_relative 'any'
require_relative 'errors/rubyt_type_error'

class NilableString < Any
  class << self
    def t(value)
      raise RubytTypeError.new('NilableString', value.class) unless value.is_a? NilableString

      value
    end
  end

  private

  def valid_value?(value)
    valid_classes = [NilClass, String]
    valid_classes.include? value.class
  end

  def validate_value(value)
    raise RubytTypeError.new('NilClass or String', value.class) unless valid_value? value
  end

  def setup_value(value)
    if value.is_a? NilableString
      validate_value(value.t)

      return value.t
    end

    validate_value(value)

    value
  end

  public

  def initialize(value = nil)
    super(setup_value(value))
  end

  def t=(value)
    @value = setup_value(value)
  end
end
