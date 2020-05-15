#!/usr/bin/python2.7

import sys
import os
import projectLibs

'''
def sendToCUDA(ocrIn, MAX_GT_SIZE=2):
    print("raw : " + ocrIn)
    if(len(ocrIn)<MAX_GT_SIZE):
        appendString = ['0']*(MAX_GT_SIZE-len(ocrIn))
        print ('app str : '+ str(appendString))
        for elem in appendString:
            ocrIn = ocrIn+str(elem)
       
        print ('encap : ' + ocrIn)
'''
def main():
    print ("Python Wrapper")
    projectLibs.greet()

    dataPacket = 'acx'
    retVal = projectLibs.sendToCUDA(dataPacket, len(dataPacket))


    print('\n')

    

if __name__ == "__main__":
    main()
