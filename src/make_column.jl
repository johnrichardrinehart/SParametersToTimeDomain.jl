function make_column(array)
   if length(size(array)) == 1
      outArray = array.';
   else
      error("Must be array.");
   end
   return outArray
end
