function gen_step_response(timePts,impulse_response)
   # Designed to be called by genImpResponse
   deltaT = timePts[2]-timePts[1]
   step_response = deltaT*cumsum(impulse_response)
   return (timePts, step_response)
end
