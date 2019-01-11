import re
import itertools
import time
class AlphameticsSolver(object):
    """算法谜题"""
    def __init__(self, alpha):
        self.alpha=alpha

    def solve(self):
        allw=re.findall("[A-Z]+",self.alpha)#查找所有单词
        alluniquec=set("".join(allw))#查找所有单词用到的字母
        firstc=set("".join(a[0] for a in allw))#查找所有单词的首字母，首字母对应的数字不能为0
        if len(alluniquec)>10:
            raise("too much characters,must less then 11")#字母数超过10报错，0-9只有10个数
        cascii=tuple(ord(c) for c in alluniquec)        
        for nl in itertools.permutations("0123456789",len(alluniquec)):
            flag=False
            nascii=tuple(ord(n) for n in nl)
            cndict=dict(zip(cascii,nascii))
            for b in firstc:
                if cndict[ord(b)]==ord("0"):
                    flag=True
                    break
            if not flag:
                result=self.alpha.translate(cndict)
                a=eval(result)
                if a:
                    return result
      
    def solve1(self):
            allw=re.findall("[A-Z]+",self.alpha)#查找所有单词
            alluniquecc=set("".join(allw))#查找所有单词用到的字母
            firstc=set("".join(a[0] for a in allw))#查找所有单词的首字母，首字母对应的数字不能为0
            alluniquec=list(firstc)+[a for a in alluniquecc if a not in firstc]
            if len(alluniquec)>10:
                raise("too much characters,must less then 11")#字母数超过10报错，0-9只有10个数
            cascii=tuple(ord(c) for c in alluniquec)        
            for nl in itertools.permutations("0123456789",len(alluniquec)):
                nascii=tuple(ord(n) for n in nl)
                if ord("0") not in nascii[:len(firstc)]:
                    cndict=dict(zip(cascii,nascii))
                    result=self.alpha.translate(cndict)
                    if eval(result):
                        return result


