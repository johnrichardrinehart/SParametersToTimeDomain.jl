function clean_array(a; threshold=1e-10)
   # cleanArray removes the negligible real and imaginary parts from an array.
   # varargin allows special key-value pairs to be used to set how cleanArray
   # operates
   # Optional parameters: 'threshold' (double); specifies the maximum ratio of
   # imag/real or real/imag before value is kept [default: 1e-10]

   cleanedArray = zeros(length(a),1); # init output

   realOverImag = abs(real(a)./imag(a));
   imagOverReal = abs(imag(a)./real(a));
   realTooSmall = map( x -> x - threshold < 0, realOverImag)
   imagTooSmall = map( x -> x - threshold < 0, imagOverReal)
   neitherTooSmall = ~(imagTooSmall | realTooSmall);
   cleanedArray = im*imag(a).*realTooSmall +
                  real(a).*imagTooSmall +
                  a.*neitherTooSmall;
   return cleanedArray
end
