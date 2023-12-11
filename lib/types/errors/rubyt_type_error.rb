# frozen_string_literal: true

require_relative 'rubyt_error'

class RubytTypeError < RubytError
  def initialize(expected_class, actual_class)
    super("Expected #{expected_class} but got #{actual_class} instead")
  end
end
