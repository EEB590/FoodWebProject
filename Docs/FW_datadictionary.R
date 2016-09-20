#Food Web Data cleaning exercise

fwdata<-read.csv("FW_master_2016_foranalysis.csv", header=T, as.is=T)

#data dictionary
#island: guam, saipan, tinian, rota
#site: site where experiment was conducted. Options are: anaoarray, anaogrid, bird, chig, cross, forbiarray, forbigrid, gino, grvp, japc, jsc, ladtarray, ladtgrid, lcp, maha, midfig, mtr1, naftan, nblas, nlasu, paliiw, paliie, pina, racefrag, racegrid, ritdgate, ritdgrid, sblas, slasu
#date: date of data collection
#observer: initials of the observer
#row: should be a number 1-14
#col: should be a letter a-h
#trt: open or exclosure 
#spp: aglaia, morinda, neisosperma, papaya, premna, psychotria
#ht: height of the plant, if ht=0, plant is dead
#numleaves: number leaves on the plant, should be na if ht=0
#leafnum: leaf number - from 1 to max num leaves for that plant
#wilt: yes or no; if blank, assume no wilt
#damclass: damage class: 0, 0-2, 2-5, 5-10, 10-25, 25-50, 50-75, 75-99, 100
#primdam: primary damage type. options are dis = discolored, def=deformed, h=herbivory, g=galling, r=rolling)
#secdam: secondary damage type (and sometimes tertiary). options are same as primdam. 
#notes: notes
#entby: entered by (name)
#proofby: proofed by (name)
#dateent: date entered
