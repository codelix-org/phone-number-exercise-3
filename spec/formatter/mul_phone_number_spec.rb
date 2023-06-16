require_relative '../../lib/formatter/mul_phone_number'

RSpec.describe Formatter::MulPhoneNumber do
  describe '#call' do
    context 'when the number is valid' do
      def valid_number
        "185630"
      end

      it 'does not format a number beginning with "18"' do
        formatted_number = Formatter::MulPhoneNumber.call(valid_number)

        expect(formatted_number).to eq(valid_number)
      end

      it 'removes any spaces from a number' do
        formatted_number = Formatter::MulPhoneNumber.call('185 63 0')
        expect(formatted_number).to eq(valid_number)
      end

      it 'formats a number beginning with "+558"' do
        formatted_number = Formatter::MulPhoneNumber.call('+5585630')

        expect(formatted_number).to eq(valid_number)
      end

      it 'formats a number beginning with "558"' do
        formatted_number = Formatter::MulPhoneNumber.call('5585630')

        expect(formatted_number).to eq(valid_number)
      end
    end

    context 'when the number is invalid' do
      it 'raises an error when the number has an invalid prefix' do
        invalid_number = '623456'

        expect{ Formatter::MulPhoneNumber.call(invalid_number) }.
          to raise_error(Formatter::MulPhoneNumber::InvalidNumber)
      end

      it 'raises an error when the number is empty' do
        invalid_number = ''

        expect{ Formatter::MulPhoneNumber.call(invalid_number) }.
          to raise_error(Formatter::MulPhoneNumber::InvalidNumber)
      end

      context 'when the prefix is valid' do
        it 'raises an error when the first number is not 1' do
          invalid_number = '284745809'

          expect{ Formatter::MulPhoneNumber.call(invalid_number) }.
            to raise_error(Formatter::MulPhoneNumber::InvalidNumber)
        end

        it 'raises an error when the number is too short' do
          invalid_number = '1867'

          expect{ Formatter::MulPhoneNumber.call(invalid_number) }.
            to raise_error(Formatter::MulPhoneNumber::InvalidNumber)
        end

        it 'raises an error when the number is too long' do
          invalid_number = '1876567897334455'

          expect{ Formatter::MulPhoneNumber.call(invalid_number) }.
            to raise_error(Formatter::MulPhoneNumber::InvalidNumber)
        end

        it 'raises an error when the number contains non-numeric characters' do
          invalid_number = '18non&num111'

          expect{Formatter::MulPhoneNumber.call(invalid_number)}.
            to raise_error(Formatter::MulPhoneNumber::InvalidNumber)
        end
      end
    end
  end
end
