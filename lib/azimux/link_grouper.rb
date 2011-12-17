module Azimux
  class LinkGrouper
    private
    def groups=(g)
      @groups = g
    end
    public
    def groups
      @groups ||= {}
    end

    def initialize(item_array)
      item_array.each do |i|
        item = Item.new(*i)
        index = item.key


        groups[index] ||= []
        groups[index] << item
      end

      groups2 = {}
      groups.each_pair do |key, value|
        groups2[key] = value.sort
      end
      self.groups = groups2
    end

    def make_columns(columns_count)
      columns = []
      columns_count.times do
        columns << []
      end

      total_count = 0

      groups.each_value do |v|
        total_count += v.size
      end

      # let's clear up some space for the group label
      total_count += groups.size * 2
      passed = 0

      target = (total_count / columns_count)

      groups.keys.sort.each do |key|
        columns[passed / target] << Group.new(key,groups[key])

        passed += 2 + groups[key].size
      end

      columns
    end


    class Group
      attr_reader :key, :values

      def initialize(k, v)
        @key, @values = k, v
      end
    end

    class Item
      attr_reader :string, :url

      def initialize(s, u)
        @string, @url = s, u
      end

      def key
        string[0].chr.upcase
      end

      def <=>(oitem)
        rval = key <=> oitem.key

        rval = string <=> oitem.string if rval == 0
        rval
      end
    end

  end

end