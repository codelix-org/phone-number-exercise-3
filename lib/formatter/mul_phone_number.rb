require 'dry/monads'

module Formatter
  class MulPhoneNumber
    class InvalidNumber < StandardError
      attr_reader :message
      def initialize(message)
        @message = message
      end
    end

    def self.call(number)
      number.delete!(" ")
      number = number.gsub("+55", "1")
      number = number.gsub("55", "1")
      begin
        if number.length == 6 && number.slice(0..1) == "18"
          number
        else
          raise InvalidNumber.new("the number: #{number}, is invalid for the MUL")
        end
      end
    end
  end
end
