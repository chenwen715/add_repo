import pandas

try:
    file=pandas.read_excel("D:\\数据.xlsx")
    print(file)
except Exception as e:
    print(e)
