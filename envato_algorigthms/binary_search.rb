#O(logN)
def bsearch(arr, key)
  min = 0; max = arr.size-1;
  while min <= max
    mid = min + (max - min) / 2  #plus min!!!!!!!!!!!!
    return mid if key == arr[mid]
    key < arr[mid] ? max = mid - 1 : min = mid + 1
  end
  return -1
end

ar = [23, 45, 67, 89, 123, 568]
p bsearch(ar, 23) #0
p bsearch(ar, 123) #4
p bsearch(ar, 120) #-1

