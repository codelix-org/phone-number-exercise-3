require 'dry/monads'

module Formatter
  class UkPhoneNumber
    def self.call(number)
      number.delete!(" ")
      number = number.gsub("+44", "0")
      number = number.gsub("44", "0")
      begin
        if number.length == 11 && number.slice(0..1) == "07"
          Dry::Monads::Result::Success.new(number)
        else
          Dry::Monads::Result::Failure.new("the number: #{number}, is invalid for the UK")
        end
      end
    end
  end
end
