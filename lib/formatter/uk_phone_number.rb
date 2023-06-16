require 'pry'

module Formatter
  class UkPhoneNumber
    class InvalidNumber < StandardError
      attr_reader :message
      def initialize(message)
        @message = message
      end
    end
    
    def self.call(number)
      number.delete!(" ")
      number = number.gsub("+44", "0")
      number = number.gsub("44", "0")
      begin
        if number.length == 11 && number.slice(0..1) == "07"
          number
        else
          raise InvalidNumber.new("the number: #{number}, is invalid for the UK")
        end
      end
    end
  end
end
