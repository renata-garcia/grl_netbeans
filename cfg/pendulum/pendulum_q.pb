
6
dense_1_inputPlaceholder*
dtype0*
shape: 
Q
dense_1/random_uniform/shapeConst*
dtype0*
valueB"   d   
G
dense_1/random_uniform/minConst*
dtype0*
valueB
 *Ū%wž
G
dense_1/random_uniform/maxConst*
dtype0*
valueB
 *Ū%w>

$dense_1/random_uniform/RandomUniformRandomUniformdense_1/random_uniform/shape*
dtype0*
seed2˛Īs*
seedą˙å)*
T0
b
dense_1/random_uniform/subSubdense_1/random_uniform/maxdense_1/random_uniform/min*
T0
l
dense_1/random_uniform/mulMul$dense_1/random_uniform/RandomUniformdense_1/random_uniform/sub*
T0
^
dense_1/random_uniformAdddense_1/random_uniform/muldense_1/random_uniform/min*
T0
`
dense_1/kernelVariable*
dtype0*
shape
:d*
	container *
shared_name 

dense_1/kernel/AssignAssigndense_1/kerneldense_1/random_uniform*
validate_shape(*!
_class
loc:@dense_1/kernel*
use_locking(*
T0
[
dense_1/kernel/readIdentitydense_1/kernel*!
_class
loc:@dense_1/kernel*
T0
>
dense_1/ConstConst*
dtype0*
valueBd*    
Z
dense_1/biasVariable*
dtype0*
shape:d*
	container *
shared_name 

dense_1/bias/AssignAssigndense_1/biasdense_1/Const*
validate_shape(*
_class
loc:@dense_1/bias*
use_locking(*
T0
U
dense_1/bias/readIdentitydense_1/bias*
_class
loc:@dense_1/bias*
T0
k
dense_1/MatMulMatMuldense_1_inputdense_1/kernel/read*
transpose_b( *
transpose_a( *
T0
]
dense_1/BiasAddBiasAdddense_1/MatMuldense_1/bias/read*
T0*
data_formatNHWC
3
activation_1/TanhTanhdense_1/BiasAdd*
T0
Q
dense_2/random_uniform/shapeConst*
dtype0*
valueB"d      
G
dense_2/random_uniform/minConst*
dtype0*
valueB
 *<yž
G
dense_2/random_uniform/maxConst*
dtype0*
valueB
 *<y>

$dense_2/random_uniform/RandomUniformRandomUniformdense_2/random_uniform/shape*
dtype0*
seed2âįŅ*
seedą˙å)*
T0
b
dense_2/random_uniform/subSubdense_2/random_uniform/maxdense_2/random_uniform/min*
T0
l
dense_2/random_uniform/mulMul$dense_2/random_uniform/RandomUniformdense_2/random_uniform/sub*
T0
^
dense_2/random_uniformAdddense_2/random_uniform/muldense_2/random_uniform/min*
T0
`
dense_2/kernelVariable*
dtype0*
shape
:d*
	container *
shared_name 

