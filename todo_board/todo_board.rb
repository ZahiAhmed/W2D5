require './list.rb'

class TodoBoard
    def initialize
        @lists = {} 
    end
    
    def get_command
        puts "Enter a command:"
        command, name, *args = gets.chomp.split(' ')

        case command
        when 'mklist'
            @lists[name] = List.new(name)
            return true
        when 'ls'
            @lists.each {|label, list| puts label}
            return true
        when 'showall'
            @lists.each {|label, list| list.print}
            return true
        when 'mktodo'
            @lists[name].add_item(*args)
            return true
        when 'up'
            @lists[name].up(*args.map(&:to_i))
            return true
        when 'down'
            @lists[name].down(*args.map(&:to_i))
            return true
        when 'swap'
            @lists[name].swap(*args.map(&:to_i))
            return true
        when 'sort'
            @lists[name].sort_by_date!
            return true
        when 'priority'
            @lists[name].print_priority
            return true
        when 'toggle'
            @lists[name].toggle_item(*args[0].to_i)
        when 'remove'
            @lists[name].remove_item(*args[0].to_i)
        when 'purge'
            @lists[name].purge
        when 'print'
            if args == []
                @lists[name].print
            else
                @lists[name].print_full_item(*args[0].to_i)
            end
            return true
        when 'quit'
            return false
        else
            print "Sorry, that command is not recognized."
        end
        true
    end    

    def run 
        while true
            return if !get_command
        end
    end
end

TodoBoard.new.run