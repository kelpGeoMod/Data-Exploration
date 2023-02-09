#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb  7 10:07:15 2023

@author: jfrench
"""

# import packages
import netCDF4 as nc
import numpy

### Assign file path to a variable to make it easier to read the code later.
fn = '/Users/jfrench/Documents/MEDS/Capstone/DATA/LandsatKelpBiomass_2022_Q4_withmetadata.nc'

### I believe this reads in the data
ds = nc.Dataset(fn)


## I think we should be able to createa another grid that is the latitude and longitude 
## and map or join that to the area and time data so it is georeferenced correctly
# pull out latitude and longitude

# converted lat and long to list

lat = list(ds["latitude"])
lon = list(ds["longitude"])

print(lat)

# convert to 1d array
lat_array = numpy.array(lat)
lon_array = numpy.array(lon)

# create a 2d matrix from the lat and lon array

grid = numpy.matrix(lat, lon)


print(grid)
