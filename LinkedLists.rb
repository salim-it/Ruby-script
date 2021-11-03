class LinkedList

    attr_reader :head, :tail

    def initialize
        @head = @tail = nil
    end

    def add_first_node(value)
        @head = @tail = Node.new(value)
        @head.next = nil
    end

    def append(value)
        if @head.nil?
          add_first_node(value)
        else
          @tail.next = Node.new(value)
          @tail = @tail.next
        end
    end

    def prepend(value)
        if @head.nil?
          add_first_node(value)
        else
          temp = Node.new(value)
          temp.next = @head
          @head = temp
        end
      end

      def count
        temp = @head
        count = 0
        until temp.nil?
          temp = temp.next
          count += 1
        end
        count
      end
    
      def at(index)
        temp = @head
        index.times do
          temp = temp.next
        end
        temp
      end
    
      def pop
        remove_at(count - 1)
      end
    
      def contains?(value)
        temp = @head
        until temp.nil?
          return true if temp.data == value
    
          temp = temp.next
        end
        false
      end
    
      def find(value)
        temp = @head
        count = 0
        until temp.nil?
          return count if temp.data == value
    
          temp = temp.next
          count += 1
        end
      end
    
      def to_s
        temp = @head
        until temp.nil?
          print "(#{temp.data}) -> "
          temp = temp.next
        end
        print('nil')
      end
    
      def insert_at(value, index)
        cur = nil
        prev = nil
        if index.zero?
          prepend(value)
        else
          cur = @head
          index.times do
            prev = cur
            cur = cur.next
          end
          prev.next = Node.new(value)
          prev.next.next = cur
          @tail = prev.next if cur.nil? # when value is to be added to the end of the linked list
        end
      end
    
      def remove_at(index)
        return if index > count - 1 || index.negative?
    
        removed_elem = at(index)
        prev = nil
        if index.zero?
          @head = @head.next
          @tail = head if count == 1
        else
          prev = at(index - 1)
          prev.next = at(index + 1)
        end
        @tail = prev if index == count
        removed_elem.data
      end
    end
 


end



class Node

    attr_accessor :value, :next

    def initialize(value = nil)
        @value = value
        @next_node = nil
    end
end


