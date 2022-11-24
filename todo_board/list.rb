require "./item.rb"
class List
    def initialize(label)
        @label = label.capitalize
        @items = []
    end

    def label
        @label
    end

    def label=(new_label)
        @label = new_label
    end

    def add_item(title, deadline, description ="")
        return false if !Item.new(title, deadline, description)
        new_item = Item.new(title, deadline, description)
        @items << new_item
    end

    def size
         @items.length
    end

    def valid_index?(index)
        index < self.size && index >= 0
    end

    def swap(index_1, index_2)
        return false if !self.valid_index?(index_1) || !self.valid_index?(index_2)
        @items[index_1] , @items[index_2] = @items[index_2] , @items[index_1]
        true
    end

    def [](index)
        return nil if !self.valid_index?(index)
        @items[index]
    end

    def priority
        @items[0] 
    end

    def print
        puts
        puts @label.ljust(30) + "finished" if @items == []
        puts @label if @items != []
        puts "======================================="
        puts @items.map.with_index {|item, i| i.to_s.ljust(2) + " " + item.title.ljust(15) + " " + item.deadline + " " + item.status}
    end
    
    def print_full_item(index)
        if self.valid_index?(index)
            puts @items[index].title.ljust(15) + " " + @items[index].deadline
            puts @items[index].description + "   :" + @items[index].status
        end
    end

    def print_priority
        puts @items[0].title.ljust(15) + " " + @items[0].deadline
        puts @items[0].description + "   :" + @items[0].status
    end

    def up(index, amount=1)
        return false if !self.valid_index?(index)
        while amount > 0
            if index > 0
                swap(index, index-1)
                index -= 1
            end
            amount -=1 
        end
        true
    end

    def down(index,amount=1)
        return false if !self.valid_index?(index)
        while amount > 0
            if index < @items.length
                swap(index, index+1)
                index += 1
            end
            amount -=1 
        end
        true
    end

    def sort_by_date!
        @items.sort_by!{|item| item.deadline.split("-").join.to_i}
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        return false if !valid_index?(index)
        @items.delete(index)
        true
    end

    def purge
        @items = [] if @items.all?{|item| item.done}
    end

end