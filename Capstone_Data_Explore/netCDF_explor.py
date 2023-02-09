#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb  7 08:55:30 2023

@author: jfrench
"""

# I am following this tutorial: https://towardsdatascience.com/read-netcdf-data-with-python-901f7ff61648
# but using the kelp biomass and area file from the SBC LTER.

import netCDF4 as nc

### Assign file path to a variable to make it easier to read the code later.
fn = '/Users/jfrench/Documents/MEDS/Capstone/DATA/LandsatKelpBiomass_2022_Q4_withmetadata.nc'

### I believe this reads in the data
ds = nc.Dataset(fn)

print(ds)

# Access dimension information 

for dim in ds.dimensions.values():
    print(dim)
    
 
# Access metadata for each variable, can also access metadata for an individual variable 
#using brackets to index to it instead of looping through all of them. 
for var in ds.variables.values():
    print(var)
    
# Try to access just area

print(ds['area'])

print(ds['latitude'])


# Lets try a subset of the values

area = ds['area'][90, 50000:51000]

print(area)

type(area)


