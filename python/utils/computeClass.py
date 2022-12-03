

class divisionClass:
    def __init__(self, param_num, param_den):
        self.numer = param_num
        self.deno = param_den
        self.quotString = ""

    def updade_num_den(self, param_num, param_den):
        self.numer = param_num
        self.deno = param_den

    def is_recurring(self):
        if( self.longDivision(self.numer, self.deno)):
            print ("\nrecurring")
        else:
            print ("\nNon recurring")

        print ("Quotient : ", str(self.quotString))

    def longDivision(self,numerIn, denIn):
        # print ("numer :",str(numerIn))
        # print ("deno :",str(denIn))
        self.quotString = ""
        
        #reminderList = []
        reminderList = { 0 }

        rem = numerIn % denIn

        quot = numerIn // denIn
        if(quot == 0):
            self.quotString += "0."
        else:
            self.quotString += str(quot)+'.'

        while((rem !=0 ) and (rem not in reminderList)):
            reminderList.add(rem)
            numerIn = rem*10
            rem = numerIn % denIn
            self.quotString += str(numerIn // denIn)

        if(rem in reminderList):
            return True
        else:
            return False
 