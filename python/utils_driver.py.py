import os
import sys

from utils.computeClass import divisionClass
from utils.listClass import listOperations

def test_file1_method1():
	x=5
	y=6
	assert x+1 == y,"test failed"
	assert x == y,"test failed"
def test_file1_method2():
	x=5
	y=6
	assert x+1 == y,"test failed" 



def main():
	print ("Python app")

	if(sys.argv[1] == str(1)):
		print ("Division class")
		compObj = divisionClass(1,3)
		retStatus = compObj.is_recurring()
		retStatus = compObj.updade_num_den(1,2)
		retStatus = compObj.is_recurring()
		retStatus = compObj.updade_num_den(4,2)
		retStatus = compObj.is_recurring()
		retStatus = compObj.updade_num_den(5,2)
		retStatus = compObj.is_recurring()

	if(sys.argv[1] == str(2)):
		print ("List class")
		listObj = listOperations(['a', 'b', 'c', 'a'])
		listObj.getMostFrequentElement()
		print ("Eleme wise modified list : ", str(listObj.modifyList_elementwise_addition(2)))
		
		listObj.updateList([1, 2, 1, 3, 4 , 6, 6, 6])
		listObj.getMostFrequentElement()
		print ("Eleme wise modified list : ", str(listObj.modifyList_elementwise_addition(2)))

		print ("Even items in list : ", str(listObj.filterEvenList()))
		print ("Sorted list : ", str(listObj.sortElementsString()))




if __name__ == '__main__':
	main()