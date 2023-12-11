# frozen_string_literal: true

require_relative '../../../../lib/types/errors/rubyt_error'

describe RubytError do
  describe '#initialize' do
    it 'instantiates' do
      rubyt_error = RubytError.new
      expect(rubyt_error).to be_a RubytError
      expect(rubyt_error).to be_a StandardError
    end
  end

  describe 'raising' do
    it 'raises with a custom message' do
      expect { raise RubytError, 'Custom message' }.to raise_error RubytError, 'Custom message'
    end
  end
end
