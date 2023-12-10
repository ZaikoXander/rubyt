# frozen_string_literal: true

require_relative '../../../../lib/types/monkey_patching/object'
require_relative '../../../../lib/types/errors/rubyt_must_not_be_nil_error'

describe Object do
  describe '#must' do
    context 'when object is not nil' do
      it 'returns object' do
        [1, '1', 1.5, true, false, {}, []].each do |value|
          expect { value.must }.not_to raise_error
          expect(value.must).to eq value
        end
      end
    end

    context 'when object is nil' do
      it 'raises a RubytMustNotBeNilError' do
        expect { nil.must }.to raise_error RubytMustNotBeNilError, 'must not be nil'
      end

      it 'raises a RubytMustNotBeNilError with a custom message' do
        expect { nil.must('Custom message') }.to raise_error RubytMustNotBeNilError, 'Custom message'
      end
    end
  end
end
