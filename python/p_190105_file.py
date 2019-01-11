# -*- coding:utf-8 -*-

def backup(file):
    try:
        with open(file,mode="r",encoding="utf-8") as f:
            for line in f:
                with open(file[:file.rfind(".")]+"_复件"+file[file.rfind("."):],mode="a",encoding="utf-8") as f1:
                    f1.write(line)
    except FileNotFoundError as e:
        print(e)
    print("finish")
                
                
if __name__=="__main__":
    backup("p_181230_conditio.py")
