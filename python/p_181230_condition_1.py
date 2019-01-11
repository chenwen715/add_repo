'''
使⽤while，完成以下图形的输出
*
* *
* * *
* * * *
* * * * *
* * * *
* * *
* *
*
'''

def drawstar(n):
    i=1
    while i<=n:
        j=1
        while j<=i:
            print("*",end=" ")
            j+=1
        print("\n")
        i+=1
    while i<=(2*n-1):
        j=1
        while j<=(2*n-i):
            print("*",end=" ")
            j+=1
        print("\n")
        i+=1

if __name__=="__main__":
    drawstar(5)
