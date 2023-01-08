require_relative '../../lib/formatter/phone_number'

RSpec.describe Formatter::PhoneNumber do
  describe '#call' do
    context 'when the number is valid' do
      def valid_number
        "07469484176"
      end

      it 'does not format a number beginning with "07"' do
        formatted_number = Formatter::PhoneNumber.call(valid_number)

        expect(formatted_number).to eq(valid_number)
      end

      it 'removes any spaces from a number' do
        formatted_number = Formatter::PhoneNumber.call('07469 484 176')
        expect(formatted_number).to eq('07469484176')
      end

      it 'formats a number beginning with "+447"' do
        formatted_number = Formatter::PhoneNumber.call('+447469484176')

        expect(formatted_number).to eq(valid_number)
      end

      it 'formats a number beginning with "447"' do
        formatted_number = Formatter::PhoneNumber.call('447469484176')

        expect(formatted_number).to eq(valid_number)
      end
    end

    context 'when the number is invalid' do
      it 'raises an error when the number has an invalid prefix' do
        invalid_number = '17469484176'

        expect{ Formatter::PhoneNumber.call(invalid_number) }.
          to raise_error(Formatter::PhoneNumber::InvalidNumber)
      end

      it 'raises an error when the number is empty' do
        invalid_number = ''

        expect{ Formatter::PhoneNumber.call(invalid_number) }.
          to raise_error(Formatter::PhoneNumber::InvalidNumber)
      end

      context 'when the prefix is valid' do
        it 'raises an error when the first number is not 7' do
          invalid_number = '01469484176'

          expect{ Formatter::PhoneNumber.call(invalid_number) }.
            to raise_error(Formatter::PhoneNumber::InvalidNumber)
        end

        it 'raises an error when the number is too short' do
          invalid_number = '0700'

          expect{ Formatter::PhoneNumber.call(invalid_number) }.
            to raise_error(Formatter::PhoneNumber::InvalidNumber)
        end

        it 'raises an error when the number is too long' do
          invalid_number = '070007000700070007000700'

          expect{ Formatter::PhoneNumber.call(invalid_number) }.
            to raise_error(Formatter::PhoneNumber::InvalidNumber)
        end

        it 'raises an error when the number contains non-numeric characters' do
          invalid_number = '07non&num111'

          expect{ Formatter::PhoneNumber.call(invalid_number) }.
            to raise_error(Formatter::PhoneNumber::InvalidNumber)
        end
      end
    end
  end
end
