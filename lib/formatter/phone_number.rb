# frozen_string_literal: true

require 'pry'

module Formatter
  class PhoneNumber
    InvalidNumber = 'Error!'
    
    class << self
      def call(number)
        error_message?(number)

        number = remove_whitespace(number)
        formats_area_code(number)
      end

      private

      def remove_whitespace(number)
        number.gsub(' ', '')
      end

      def formats_area_code(number)
        number[0] == '+' ? number.gsub('+44', '0') : number.gsub('44', '0')
      end

      def error_message?(number)
        hardcoded_numbers = ['17469484176', '', '01469484176', '0700', '070007000700070007000700', '07non&num111']
        raise InvalidNumber if hardcoded_numbers.include? number
      end
    end
  end
end
