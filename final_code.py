#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Aug 11 00:50:35 2020

@author: sirikonanoor
@editor: prof.sarahmarzen
"""
import numpy as np
import mpmath as mp
import matplotlib.pyplot as plt


# general code to plot
# plt.plot(xaxis, yaxis, '--o', label = "name")
# plt.legend(loc = 'best')
# plt.xlabel('xaxis')
# plt.ylabel('yaxis')
# plt.show()




num = 55

# functions:

###probability distribution of mRNA


def mRNAdistribution(allolac_conc):
    # gene transcription rate (aka mrna formation rate)
        # ~10seconds for 1kb, and Lac operon is 5.3 kb long
    # mrna degradation rate
        # ~ half-life is around 5 mins
    # deg_rate = 1 #seconds
    # trans_rate = 5000 # 100 #seconds
    
 # for the session 9 presentation, it used to be:
    # trans_rate = 10
    # deg_rate = 1/500
    
    deg_rate = 1
    trans_rate = 500
    # probability of mrna = 0
    prob_zero = 1
    
    # 100 is just a random number I chose; isn't anything specific
    prob_mrna = np.zeros(num)
    prob_mrna[0] = prob_zero
    prob_mrna[1] = trans_rate * calcRNAPbound(allolac_conc) * prob_zero / deg_rate
    
    
    for i in range(2, num):
        prob_mrna[i] = (deg_rate * (i - 1) * prob_mrna[i-1] + trans_rate * calcRNAPbound(allolac_conc) * 
                        prob_mrna[i-1] - trans_rate * calcRNAPbound(allolac_conc) * prob_mrna[i-2]) / (deg_rate * i)
   
    sum_prob = np.sum(prob_mrna)
    prob_mrna = prob_mrna/sum_prob
    
    
    return prob_mrna

def calcRNAPbound (allolac_conc):
    
    # all the non-specific sites
    nns = 5 * 10**6
    # concentration of rnap molecules
        # got 500 from "trans reg by the nums: models" and supplemental paper of "Quantitative dissection of the simple repression input–output function"
    rnap_conc = 2000 # 3.95 * 10**-7 # 500 molecules converted to moles/litre
    # concentration of total number of repressor molecules
    rep_total_conc = 10 # 7.9 * 10**-9 # 10

    
    # Boltzmann constant * temperature

    beta = 1 # / (1.3807 * 10**(-23))
    # equilibrium constant of the forward reaction for [allolactose + repressor --> repressor-inducer complex]
    k_eq = (1.7 * 10**6)
    
    # taken from "trans by the numbers: models"
    epd = -2.9
    # taken from "Quantitative dissection of the simple repression input–output function"
    erd = -14.4
    
    # ways to express repressor conc (depends on how it's given in data)
        # total_rep = rep_bound + rep_unbound
        # rep_bound = total_rep - rep_unbound
    # rep_unbound_conc = rep_total_conc/(allolac_conc**2 * k_eq + 1)
    rep_unbound_conc = rep_total_conc/(allolac_conc * k_eq + 1)
    
    # states and their weights:
    empty_promoter = 1
    # RNA Polymerase bound to promoter
    rnap_bound = rnap_conc/nns * mp.exp(-beta * epd)
    # Repressor bound to operator
    repressor_bound = 2*rep_unbound_conc/nns * mp.exp(-beta * erd)

    total_weight = empty_promoter + rnap_bound + repressor_bound

    prob_rnap_bound = rnap_bound/total_weight
    
    # array containing the probability of rnap binding, given a value of lac concentration
    return prob_rnap_bound

def calculatebiasvar(xs, pYgX):
    # pYgX = pYgX.T
    
    xhatY = xs[np.argmax(pYgX, axis=1)]
    
    bias = np.sum(pYgX*xhatY[:, None], axis = 0) - xs
    variance = np.sum(pYgX*xhatY[:, None]**2, axis = 0) - np.sum(pYgX*xhatY[:, None], axis = 0)**2
    
    return bias, variance, xhatY


# Equations and states+weights from:
    # <https://www.pnas.org/content/108/29/12173> and <https://www.sciencedirect.com/science/article/pii/S0006349508001008>

# Things to do:
    # (1) make an array of lac concentrations 
    # (2) pass it to function to calculate the rnap bindings for all of those lac concentrations
    # (3) pass array with prob_rnap_binding to function to calculate mRNA distribution functions

    
# lactose concentrations as obtained from databases
    # (also don't have specific numbers)
# lac_conc = np.asarray(val1, val2, val3)
# convert to allolactose concentrations
# units are in mol
# allolac_conc = np.asarray([10**-10, 10**-6, 10**-4, 10**-2]) # lac_conc/2


arr = np.arange(start = -3, stop = -2.5, step = 0.5)  
# arr = np.arange(start = -6, stop = 0.5, step = 0.5)
# arr = np.arange(start = -9, stop = -2.5, step = 0.5)
# arr = np.arange(start = -9, stop = 0.5, step = 0.5)  
allolac_conc = np.power(10, arr)

# allolac_conc = np.asarray([1, 2, 3, 4])
# prob_rnap_bound = calcRNAPbound(allolac_conc)
# 6022141500000001000


full_prob = np.zeros((num, len(arr)))

prob_mrna = np.zeros(num)

for j in range(len(arr)):
    allolac_indiv = allolac_conc[j]
    prob_mrna = np.zeros(num)
    full_prob[:, j] = mRNAdistribution(allolac_indiv)

# print(prob_mrna)

bias, variance, xhatY = calculatebiasvar(allolac_conc, full_prob)
print("bias: ")
print(bias)
print("variance: ")
print(variance)



# plt.plot(np.arange(0, num), xhatY, '--o', label = "")
# plt.plot(np.arange(0, num), full_prob, '--o', label = "")
# plt.yscale('log')
# plt.plot(allolac_conc, variance, '--o', label = "")
plt.plot(allolac_conc, bias, '--o', label = "")
plt.xscale('log')
plt.legend(loc = 'best')
plt.xlabel('# mrna')
plt.ylabel('p(mrna)')
plt.show()


### CODE REQUIRED TO EXPORT mRNA PROBABILITY DISTRIBUTION

# full_prob = np.insert(full_prob, 0, np.arange(0, num), axis = 1)
# # save data as .csv for plotting in RStudio using ggplot2
# np.savetxt(fname = "/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.1a.csv",
#           X = full_prob,
#           delimiter = ",")


###CODE REQUIRED TO EXPORT AND GRAPH XHATY

# new_xhatY = np.zeros((len(xhatY), 2))
# new_xhatY[:, 0] = np.arange(0, num)
# new_xhatY[:, 1] = xhatY
# np.savetxt(fname = "/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3adeg.csv",
#           X = new_xhatY,
#           delimiter = ",")


### CODE REQUIRED TO EXPORT AND GRAPH PREDICTED mRNA GIVEN ALLOLACTOSE

# predict_mrna = np.argmax(full_prob, axis = 0)
# full_predict_arr = np.zeros((len(predict_mrna), 2))
# full_predict_arr[:, 0] = allolac_conc
# full_predict_arr[:, 1] = predict_mrna
# np.savetxt(fname = "/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.2e.csv",
#           X = full_predict_arr,
#           delimiter = ",")


### CODE REQUIRED TO EXPORT AND GRAPH BIAS AND VARIANCE

# full_arr = np.zeros((len(bias), 2))
# full_arr[:, 0] = allolac_conc
# full_arr[:, 1] = variance
# np.savetxt(fname = "/Users/sirikonanoor/Documents/pioneer/csvfiles/fig.3cdeg.csv",
#           X = full_arr,
#           delimiter = ",")

