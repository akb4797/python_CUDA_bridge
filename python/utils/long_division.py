
def long_div(num_arg, den_arg):
    # print ("num", num_arg)
    # print ("den", den_arg)

    reminder_str = ""
    quotiont_str = ""

    uniqueSet = []

    rem_one = num_arg % den_arg

    while((rem_one != 0) and (rem_one not in uniqueSet)):
 

        if(num_arg//den_arg == 0):
            quotiont_str += str('0.')
            # uniqueSet.append(rem_one)
        else:
            quotiont_str += str(num_arg//den_arg)
            reminder_str += str(rem_one)
            uniqueSet.append(rem_one)
        
        print ("set : ", str(uniqueSet))

        num_arg = rem_one*10
        rem_one = num_arg%den_arg

    else:
        quotiont_str += str(num_arg//den_arg)


    if (rem_one in uniqueSet):
        print ("\nRecurring decimals")
        

    return quotiont_str, reminder_str

def main():
    print ("Long division")

    num_in = 1
    den_in = 732

    (quotiant, reminder) = long_div(num_in, den_in)
    #print ("quotiont_str : ", str(quotiant))
    #print ("reminder_str : ", str(reminder))
    print ("Thongappi oru nalla kutti")

if __name__ == '__main__':
    main()