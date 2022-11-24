class Item
    def self.valid_date?(date_string)
        valid = date_string.split("-").map {|date| date}
        if valid.length == 3
            y = valid[0]
            m = valid[1]
            d = valid[2]
            return false if y.length != 4
            return false if m.to_i > 12 || m.length != 2
            return false if d.to_i > 31 || d.length != 2
            return true
        end
        false
    end

    attr_accessor :title, :deadline, :description, :done

    def initialize(title, deadline, description="")
        if !Item.valid_date?(deadline)
            raise "invalid deadline"
        end
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    def toggle
        if !@done
            @done = true  
        else
            @done = false
        end
    end

    def status
        return "    done" if @done
        return "not done"
    end

end