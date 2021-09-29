def bubble_sort(array)
    n = array.length
    loop do 
      swapped = false
      (n-1).times do |i|
        if array[i] > array[i + 1]
          array[i], array[i + 1] = array[i + 1], array[i]
          swapped = true
        end
      end
    break if not swapped
    end
  
    array
  end
  
  arr = [4,3,78,2,0,2]
  p bubble_sort(arr)