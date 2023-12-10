# frozen_string_literal: true

require_relative '../../../../lib/types/errors/rubyt_error'

describe RubytError do
  describe '#initialize' do
    it 'is a StandardError' do
      rubyt_error = RubytError.new
      expect(rubyt_error).to be_a RubytError
      expect(rubyt_error).to be_a StandardError
    end

    it 'receives a message' do
      rubyt_error = RubytError.new('Custom message')
      expect(rubyt_error.message).to eq 'Custom message'
    end
  end
end
