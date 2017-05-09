# SParametersToTimeDomain

This package facilitates the conversion of scattering parameters into
time-domain voltage signals.

As of this authoring, only one function is exported:
`s_parameter_to_time_domain(::Array{Float64,1},::Array{Float64,1}`. This
function accepts two location-based arguments. The first argument is a vector of
frequencies, in Hertz. The second is a vector of complex amplitudes. It may be
necessary to convert from magnitude-phase paired data or from real-imaginary
paired data. In that case, consider the following conversions below.

The below assumes that `Sij_mag` is in decibels (the factor of 20 exists because
scattering parameters are voltage-valued quantities) and `Sij_phase` is in
degrees.
```julia
Sij = 10.^(Sij_mag/20).*e.^(im*Sij_phase*pi/180)
```

```julia
Sij = (Sij_real.^2 + Sij_imag.^2).^(1/2).*e.^(im*angle(S_real+im*S_imag))
```
