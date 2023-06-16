require 'dry/monads'
require 'pry'

module Formatter
  class PhoneNumberFactory
    class InvalidNumber < StandardError
      attr_reader :message
      def initialize(message)
        @message = message
      end
    end

    def initialize(country, number)
      @country = country
      @number = number
    end

    def call
      result = @country.call(@number).value_or {raise InvalidNumber.new("the number: #{@number}, is invalid")}
    end
  end
end
