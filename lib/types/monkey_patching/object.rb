# frozen_string_literal: true

class Object
  def must(message = nil)
    raise RubytMustNotBeNilError, message if nil?

    self
  end
end
