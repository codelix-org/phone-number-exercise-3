require_relative '../../lib/formatter/uk_phone_number'

RSpec.describe Formatter::UkPhoneNumber do
  describe '#call' do
    context 'when the number is valid' do
      def valid_number
        "07469484176"
      end

      it 'does not format a number beginning with "07"' do
        result = Formatter::UkPhoneNumber.call(valid_number)

        expect(result.value!).to eq(valid_number)
      end

      it 'removes any spaces from a number' do
        result = Formatter::UkPhoneNumber.call('07469 484 176')
        expect(result.value!).to eq('07469484176')
      end

      it 'formats a number beginning with "+447"' do
        result = Formatter::UkPhoneNumber.call('+447469484176')

        expect(result.value!).to eq(valid_number)
      end

      it 'formats a number beginning with "447"' do
        result = Formatter::UkPhoneNumber.call('447469484176')

        expect(result.value!).to eq(valid_number)
      end
    end

    context 'when the number is invalid' do
      it 'raises a failure monad when the number has an invalid prefix' do
        invalid_number = '17469484176'

        result = Formatter::UkPhoneNumber.call(invalid_number)
        expect(result).not_to be_success
        expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the UK")

      end

      it 'raises an error when the number is empty' do
        invalid_number = ''

        result = Formatter::UkPhoneNumber.call(invalid_number)
        expect(result).not_to be_success
        expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the UK")
      end

      context 'when the prefix is valid' do
        it 'raises an error when the first number is not 0' do
          invalid_number = '27469484176'

          result = Formatter::UkPhoneNumber.call(invalid_number)
          expect(result).not_to be_success
          expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the UK")

        end

        it 'raises an error when the number is too short' do
          invalid_number = '0700'

          result = Formatter::UkPhoneNumber.call(invalid_number)
          expect(result).not_to be_success
          expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the UK")

        end

        it 'raises an error when the number is too long' do
          invalid_number = '070007000700070007000700'

          result = Formatter::UkPhoneNumber.call(invalid_number)
          expect(result).not_to be_success
          expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the UK")

        end

        it 'raises an error when the number contains non-numeric characters' do
          invalid_number = '07non&num111'

          result = Formatter::UkPhoneNumber.call(invalid_number)
          expect(result).not_to be_success
          expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the UK")
        end
      end
    end
  end
end
