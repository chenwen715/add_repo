import sys
class ReDirect(object):
    """重定向标准输出"""
    def __init__(self, out_new):
        self.out_new=out_new

    def __enter__(self):#在进入一个上下文环境时Python会调用它（即在with语句的开始处）
        self.out_old=sys.stdout
        sys.stdout=self.out_new

    def __exit__(self,*args):#当离开一个上下文环境时Python会调用它（即在with语句的末尾）
        sys.stdout=self.out_old


