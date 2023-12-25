# frozen_string_literal: true

require_relative 'rubyt_error'

class RubytMustNotBeNilError < RubytError
  def initialize(message = 'must not be nil') = super(message.nil? ? 'must not be nil' : message)
end
