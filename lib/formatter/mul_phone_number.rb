require 'dry/monads'

module Formatter
  class MulPhoneNumber
    def self.call(number)
      number.delete!(" ")
      number = number.gsub("+55", "1")
      number = number.gsub("55", "1")
      begin
        if number.length == 6 && number.slice(0..1) == "18"
          Dry::Monads::Result::Success.new(number)
        else
          Dry::Monads::Result::Failure.new("the number: #{number}, is invalid for the MUL")
        end
      end
    end
  end
end