dense_2/kernel/AssignAssigndense_2/kerneldense_2/random_uniform*
validate_shape(*!
_class
loc:@dense_2/kernel*
use_locking(*
T0
[
dense_2/kernel/readIdentitydense_2/kernel*!
_class
loc:@dense_2/kernel*
T0
>
dense_2/ConstConst*
dtype0*
valueB*    
Z
dense_2/biasVariable*
dtype0*
shape:*
	container *
shared_name 

dense_2/bias/AssignAssigndense_2/biasdense_2/Const*
validate_shape(*
_class
loc:@dense_2/bias*
use_locking(*
T0
U
dense_2/bias/readIdentitydense_2/bias*
_class
loc:@dense_2/bias*
T0
o
dense_2/MatMulMatMulactivation_1/Tanhdense_2/kernel/read*
transpose_b( *
transpose_a( *
T0
]
dense_2/BiasAddBiasAdddense_2/MatMuldense_2/bias/read*
T0*
data_formatNHWC
E
iterations/initial_valueConst*
dtype0*
valueB
 *    
T

iterationsVariable*
dtype0*
shape: *
	container *
shared_name 

iterations/AssignAssign
iterationsiterations/initial_value*
validate_shape(*
_class
loc:@iterations*
use_locking(*
T0
O
iterations/readIdentity
iterations*
_class
loc:@iterations*
T0
=
lr/initial_valueConst*
dtype0*
valueB
 *
×#<
L
lrVariable*
dtype0*
shape: *
	container *
shared_name 
r
	lr/AssignAssignlrlr/initial_value*
validate_shape(*
_class
	loc:@lr*
use_locking(*
T0
7
lr/readIdentitylr*
_class
	loc:@lr*
T0
C
momentum/initial_valueConst*
dtype0*
valueB
 *    
R
momentumVariable*
dtype0*
shape: *
	container *
shared_name 

momentum/AssignAssignmomentummomentum/initial_value*
validate_shape(*
_class
loc:@momentum*
use_locking(*
T0
I
momentum/readIdentitymomentum*
_class
loc:@momentum*
T0
@
decay/initial_valueConst*
dtype0*
valueB
 *    
O
decayVariable*
dtype0*
shape: *
	container *
shared_name 
~
decay/AssignAssigndecaydecay/initial_value*
validate_shape(*
_class

loc:@decay*
use_locking(*
T0
@

decay/readIdentitydecay*
_class

loc:@decay*
T0
D
activation_2_sample_weightsPlaceholder*
dtype0*
shape: 
<
activation_2_targetPlaceholder*
dtype0*
shape: 
9
subSubdense_2/BiasAddactivation_2_target*
T0

SquareSquaresub*
T0
@
Mean/reduction_indicesConst*
dtype0*
value	B :
R
MeanMeanSquareMean/reduction_indices*
T0*
	keep_dims( *

Tidx0
A
Mean_1/reduction_indicesConst*
dtype0*
valueB 
T
Mean_1MeanMeanMean_1/reduction_indices*
T0*
	keep_dims( *

Tidx0
8
mulMulMean_1activation_2_sample_weights*
T0
7

NotEqual/yConst*
dtype0*
valueB
 *    
F
NotEqualNotEqualactivation_2_sample_weights
NotEqual/y*
T0
.
CastCastNotEqual*

DstT0*

SrcT0

3
ConstConst*
dtype0*
valueB: 
A
Mean_2MeanCastConst*
T0*
	keep_dims( *

Tidx0
 
divDivmulMean_2*
T0
5
Const_1Const*
dtype0*
valueB: 
B
Mean_3MeandivConst_1*
T0*
	keep_dims( *

Tidx0
4
mul_1/xConst*
dtype0*
valueB
 *  ?
&
mul_1Mulmul_1/xMean_3*
T0
R
gradients/ShapeConst*
dtype0*
_class

loc:@mul_1*
valueB 
V
gradients/ConstConst*
dtype0*
_class

loc:@mul_1*
valueB
 *  ?
[
gradients/FillFillgradients/Shapegradients/Const*
_class

loc:@mul_1*
T0
]
gradients/mul_1_grad/ShapeConst*
dtype0*
_class

loc:@mul_1*
valueB 
_
gradients/mul_1_grad/Shape_1Const*
dtype0*
_class

loc:@mul_1*
valueB 
 
*gradients/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_1_grad/Shapegradients/mul_1_grad/Shape_1*
_class

loc:@mul_1*
T0
Z
gradients/mul_1_grad/mulMulgradients/FillMean_3*
_class

loc:@mul_1*
T0
Ĩ
gradients/mul_1_grad/SumSumgradients/mul_1_grad/mul*gradients/mul_1_grad/BroadcastGradientArgs*
_class

loc:@mul_1*
T0*
	keep_dims( *

Tidx0

gradients/mul_1_grad/ReshapeReshapegradients/mul_1_grad/Sumgradients/mul_1_grad/Shape*
_class

loc:@mul_1*
T0*
Tshape0
]
gradients/mul_1_grad/mul_1Mulmul_1/xgradients/Fill*
_class

loc:@mul_1*
T0
Ģ
gradients/mul_1_grad/Sum_1Sumgradients/mul_1_grad/mul_1,gradients/mul_1_grad/BroadcastGradientArgs:1*
_class

loc:@mul_1*
T0*
	keep_dims( *

Tidx0

gradients/mul_1_grad/Reshape_1Reshapegradients/mul_1_grad/Sum_1gradients/mul_1_grad/Shape_1*
_class

loc:@mul_1*
T0*
Tshape0
l
#gradients/Mean_3_grad/Reshape/shapeConst*
dtype0*
_class
loc:@Mean_3*
valueB:

gradients/Mean_3_grad/ReshapeReshapegradients/mul_1_grad/Reshape_1#gradients/Mean_3_grad/Reshape/shape*
_class
loc:@Mean_3*
T0*
Tshape0
]
gradients/Mean_3_grad/ShapeShapediv*
out_type0*
T0*
_class
loc:@Mean_3

gradients/Mean_3_grad/TileTilegradients/Mean_3_grad/Reshapegradients/Mean_3_grad/Shape*

Tmultiples0*
_class
loc:@Mean_3*
T0
_
gradients/Mean_3_grad/Shape_1Shapediv*
out_type0*
T0*
_class
loc:@Mean_3
a
gradients/Mean_3_grad/Shape_2Const*
dtype0*
_class
loc:@Mean_3*
valueB 
d
gradients/Mean_3_grad/ConstConst*
dtype0*
_class
loc:@Mean_3*
valueB: 

gradients/Mean_3_grad/ProdProdgradients/Mean_3_grad/Shape_1gradients/Mean_3_grad/Const*
_class
loc:@Mean_3*
T0*
	keep_dims( *

Tidx0
f
gradients/Mean_3_grad/Const_1Const*
dtype0*
_class
loc:@Mean_3*
valueB: 
Ŗ
gradients/Mean_3_grad/Prod_1Prodgradients/Mean_3_grad/Shape_2gradients/Mean_3_grad/Const_1*
_class
loc:@Mean_3*
T0*
	keep_dims( *

Tidx0
d
gradients/Mean_3_grad/Maximum/yConst*
dtype0*
_class
loc:@Mean_3*
value	B :

gradients/Mean_3_grad/MaximumMaximumgradients/Mean_3_grad/Prod_1gradients/Mean_3_grad/Maximum/y*
_class
loc:@Mean_3*
T0

gradients/Mean_3_grad/floordivDivgradients/Mean_3_grad/Prodgradients/Mean_3_grad/Maximum*
_class
loc:@Mean_3*
T0
u
gradients/Mean_3_grad/CastCastgradients/Mean_3_grad/floordiv*

DstT0*
_class
loc:@Mean_3*

SrcT0

gradients/Mean_3_grad/truedivDivgradients/Mean_3_grad/Tilegradients/Mean_3_grad/Cast*
_class
loc:@Mean_3*
T0
W
gradients/div_grad/ShapeShapemul*
out_type0*
T0*
_class

loc:@div
[
gradients/div_grad/Shape_1Const*
dtype0*
_class

loc:@div*
valueB 

(gradients/div_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/div_grad/Shapegradients/div_grad/Shape_1*
_class

loc:@div*
T0
i
gradients/div_grad/truedivDivgradients/Mean_3_grad/truedivMean_2*
_class

loc:@div*
T0
Ą
gradients/div_grad/SumSumgradients/div_grad/truediv(gradients/div_grad/BroadcastGradientArgs*
_class

loc:@div*
T0*
	keep_dims( *

Tidx0

gradients/div_grad/ReshapeReshapegradients/div_grad/Sumgradients/div_grad/Shape*
_class

loc:@div*
T0*
Tshape0
C
gradients/div_grad/NegNegmul*
_class

loc:@div*
T0
L
gradients/div_grad/SquareSquareMean_2*
_class

loc:@div*
T0
w
gradients/div_grad/truediv_1Divgradients/div_grad/Neggradients/div_grad/Square*
_class

loc:@div*
T0
{
gradients/div_grad/mulMulgradients/Mean_3_grad/truedivgradients/div_grad/truediv_1*
_class

loc:@div*
T0
Ą
gradients/div_grad/Sum_1Sumgradients/div_grad/mul*gradients/div_grad/BroadcastGradientArgs:1*
_class

loc:@div*
T0*
	keep_dims( *

Tidx0

gradients/div_grad/Reshape_1Reshapegradients/div_grad/Sum_1gradients/div_grad/Shape_1*
_class

loc:@div*
T0*
Tshape0
Z
gradients/mul_grad/ShapeShapeMean_1*
out_type0*
T0*
_class

loc:@mul
q
gradients/mul_grad/Shape_1Shapeactivation_2_sample_weights*
out_type0*
T0*
_class

loc:@mul

(gradients/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_grad/Shapegradients/mul_grad/Shape_1*
_class

loc:@mul*
T0
w
gradients/mul_grad/mulMulgradients/div_grad/Reshapeactivation_2_sample_weights*
_class

loc:@mul*
T0

gradients/mul_grad/SumSumgradients/mul_grad/mul(gradients/mul_grad/BroadcastGradientArgs*
_class

loc:@mul*
T0*
	keep_dims( *

Tidx0

gradients/mul_grad/ReshapeReshapegradients/mul_grad/Sumgradients/mul_grad/Shape*
_class

loc:@mul*
T0*
Tshape0
d
gradients/mul_grad/mul_1MulMean_1gradients/div_grad/Reshape*
_class

loc:@mul*
T0
Ŗ
gradients/mul_grad/Sum_1Sumgradients/mul_grad/mul_1*gradients/mul_grad/BroadcastGradientArgs:1*
_class

loc:@mul*
T0*
	keep_dims( *

Tidx0

gradients/mul_grad/Reshape_1Reshapegradients/mul_grad/Sum_1gradients/mul_grad/Shape_1*
_class

loc:@mul*
T0*
Tshape0
^
gradients/Mean_1_grad/ShapeShapeMean*
out_type0*
T0*
_class
loc:@Mean_1
_
gradients/Mean_1_grad/SizeConst*
dtype0*
_class
loc:@Mean_1*
value	B :
z
gradients/Mean_1_grad/addAddMean_1/reduction_indicesgradients/Mean_1_grad/Size*
_class
loc:@Mean_1*
T0
{
gradients/Mean_1_grad/modModgradients/Mean_1_grad/addgradients/Mean_1_grad/Size*
_class
loc:@Mean_1*
T0
f
gradients/Mean_1_grad/Shape_1Const*
dtype0*
_class
loc:@Mean_1*
valueB: 
f
!gradients/Mean_1_grad/range/startConst*
dtype0*
_class
loc:@Mean_1*
value	B : 
f
!gradients/Mean_1_grad/range/deltaConst*
dtype0*
_class
loc:@Mean_1*
value	B :
­
gradients/Mean_1_grad/rangeRange!gradients/Mean_1_grad/range/startgradients/Mean_1_grad/Size!gradients/Mean_1_grad/range/delta*
_class
loc:@Mean_1*

Tidx0
e
 gradients/Mean_1_grad/Fill/valueConst*
dtype0*
_class
loc:@Mean_1*
value	B :

gradients/Mean_1_grad/FillFillgradients/Mean_1_grad/Shape_1 gradients/Mean_1_grad/Fill/value*
_class
loc:@Mean_1*
T0
Ō
#gradients/Mean_1_grad/DynamicStitchDynamicStitchgradients/Mean_1_grad/rangegradients/Mean_1_grad/modgradients/Mean_1_grad/Shapegradients/Mean_1_grad/Fill*
_class
loc:@Mean_1*
T0*
N
d
gradients/Mean_1_grad/Maximum/yConst*
dtype0*
_class
loc:@Mean_1*
value	B :

gradients/Mean_1_grad/MaximumMaximum#gradients/Mean_1_grad/DynamicStitchgradients/Mean_1_grad/Maximum/y*
_class
loc:@Mean_1*
T0

gradients/Mean_1_grad/floordivDivgradients/Mean_1_grad/Shapegradients/Mean_1_grad/Maximum*
_class
loc:@Mean_1*
T0

gradients/Mean_1_grad/ReshapeReshapegradients/mul_grad/Reshape#gradients/Mean_1_grad/DynamicStitch*
_class
loc:@Mean_1*
T0*
Tshape0

gradients/Mean_1_grad/TileTilegradients/Mean_1_grad/Reshapegradients/Mean_1_grad/floordiv*

Tmultiples0*
_class
loc:@Mean_1*
T0
`
gradients/Mean_1_grad/Shape_2ShapeMean*
out_type0*
T0*
_class
loc:@Mean_1
b
gradients/Mean_1_grad/Shape_3ShapeMean_1*
out_type0*
T0*
_class
loc:@Mean_1
d
gradients/Mean_1_grad/ConstConst*
dtype0*
_class
loc:@Mean_1*
valueB: 

gradients/Mean_1_grad/ProdProdgradients/Mean_1_grad/Shape_2gradients/Mean_1_grad/Const*
_class
loc:@Mean_1*
T0*
	keep_dims( *

Tidx0
f
gradients/Mean_1_grad/Const_1Const*
dtype0*
_class
loc:@Mean_1*
valueB: 
Ŗ
gradients/Mean_1_grad/Prod_1Prodgradients/Mean_1_grad/Shape_3gradients/Mean_1_grad/Const_1*
_class
loc:@Mean_1*
T0*
	keep_dims( *

Tidx0
f
!gradients/Mean_1_grad/Maximum_1/yConst*
dtype0*
_class
loc:@Mean_1*
value	B :

gradients/Mean_1_grad/Maximum_1Maximumgradients/Mean_1_grad/Prod_1!gradients/Mean_1_grad/Maximum_1/y*
_class
loc:@Mean_1*
T0

 gradients/Mean_1_grad/floordiv_1Divgradients/Mean_1_grad/Prodgradients/Mean_1_grad/Maximum_1*
_class
loc:@Mean_1*
T0
w
gradients/Mean_1_grad/CastCast gradients/Mean_1_grad/floordiv_1*

DstT0*
_class
loc:@Mean_1*

SrcT0

gradients/Mean_1_grad/truedivDivgradients/Mean_1_grad/Tilegradients/Mean_1_grad/Cast*
_class
loc:@Mean_1*
T0
\
gradients/Mean_grad/ShapeShapeSquare*
out_type0*
T0*
_class
	loc:@Mean
[
gradients/Mean_grad/SizeConst*
dtype0*
_class
	loc:@Mean*
value	B :
r
gradients/Mean_grad/addAddMean/reduction_indicesgradients/Mean_grad/Size*
_class
	loc:@Mean*
T0
s
gradients/Mean_grad/modModgradients/Mean_grad/addgradients/Mean_grad/Size*
_class
	loc:@Mean*
T0
]
gradients/Mean_grad/Shape_1Const*
dtype0*
_class
	loc:@Mean*
valueB 
b
gradients/Mean_grad/range/startConst*
dtype0*
_class
	loc:@Mean*
value	B : 
b
gradients/Mean_grad/range/deltaConst*
dtype0*
_class
	loc:@Mean*
value	B :
Ŗ
gradients/Mean_grad/rangeRangegradients/Mean_grad/range/startgradients/Mean_grad/Sizegradients/Mean_grad/range/delta*
_class
	loc:@Mean*

Tidx0
a
gradients/Mean_grad/Fill/valueConst*
dtype0*
_class
	loc:@Mean*
value	B :

gradients/Mean_grad/FillFillgradients/Mean_grad/Shape_1gradients/Mean_grad/Fill/value*
_class
	loc:@Mean*
T0
Æ
!gradients/Mean_grad/DynamicStitchDynamicStitchgradients/Mean_grad/rangegradients/Mean_grad/modgradients/Mean_grad/Shapegradients/Mean_grad/Fill*
_class
	loc:@Mean*
T0*
N
`
gradients/Mean_grad/Maximum/yConst*
dtype0*
_class
	loc:@Mean*
value	B :

gradients/Mean_grad/MaximumMaximum!gradients/Mean_grad/DynamicStitchgradients/Mean_grad/Maximum/y*
_class
	loc:@Mean*
T0
}
gradients/Mean_grad/floordivDivgradients/Mean_grad/Shapegradients/Mean_grad/Maximum*
_class
	loc:@Mean*
T0

gradients/Mean_grad/ReshapeReshapegradients/Mean_1_grad/truediv!gradients/Mean_grad/DynamicStitch*
_class
	loc:@Mean*
T0*
Tshape0

gradients/Mean_grad/TileTilegradients/Mean_grad/Reshapegradients/Mean_grad/floordiv*

Tmultiples0*
_class
	loc:@Mean*
T0
^
gradients/Mean_grad/Shape_2ShapeSquare*
out_type0*
T0*
_class
	loc:@Mean
\
gradients/Mean_grad/Shape_3ShapeMean*
out_type0*
T0*
_class
	loc:@Mean
`
gradients/Mean_grad/ConstConst*
dtype0*
_class
	loc:@Mean*
valueB: 

gradients/Mean_grad/ProdProdgradients/Mean_grad/Shape_2gradients/Mean_grad/Const*
_class
	loc:@Mean*
T0*
	keep_dims( *

Tidx0
b
gradients/Mean_grad/Const_1Const*
dtype0*
_class
	loc:@Mean*
valueB: 

gradients/Mean_grad/Prod_1Prodgradients/Mean_grad/Shape_3gradients/Mean_grad/Const_1*
_class
	loc:@Mean*
T0*
	keep_dims( *

Tidx0
b
gradients/Mean_grad/Maximum_1/yConst*
dtype0*
_class
	loc:@Mean*
value	B :

gradients/Mean_grad/Maximum_1Maximumgradients/Mean_grad/Prod_1gradients/Mean_grad/Maximum_1/y*
_class
	loc:@Mean*
T0

gradients/Mean_grad/floordiv_1Divgradients/Mean_grad/Prodgradients/Mean_grad/Maximum_1*
_class
	loc:@Mean*
T0
q
gradients/Mean_grad/CastCastgradients/Mean_grad/floordiv_1*

DstT0*
_class
	loc:@Mean*

SrcT0
x
gradients/Mean_grad/truedivDivgradients/Mean_grad/Tilegradients/Mean_grad/Cast*
_class
	loc:@Mean*
T0

gradients/Square_grad/mul/xConst^gradients/Mean_grad/truediv*
dtype0*
_class
loc:@Square*
valueB
 *   @
f
gradients/Square_grad/mulMulgradients/Square_grad/mul/xsub*
_class
loc:@Square*
T0
~
gradients/Square_grad/mul_1Mulgradients/Mean_grad/truedivgradients/Square_grad/mul*
_class
loc:@Square*
T0
c
gradients/sub_grad/ShapeShapedense_2/BiasAdd*
out_type0*
T0*
_class

loc:@sub
i
gradients/sub_grad/Shape_1Shapeactivation_2_target*
out_type0*
T0*
_class

loc:@sub

(gradients/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_grad/Shapegradients/sub_grad/Shape_1*
_class

loc:@sub*
T0
ĸ
gradients/sub_grad/SumSumgradients/Square_grad/mul_1(gradients/sub_grad/BroadcastGradientArgs*
_class

loc:@sub*
T0*
	keep_dims( *

Tidx0

gradients/sub_grad/ReshapeReshapegradients/sub_grad/Sumgradients/sub_grad/Shape*
_class

loc:@sub*
T0*
Tshape0
Ļ
gradients/sub_grad/Sum_1Sumgradients/Square_grad/mul_1*gradients/sub_grad/BroadcastGradientArgs:1*
_class

loc:@sub*
T0*
	keep_dims( *

Tidx0
X
gradients/sub_grad/NegNeggradients/sub_grad/Sum_1*
_class

loc:@sub*
T0

gradients/sub_grad/Reshape_1Reshapegradients/sub_grad/Neggradients/sub_grad/Shape_1*
_class

loc:@sub*
T0*
Tshape0

*gradients/dense_2/BiasAdd_grad/BiasAddGradBiasAddGradgradients/sub_grad/Reshape*"
_class
loc:@dense_2/BiasAdd*
T0*
data_formatNHWC
ą
$gradients/dense_2/MatMul_grad/MatMulMatMulgradients/sub_grad/Reshapedense_2/kernel/read*
transpose_b(*
transpose_a( *!
_class
loc:@dense_2/MatMul*
T0
ą
&gradients/dense_2/MatMul_grad/MatMul_1MatMulactivation_1/Tanhgradients/sub_grad/Reshape*
transpose_b( *
transpose_a(*!
_class
loc:@dense_2/MatMul*
T0

)gradients/activation_1/Tanh_grad/TanhGradTanhGradactivation_1/Tanh$gradients/dense_2/MatMul_grad/MatMul*$
_class
loc:@activation_1/Tanh*
T0
¨
*gradients/dense_1/BiasAdd_grad/BiasAddGradBiasAddGrad)gradients/activation_1/Tanh_grad/TanhGrad*"
_class
loc:@dense_1/BiasAdd*
T0*
data_formatNHWC
Ā
$gradients/dense_1/MatMul_grad/MatMulMatMul)gradients/activation_1/Tanh_grad/TanhGraddense_1/kernel/read*
transpose_b(*
transpose_a( *!
_class
loc:@dense_1/MatMul*
T0
ŧ
&gradients/dense_1/MatMul_grad/MatMul_1MatMuldense_1_input)gradients/activation_1/Tanh_grad/TanhGrad*
transpose_b( *
transpose_a(*!
_class
loc:@dense_1/MatMul*
T0
8
Const_2Const*
dtype0*
valueBd*    
V
VariableVariable*
dtype0*
shape:d*
	container *
shared_name 
{
Variable/AssignAssignVariableConst_2*
validate_shape(*
_class
loc:@Variable*
use_locking(*
T0
I
Variable/readIdentityVariable*
_class
loc:@Variable*
T0
<
Const_3Const*
dtype0*
valueBd*    
\

Variable_1Variable*
dtype0*
shape
:d*
	container *
shared_name 

Variable_1/AssignAssign
Variable_1Const_3*
validate_shape(*
_class
loc:@Variable_1*
use_locking(*
T0
O
Variable_1/readIdentity
Variable_1*
_class
loc:@Variable_1*
T0
8
Const_4Const*
dtype0*
valueB*    
X

Variable_2Variable*
dtype0*
shape:*
	container *
shared_name 

Variable_2/AssignAssign
Variable_2Const_4*
validate_shape(*
_class
loc:@Variable_2*
use_locking(*
T0
O
Variable_2/readIdentity
Variable_2*
_class
loc:@Variable_2*
T0
<
Const_5Const*
dtype0*
valueBd*    
\

Variable_3Variable*
dtype0*
shape
:d*
	container *
shared_name 

Variable_3/AssignAssign
Variable_3Const_5*
validate_shape(*
_class
loc:@Variable_3*
use_locking(*
T0
O
Variable_3/readIdentity
Variable_3*
_class
loc:@Variable_3*
T0
3
mul_2Mulmomentum/readVariable/read*
T0
J
mul_3Mullr/read*gradients/dense_1/BiasAdd_grad/BiasAddGrad*
T0
#
sub_1Submul_2mul_3*
T0
p
AssignAssignVariablesub_1*
validate_shape(*
_class
loc:@Variable*
use_locking(*
T0
-
addAdddense_1/bias/readsub_1*
T0
x
Assign_1Assigndense_1/biasadd*
validate_shape(*
_class
loc:@dense_1/bias*
use_locking(*
T0
5
mul_4Mulmomentum/readVariable_1/read*
T0
F
mul_5Mullr/read&gradients/dense_1/MatMul_grad/MatMul_1*
T0
#
sub_2Submul_4mul_5*
T0
v
Assign_2Assign
Variable_1sub_2*
validate_shape(*
_class
loc:@Variable_1*
use_locking(*
T0
1
add_1Adddense_1/kernel/readsub_2*
T0
~
Assign_3Assigndense_1/kerneladd_1*
validate_shape(*!
_class
loc:@dense_1/kernel*
use_locking(*
T0
5
mul_6Mulmomentum/readVariable_2/read*
T0
J
mul_7Mullr/read*gradients/dense_2/BiasAdd_grad/BiasAddGrad*
T0
#
sub_3Submul_6mul_7*
T0
v
Assign_4Assign
Variable_2sub_3*
validate_shape(*
_class
loc:@Variable_2*
use_locking(*
T0
/
add_2Adddense_2/bias/readsub_3*
T0
z
Assign_5Assigndense_2/biasadd_2*
validate_shape(*
_class
loc:@dense_2/bias*
use_locking(*
T0
5
mul_8Mulmomentum/readVariable_3/read*
T0
F
mul_9Mullr/read&gradients/dense_2/MatMul_grad/MatMul_1*
T0
#
sub_4Submul_8mul_9*
T0
v
Assign_6Assign
Variable_3sub_4*
validate_shape(*
_class
loc:@Variable_3*
use_locking(*
T0
1
add_3Adddense_2/kernel/readsub_4*
T0
~
Assign_7Assigndense_2/kerneladd_3*
validate_shape(*!
_class
loc:@dense_2/kernel*
use_locking(*
T0
p

group_depsNoOp^mul_1^Assign	^Assign_1	^Assign_2	^Assign_3	^Assign_4	^Assign_5	^Assign_6	^Assign_7
&
group_deps_1NoOp^dense_2/BiasAdd
÷
initNoOp^dense_1/kernel/Assign^dense_1/bias/Assign^dense_2/kernel/Assign^dense_2/bias/Assign^iterations/Assign
^lr/Assign^momentum/Assign^decay/Assign^Variable/Assign^Variable_1/Assign^Variable_2/Assign^Variable_3/Assign
<
PlaceholderPlaceholder*
dtype0*
shape
:d

Assign_8Assigndense_1/kernelPlaceholder*
validate_shape(*!
_class
loc:@dense_1/kernel*
use_locking( *
T0
:
Placeholder_1Placeholder*
dtype0*
shape:d

Assign_9Assigndense_1/biasPlaceholder_1*
validate_shape(*
_class
loc:@dense_1/bias*
use_locking( *
T0
>
Placeholder_2Placeholder*
dtype0*
shape
:d

	Assign_10Assigndense_2/kernelPlaceholder_2*
validate_shape(*!
_class
loc:@dense_2/kernel*
use_locking( *
T0
:
Placeholder_3Placeholder*
dtype0*
shape:

	Assign_11Assigndense_2/biasPlaceholder_3*
validate_shape(*
_class
loc:@dense_2/bias*
use_locking( *
T0"