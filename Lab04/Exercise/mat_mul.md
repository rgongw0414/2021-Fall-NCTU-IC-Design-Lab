## Forward
* Input data 

$S = [s_0,s_1,s_2,s_3]$, which is a 1x4 matrix

* Input weights $W^1$, where

$$ W^1 = 
\left[ \begin{matrix}
w^1_0 & w^1_4 & w^1_8    \\
w^1_1 & w^1_5 & w^1_9    \\
w^1_2 & w^1_6 & w^1_{10} \\
w^1_3 & w^1_7 & w^1_{11}
\end{matrix} \right]_{4\times3} \tag{1} $$

* Input Layer Output (Hidden Layer Input)

$$ S*W^1 = 
\left[ \begin{matrix}
        s0*w^1_0 + s1*w^1_1 \ + s2*w^1_2 + s3*w^1_3   \\  
        s0*w^1_4 + s1*w^1_5 \ + s2*w^1_6 + s3*w^1_7   \\
\ \ \ \ s0*w^1_8   \ + s1*w^1_9 + s2*w^1_{10} + s3*w^1_{11}  \end{matrix} \right]^T_{3\times4} = 
    \left[ \begin{matrix} 
    h^1_0 \\
    h^1_1 \\ 
    h^1_2 \\
    \end{matrix} \right]^T_{3\times1} = 
        \left[ \begin{matrix} 
        h^1_0 & h^1_1 & h^1_2
        \end{matrix} \right]_{1\times3}, where $$

$$  h^1_0 = s0*w^1_0 + s1*w^1_1 \ + s2*w^1_2 + s3*w^1_3 \\
    h^1_1 = s0*w^1_4 + s1*w^1_5 \ + s2*w^1_6 + s3*w^1_7 \\
\ \ h^1_2 = s0*w^1_8 + s1*w^1_9 \ + s2*w^1_{10} + s3*w^1_{11} \tag{2} $$

* Activation function

$$      y^1_0 = ReLU(h^1_0) = ReLU(s0*w^1_0 + s1*w^1_1 \ + s2*w^1_2 + s3*w^1_3) \\
        y^1_1 = ReLU(h^1_1) = ReLU(s0*w^1_4 + s1*w^1_5 \ + s2*w^1_6 + s3*w^1_7)  \\
\ \ \ \ y^1_2 = ReLU(h^1_2) = ReLU(s0*w^1_8 + s1*w^1_9 \ + s2*w^1_{10} + s3*w^1_{11}) $$

* Output Layer

$$ y^2_0 = y^1_0*w^2_{0} + y^1_1*w^2_{1} + y^1_2*w^2_{2} = h^2_0 $$
$$ y^2_0 = ReLU(s0*w^1_{0} + s1*w^1_{1} + s2*w^1_{2}  + s3*w^1_{3})  * w^2_{0} +  \\
\ \ \ \ \ \ \ \ ReLU(s0*w^1_{4} + s1*w^1_{5} + s2*w^1_{6}  + s3*w^1_{7})  * w^2_{1} +  \\
\ \ \ \ \ \ ReLU(s0*w^1_{8} + s1*w^1_{9} + s2*w^1_{10} + s3*w^1_{11}) * w^2_{2} $$

## Backward
* Output Layer Loss

$$  d^2_0 = y^2_0 - t_0 $$

* Hidden Layer Loss

$$  d^{1}_0 = ReLU(h^1_0)' * w^2_{0} * d^2_0 \\
    d^{1}_1 = ReLU(h^1_1)' * w^2_{1} * d^2_1 \\
    d^{1}_2 = ReLU(h^1_2)' * w^2_{2} * d^2_2 $$

## Update
* Hidden Layer

$$  w^2_{0} = w^2_{0} - LR * d^2_0 * y^1_0 \\
    w^2_{1} = w^2_{1} - LR * d^2_1 * y^1_1 \\
    w^2_{2} = w^2_{2} - LR * d^2_2 * y^1_2 $$

* Input Layer

$$  w^1_{0} = w^1_{0} - LR * d^1_0 * s0 \\
    w^1_{1} = w^1_{1} - LR * d^1_0 * s1 \\
    w^1_{2} = w^1_{2} - LR * d^1_0 * s2 \\
    w^1_{3} = w^1_{3} - LR * d^1_0 * s3  $$

$$  w^1_{4} = w^1_{4} - LR * d^1_1 * s0 \\
    w^1_{5} = w^1_{5} - LR * d^1_1 * s1 \\
    w^1_{6} = w^1_{6} - LR * d^1_1 * s2 \\
    w^1_{7} = w^1_{7} - LR * d^1_1 * s3 $$

$$  w^1_{8}  = w^1_{8}  - LR * d^1_2 * s0 \\
    w^1_{9}  = w^1_{9}  - LR * d^1_2 * s1 \\
    w^1_{10} = w^1_{10} - LR * d^1_2 * s2 \\
    w^1_{11} = w^1_{11} - LR * d^1_2 * s3 $$

