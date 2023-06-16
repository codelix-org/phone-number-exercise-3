require_relative '../../lib/formatter/mul_phone_number'

RSpec.describe Formatter::MulPhoneNumber do
  describe '#call' do
    context 'when the number is valid' do
      def valid_number
        "185630"
      end

      it 'does not format a number beginning with "18"' do
        result = Formatter::MulPhoneNumber.call(valid_number)

        expect(result).to be_success
        expect(result.value!).to eq(valid_number)
      end

      it 'removes any spaces from a number' do
        result = Formatter::MulPhoneNumber.call('185 63 0')
        expect(result.value!).to eq(valid_number)
      end

      it 'formats a number beginning with "+558"' do
        result = Formatter::MulPhoneNumber.call('+5585630')

        expect(result.value!).to eq(valid_number)
      end

      it 'formats a number beginning with "558"' do
        result = Formatter::MulPhoneNumber.call('5585630')

        expect(result.value!).to eq(valid_number)
      end
    end

    context 'when the number is invalid' do
      it 'raises a failure monad when the number has an invalid prefix' do
        invalid_number = '623456'
        result = Formatter::MulPhoneNumber.call(invalid_number)

        expect(result).not_to be_success
        expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the MUL")
      end

      it 'raises a failure monad when the number is empty' do
        invalid_number = ''

        result = Formatter::MulPhoneNumber.call(invalid_number)

        expect(result).not_to be_success
        expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the MUL")
      end

      context 'when the prefix is valid' do
        it 'raises a failure monad when the first number is not 1' do
          invalid_number = '284745809'

          result = Formatter::MulPhoneNumber.call(invalid_number)

          expect(result).not_to be_success
          expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the MUL")
        end

        it 'raises an error when the number is too short' do
          invalid_number = '1867'

          result = Formatter::MulPhoneNumber.call(invalid_number)

          expect(result).not_to be_success
          expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the MUL")
        end

        it 'raises an error when the number is too long' do
          invalid_number = '1876876578859768'

          result = Formatter::MulPhoneNumber.call(invalid_number)

          expect(result).not_to be_success
          expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the MUL")
        end

        it 'raises an error when the number contains non-numeric characters' do
          invalid_number = '18non&num111'

          result = Formatter::MulPhoneNumber.call(invalid_number)

          expect(result).not_to be_success
          expect(result.failure).to eq("the number: #{invalid_number}, is invalid for the MUL")
        end
      end
    end
  end
end
