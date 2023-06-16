require 'dry/monads'
require 'pry'

module Formatter
  class PhoneNumberFactory
    class InvalidNumber < StandardError
    end

    def initialize(country, number)
      @country = country
      @number = number
    end

    def call
      result = @country.call(@number).value_or {|failure| raise InvalidNumber, "#{failure}"}
    end
  end
end
