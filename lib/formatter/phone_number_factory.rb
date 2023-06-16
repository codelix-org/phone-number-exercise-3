require 'pry'

module Formatter
  class PhoneNumberFactory

    def initialize(country, number)
      @country = country
      @number = number
    end

    def call
      result = @country.call(@number)
    end
  end
end
