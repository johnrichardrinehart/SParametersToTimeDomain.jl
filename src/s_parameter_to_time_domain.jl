using DSP
include("extend_to_dc.jl")
include("make_conjugate_symmetric.jl")
include("gen_impulse_response.jl")
include("clean_array.jl")
include("gen_step_response.jl")

function s_parameter_to_time_domain(freqs,s11; kb_beta=6)
   # function [timePts, step_response] = SParams2TDR(Freq,S11,varargin)
   # SParams2TDR takes in measured frequency data and outputs a step response

   # prepare s parameter for transformation
   res = extend_to_dc(freqs,s11);
   FreqToDC = res[1]; S11toDC = res[2]
   doubleS11 = make_conjugate_symmetric(S11toDC); # runs from DC -> - deltaF
   doubleFreq = vcat(FreqToDC, -flipdim(FreqToDC[2:end],1));

   filter_vals = kaiser(length(doubleS11),kb_beta);

   doubleS11 = flipdim(fftshift(filter_vals),1) .* doubleS11;
   res = gen_impulse_response(doubleFreq, doubleS11);
   timePts = res[1]; imp_response = res[2];
   # Generate impulse response
   imp_response = clean_array(imp_response,threshold=1e-6);
   # Check if it's real
   if ~isreal(imp_response)
      warn("Impulse response is not real. Results may not make sense.");
   end
   # Generate step response
   res = gen_step_response(timePts, imp_response);
   step_response = res[2]

   # Convert the step response to a vector of floats (if possible)
   step_response = convert(Vector{Float64}, step_response)
   println("Step response type: ", typeof(step_response))
   return (timePts, step_response)
end
