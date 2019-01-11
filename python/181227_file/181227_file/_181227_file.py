import io
import gzip
from ReDirect import ReDirect
file=open("tmp.txt",encoding="utf-8")#open方法常用两个参数。第一个参数为文件名，也可为路径/文件名；第二个参数为解码方式，以便在不同系统中都能正确读取文件
print(file.name)#tmp.txt    name属性为传递给open函数的文件名，可为：路径/文件名或文件名
print(file.encoding)#utf-8  encoding为文件的编码方式，如果你在打开文件的时候没有指定编码方式，那么encoding属性反映的是locale.getpreferredencoding()的返回值（即系统默认编码方式）
print(file.mode)#r  mode为打开文件的访问模式，默认为r（以只读方式打开），可在使用open函数时传递参数
print(file.read())#使用流对象的read()方法读取文件
file.seek(0)#seek方法定位文件指针到指定的字节
print(file.read(2))#read函数加参数可指定读取文件的几个字节
print(file.tell())#tell函数返回文件的当前位置，即文件指针当前位置
#注：seek和tell方法按字节计数，read方法按字符计数，一个中文字符可能占好几个字节
file.close()#close方法关闭打开的文件。可以使用下面的with方法来防止未到close方法，file的其他方法出现异常，无法关闭文件的情况
print(file.closed)#closed属性表明文件是否已经关闭


with open("tmp.txt",mode="a",encoding="utf-8") as file2:#mode="a"为向文件后面添加数据，mode="w"为重写数据
    file2.write("\ngood")#write方法向文件中写入数据

'''
with语句引出一个代码块。
在这个代码块里，可以使用变量file1作为open()函数返回的流对象。
流对象的常规方法都是可用的seek()，read()等。
当with块结束时，Python自动调用a_file.close()，无论是正常退出还是异常退出。
'''
with open("tmp.txt",encoding="utf-8") as file1:
    #print(file1.read(1))
    #file1.seek(2)
    #print(file1.read(1))
    #print(file1.tell())
    number=0
    for line in file1:
        number+=1
        '''format函数：
        ^, <, > 分别是居中、左对齐、右对齐，后面带宽度， : 号后面带填充的字符，只能是一个字符，不指定则默认是用空格填充。
        + 表示在正数前显示 +，负数前显示 -；  （空格）表示在正数前加空格
        b、d、o、x 分别是二进制、十进制、八进制、十六进制。
        可以使用大括号 {} 来转义大括号
        '''
        print("{:<4}{}".format(number,line.strip()))#strip函数去收尾空格

a_string="what's your name"
a_stream=io.StringIO(a_string)#io.StringIO将字符串转换为流对象
print(a_stream.read(2))

##不理解，不清楚用途
#with gzip.open("test.zip",mode="wb") as file3:#gzip.open将压缩文件转换为流对象打开，此时为二进制模式
#    file3.write(b"test zip")

with open("out.txt",mode="w",encoding="utf-8") as file4,ReDirect(file4):#with后面不一定要接as
    '''
    上一句相当于：
    with open("out.txt",mode="w",encoding="utf-8") as file4：
        with ReDirect(file4):
    '''
    print("this content will be written in out.txt instead of showed in command line")
print("this will be showed in command line")

