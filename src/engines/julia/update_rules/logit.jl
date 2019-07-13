export ruleVBLogitOut, ruleVBLogitIn1, ruleVBLogitXi

function ruleVBLogitOut(marg_out::Any, 
                        marg_in1::ProbabilityDistribution{Univariate}, 
                        marg_xi::ProbabilityDistribution{Univariate, PointMass})

    return Message(Univariate, Bernoulli, p=logisticSigmoid(unsafeMean(marg_in1)))
end

function ruleVBLogitIn1(marg_out::ProbabilityDistribution{Univariate}, 
                        marg_in1::Any, 
                        marg_xi::ProbabilityDistribution{Univariate, PointMass})
    
    xi_hat = marg_xi.params[:m]
    
    return Message(Univariate, GaussianWeightedMeanPrecision, xi=0.5*(unsafeMean(marg_out) - 0.5), w=logisticLambda(xi_hat))
end

function ruleVBLogitXi(marg_out::ProbabilityDistribution{Univariate}, 
                       marg_in1::ProbabilityDistribution{Univariate}, 
                       marg_xi::Any)
    
    return Message(Univariate, PointMass, m=sqrt(unsafeMean(marg_in1)^2 + unsafeCov(marg_in1)))
end