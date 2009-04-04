require 'csv'

module Azimux
  class CsvDbParser
    attr_accessor :headers
    def self.parse(csv, &block)
      new.parse(csv, &block)
    end

    def parse(csv)
      CSV::Reader.parse(csv) do |row|
        if !headers && !skip?(row)
          self.headers = row
        elsif !skip?(row)
          hash = {}
          row.each_with_index do |col, index|
            hash[headers[index]] = col
          end

          raise "column mismatch" if hash.keys.size != headers.size

          yield hash
        end
      end
    end

    def skip?(row)
      (row.empty?) || (headers && headers.size > 1 && row == [nil])
    end
  end
end