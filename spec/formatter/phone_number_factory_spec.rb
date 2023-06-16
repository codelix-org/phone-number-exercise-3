require_relative '../../lib/formatter/phone_number_factory'
require_relative '../../lib/formatter/uk_phone_number'
require_relative '../../lib/formatter/mul_phone_number'

RSpec.describe Formatter::PhoneNumberFactory do
  describe '#call' do
    context 'depending on the country, determines the number returned' do
      it 'returns a UK phone number, when the UK formatter is passed in' do
        uk_formatter = Formatter::UkPhoneNumber
        valid_uk_number = "07809454321"
        result = described_class.new(uk_formatter, valid_uk_number).call
        expect(result).to eq(valid_uk_number)
      end

      it 'returns a MUL phone number, when the MUL formatter is passed in' do
        mul_formatter = Formatter::MulPhoneNumber
        valid_mul_number = "185464"
        result = described_class.new(mul_formatter, valid_mul_number).call
        expect(result).to eq(valid_mul_number)
      end
      it 'raises an error when an invalid number has been passed' do
        mul_formatter = Formatter::MulPhoneNumber
        invalid_mul_number = "18546765674"
        expect{described_class.new(mul_formatter, invalid_mul_number).call}.
        to raise_error(Formatter::PhoneNumberFactory::InvalidNumber, "the number: #{invalid_mul_number}, is invalid")
      end
    end
  end
end
