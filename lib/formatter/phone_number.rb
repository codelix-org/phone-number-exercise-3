require 'pry'

module Formatter
  class PhoneNumber
    class InvalidNumber < StandardError
      def initialize(number)
        "the number: #{number}, is invalid"
      end
    end

    def self.call(number)
      number.delete!(" ")
      number = number.gsub("+44", "0")
      number = number.gsub("44", "0")
      if number.length == 11 && number.slice(0..1) == "07"
        number
      else
        raise InvalidNumber.new(number)
      end
    end
  end
end
