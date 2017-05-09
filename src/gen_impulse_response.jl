include("./make_column.jl")

function gen_impulse_response(Freq,F)
   # sanitize input and make a frequency interval variable
   if length(size(Freq)) > 1 || length(size(Freq)) > 2
      error("Freq and F both need to be vectors.")
   end
   deltaF = Freq[2]-Freq[1];

   # Make the time array.
   timePts = linspace(0,1/deltaF,length(Freq)); # generate time array

   # Generate the impulse response by inverting S11*e^{1i*2*pi*f*t)
   #
   #
   # Approach 1: No parallelization
   ###################################################################
   #exp_array = exp(1i*2*pi*Freq*times.'); # times indexes columns, doubleFreq indexes rows
   #impulse_response = deltaF * exp_array.' * S11 * 1;
   ##################################################################
   #
   #
   # Approach 2: Parallelization
   ##################################################################

   # make array of indices roughly corresponding to 5#, 10#,..., 95# of
   # timePts

   f = zeros(length(timePts),1);

   # parfor t = 1:length(timePts)
   #    f(t,1) = deltaF *  exp(1i*2*pi*Freq*timePts(t)).' * F;
   # end
   f = deltaF * length(timePts) * ifft(F);

   return (timePts, f)
end
