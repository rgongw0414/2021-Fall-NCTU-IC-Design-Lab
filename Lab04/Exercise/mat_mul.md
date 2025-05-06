## ANN Structure
![ANN Structure](ANN.png)

* Input layer weights
  * {$w^1_0$, $w^1_1$, $w^1_2$, $w^1_3$}: Weights for $h^1_0$ (Hidden layer neurons)
  * {$w^1_4$, $w^1_5$, $w^1_6$, $w^1_7$}: Weights for $h^1_1$
  * {$w^1_8$, $w^1_9$, $w^1_{10}$, $w^1_{11}$}: Weights for $h^1_2$

* Hidden layer weights
  * {$w^2_0$, $w^2_1$, $w^2_2$}: Weights for $h^2_0$ (Output layer neuron)

* Errors (loss or distance b/w target and neuron)
  * $\delta^2_0$: Output layer error, aka, loss

## Forward
* Input data $S = [s_0,s_1,s_2,s_3]_{1\times4}$

* Input weights $W^1, where$

```math
W^1 = 
\begin{bmatrix}
w^1_0 & w^1_4 & w^1_8    \\
w^1_1 & w^1_5 & w^1_9    \\
w^1_2 & w^1_6 & w^1_{10} \\
w^1_3 & w^1_7 & w^1_{11}
\end{bmatrix}_{4\times3}
```

* Input Layer Output (Hidden Layer Input)

```math
 S*W^1 = 
\begin{bmatrix}
        s_0*w^1_0 + s_1*w^1_1 \ + s_2*w^1_2 + s_3*w^1_3   \\  
        s_0*w^1_4 + s_1*w^1_5 \ + s_2*w^1_6 + s_3*w^1_7   \\
\ \ \ \ s_0*w^1_8   \ + s_1*w^1_9 + s_2*w^1_{10} + s_3*w^1_{11}  \end{bmatrix}^T_{3\times4} = 
    \begin{bmatrix} 
    h^1_0 \\
    h^1_1 \\ 
    h^1_2 \\
    \end{bmatrix}^T_{3\times1} = 
        \begin{bmatrix} 
        h^1_0 & h^1_1 & h^1_2
        \end{bmatrix}_{1\times3}, where 
```

```math
\begin{array}{c}
h^1_0 = s_0*w^1_0 + s_1*w^1_1 \ + s_2*w^1_2 + s_3*w^1_3 \\
    h^1_1 = s_0*w^1_4 + s_1*w^1_5 \ + s_2*w^1_6 + s_3*w^1_7 \\
\ \ h^1_2 = s_0*w^1_8 + s_1*w^1_9 \ + s_2*w^1_{10} + s_3*w^1_{11} 
\end{array}
```

* Activation function

```math
\begin{array}{c}
        y^1_0 = ReLU(h^1_0) = ReLU(s_0*w^1_0 + s_1*w^1_1 \ + s_2*w^1_2 + s_3*w^1_3) \\
        y^1_1 = ReLU(h^1_1) = ReLU(s_0*w^1_4 + s_1*w^1_5 \ + s_2*w^1_6 + s_3*w^1_7)  \\
\ \ \ \ y^1_2 = ReLU(h^1_2) = ReLU(s_0*w^1_8 + s_1*w^1_9 \ + s_2*w^1_{10} + s_3*w^1_{11})
\end{array}
```

* Output Layer

```math 
y^2_0 = (y^1_0*w^2_{0} + y^1_1*w^2_{1} + y^1_2*w^2_{2}) = h^2_0 
```

```math
\begin{array}{c}
y^2_0 = ReLU(s_0*w^1_{0} + s_1*w^1_{1} + s_2*w^1_{2}  + s_3*w^1_{3})  * w^2_{0} +  \\
\ \ \ \ \ \ \ \ \ ReLU(s_0*w^1_{4} + s_1*w^1_{5} + s_2*w^1_{6}  + s_3*w^1_{7})  * w^2_{1} +  \\
\ \ \ \ \ \ \ \ ReLU(s_0*w^1_{8} + s_1*w^1_{9} + s_2*w^1_{10} + s_3*w^1_{11}) * w^2_{2} 
\end{array}
```

## Backward
* Output Layer Loss

$$  \delta^2_0 = y^2_0 - t_0 $$

* Hidden Layer Loss

```math
\begin{array}{c}
    \delta^{1}_0 = ReLU(h^1_0)' * w^2_{0} * \delta^2_0 \\
    \delta^{1}_1 = ReLU(h^1_1)' * w^2_{1} * \delta^2_0 \\
    \delta^{1}_2 = ReLU(h^1_2)' * w^2_{2} * \delta^2_0 
\end{array}
```

## Update
* Hidden Layer

```math
\begin{array}{c}
    w^2_{0} = w^2_{0} - LR * \delta^2_0 * y^1_0 \\
    w^2_{1} = w^2_{1} - LR * \delta^2_0 * y^1_1 \\
    w^2_{2} = w^2_{2} - LR * \delta^2_0 * y^1_2  
\end{array}
```

* Input Layer

```math
\begin{array}{c}
    w^1_{0} = w^1_{0} - LR * \delta^1_0 * s_0 \\
    w^1_{1} = w^1_{1} - LR * \delta^1_0 * s_1 \\
    w^1_{2} = w^1_{2} - LR * \delta^1_0 * s_2 \\
    w^1_{3} = w^1_{3} - LR * \delta^1_0 * s_3  
\end{array}
```

```math
\begin{array}{c}
    w^1_{4} = w^1_{4} - LR * \delta^1_1 * s_0 \\
    w^1_{5} = w^1_{5} - LR * \delta^1_1 * s_1 \\
    w^1_{6} = w^1_{6} - LR * \delta^1_1 * s_2 \\
    w^1_{7} = w^1_{7} - LR * \delta^1_1 * s_3  
\end{array}
```

```math
\begin{array}{c}
    w^1_{8}  = w^1_{8}  - LR * \delta^1_2 * s_0 \\
    w^1_{9}  = w^1_{9}  - LR * \delta^1_2 * s_1 \\
    w^1_{10} = w^1_{10} - LR * \delta^1_2 * s_2 \\
    w^1_{11} = w^1_{11} - LR * \delta^1_2 * s_3 
\end{array}
```

