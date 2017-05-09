function make_conjugate_symmetric(array)
# conjSymmetric = makeConjugateSymmetric (array)
# array is an array such that imag(array(1)) == 0
# conjSymmetric is a conjugate symmetric array constructed from array

if length(size(array)) > 1
   error("array must be a vector")
end

conjSymmetric = vcat(array, flipdim(conj(array[2:end]),1)); # compatible with FFT
# if mod(length(conjSymmetric),2) ~= 1
#    error('array does not have an odd number of indices');
# end
#
# N = (length(conjSymmetric)-1)/2; # length(array) -   1
#
# first_half = conjSymmetric(1:N);
# second_half = conjSymmetric(N+2:end);
# if any(first_half - conj(flipud(second_half)))
#    error('array is not conjugate symmetric.')
# end

return conjSymmetric

end
