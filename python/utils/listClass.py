

class listOperations:
    
    def __init__(self,paramInList):
        self.inputList = paramInList

    def getMostFrequentElement(self):
        maxCountVal = 0
        maxCountIndex = 0
        freElem = 0 #cannot because of element type

        for index,elemVal in zip(range(0, len(self.inputList)), self.inputList):
            curValCount = self.inputList.count( elemVal)
            if(curValCount > maxCountVal):
                maxCountVal = curValCount
                maxCountIndex = index
                freElem = elemVal
            


    def updateList (self, paramInList):
        self.inputList = paramInList
            
    def modifyList_elementwise_addition(self, paramIn):
        return [x+paramIn for x in self.inputList if (isinstance(x, int) or isinstance(x,float))]

    def filterEvenList(self):
        return [x for x in self.inputList if (isinstance(x,int) and ( x%2==0) )]
        
    def sortAscending(self,x):
        return x

    def sortElementsString(self, order='ascending'):
        if(order=='ascending'):
            #key = sortAscending()
            return sorted(self.inputList, key=lambda x:6-x)
            print ("data", str(self.inputList))
            