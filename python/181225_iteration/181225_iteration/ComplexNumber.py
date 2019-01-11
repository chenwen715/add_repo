import re
class ComplexNumber(object):
    """复数规则"""
    def __init__(self, rules):
        self.rules=rules

    def __iter__(self):
        self.indexn=0
        return self

    def __next__(self):
        if self.indexn>=len(self.rules):
            raise StopIteration
        pattern,originw,replacew=self.rules[self.indexn]
        func=built_apply(pattern,originw,replacew)
        self.indexn+=1
        return func
        
def built_apply(pattern,originw,replacew):
    def search(word):
        return re.search(pattern,word)
    def apply(word):
        return re.sub(originw,replacew,word)
    return(search,apply)


