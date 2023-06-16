
@kwdef struct UDEparameters
    sensealg::SciMLBase.AbstractAdjointSensitivityAlgorithm{CS,AD,FDT}
    optimization_method::String
    loss_type::String
    scale_loss::Bool
end

"""
    UDEparameters(;
        sensealg::SciMLBase.AbstractAdjointSensitivityAlgorithm{CS,AD,FDT} = InterpolatingAdjoint(autojacvec=ReverseDiffVJP(true)),
        optimization_method::String = "AD+AD",
        loss_type::String = "V",
        scale_loss::Bool = true
        )
Initialize the parameters for the training of the UDE.
Keyword arguments
=================
    - `sensealg`: Sensitivity algorithm from SciMLSensitivity.jl to be used.
    - `optimization_method`: Optimization method for the UDE.
    - `loss_type`: Type of loss function to be used
    - `scale_loss`: Determines if the loss function should be scaled or not.
"""
function UDEparameters(;
            sensealg::SciMLBase.AbstractAdjointSensitivityAlgorithm{CS,AD,FDT} = InterpolatingAdjoint(autojacvec=ReverseDiffVJP(true)),
            optimization_method::String = "AD+AD",
            loss_type::String = "V",
            scale_loss::Bool = true
            )
    # Verify that the optimization method is correct
    @assert ((optimization_method == "AD+AD") || (optimization_method == "AD+Diff")) "Wrong optimization method! Needs to be either `AD+AD` or `AD+Diff`"

    # Build the solver parameters based on input values
    UDE_parameters = UDEparameters(sensealg, optimization_method,
                                    loss_type, scale_loss)

    return UDE_parameters
end