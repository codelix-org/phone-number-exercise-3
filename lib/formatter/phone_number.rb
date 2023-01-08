module Formatter
  class PhoneNumber
    class InvalidNumber < StandardError; end

    VALID_PREFIXES = ["+44", "44", "0"]

    def self.call(number)
      # some code
      raise InvalidNumber if number.empty?
      raise InvalidNumber if valid_prefix(number).nil?

      numb_without_spaces = number.gsub(" ", "")
      num_without_prefix = numb_without_spaces.gsub(valid_prefix(number), "")

      raise InvalidNumber unless only_contains_numbers?(num_without_prefix)
      raise InvalidNumber unless num_without_prefix.length == 10
      raise InvalidNumber unless num_without_prefix.start_with?("7")

      "0#{num_without_prefix}"
    end

    private

    def self.only_contains_numbers?(number)
      number.scan(/\D/).empty?
    end

    def self.valid_prefix(number)
      VALID_PREFIXES.find do |prefix|
        number.start_with?(prefix)
      end
    end
  end
end
