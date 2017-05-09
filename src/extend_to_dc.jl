function extend_to_dc(inFreqs, inArray)
   deltaf = inFreqs[2]-inFreqs[1]
   numextrapts = round(Int, inFreqs[1]/deltaf)
   phasechange = angle(inArray[1])/numextrapts # amount by which to reverse the phase (in radians)

   # extend the inArray down to DC, rolling down the phase
   extrapts = zeros(Complex64,numextrapts)
   for j = 1:numextrapts
      extrapts[numextrapts-j+1] = inArray[1]*e^(-im*j*phasechange)
   end
   extrapts[1,1] = abs(extrapts[1,1]) # (imag(inArray(1,1)) < 10^-12) -> 0
   outArray = vcat(extrapts, inArray)

   # extend the Freqsuencies
   newFreqs = (inFreqs[1]-numextrapts*deltaf:deltaf:inFreqs[1]-deltaf)
   outFreqs = vcat(newFreqs, inFreqs)
   return (outFreqs, outArray)
end
