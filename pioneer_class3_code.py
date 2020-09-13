#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 22 17:53:51 2020

@author: sirikonanoor
"""
# import numpy as np
# import matplotlib.pyplot as plt

# ## takes in a matrix of pYgX, corresponding possibel xs and returns bias and variance, which are arrays indicating bias and variance



# # Assumptions: 
# # 1: pYgX is a valid conditional probability distribution (positive entries and normalized so that sums of pYgX over y = 1 no matter x)
# # 2: The number of possible y's and number of possible x's is finite
 

#  # pYgX has X on the columns and Y on the rows. Means that each column is a valid probability distribution.

# # Variance = Σy p(y|x) ˆx(y)^2 - (Σy p(y|x) ˆx)^2
# # Bias = (Σ y p(y|x) ˆx(y)) - x

# # to fix: xhatY needs to be figured out
# # xhatY = argmax_x pYgX 
# x = 0

# xs = np.asarray([0.5, 0.3, 0.2])
# pYgX = np.asarray([[0.4, 0.3, 0.3],[0.2, 0.5, 0.3],[0.9, 0.1, 0.0]])

# # to fix: need to loop over possible environments

# xhatY = xs[np.argmax(pYgX, axis = 0)]

# bias = np.sum(pYgX * xhatY) - x
# variance = np.sum(pYgX*xhatY**2) - np.sum(pYgX * xhatY)** 2

# # pYgX = np.asarray([0.8, 0.1, 0.1])
# # xhatY = np.asarray([6.5, 1/3.0, 1/6.0])



import numpy as np
import matplotlib as plt

bias = np.zeros(3)
variance = np.zeros(3)

xs = np.asarray([0.5,0.3,0.2])
# the following two lines are for when ASSUMPTION 2 FAILS.
# xs = {0, 2dx, 3dx, ..., mdx}, make dx small and m big. 
# xs = np.linspace(0, 100, 100000)
pYgX = np.asarray([[0.4,0.3,0.3],[0.2,0.5,0.3],[0.9,0.1,0]])
xhatY = xs[np.argmax(pYgX,axis=0)]


bias = np.sum(pYgX*xhatY, axis = 1) - xs
variance = np.sum(pYgX*xhatY**2, axis = 1)- np.sum(pYgX*xhatY, axis = 1)**2

print(bias, variance)

for i in range(3):
	bias[i] = np.sum(pYgX[:, i]*xhatY[i]) - xs[i]
	variance[i] = np.sum(pYgX[:, i]*xhatY[i]**2)-np.sum(pYgX[i]*xhatY[i])**2
    
for i in range(3):
	bias[i] = np.sum(pYgX[i]*xhatY[i])-xs[i]
	variance[i] = np.sum(pYgX[i]*xhatY[i]**2)-np.sum(pYgX[i]*xhatY[i])**2
    
    
# solution: 
    # bias[i] = np.sum(pYgX[i, :] * xhatY) - xs[i]
    
    
    # for loop method:
    # for i in range(xs):
    #     bias[i] = np.sum(pYgX[i, :] * xhatY) - xs[i]
    
    
    
        





