from Feibonacci import Feibonacci
from ComplexNumber import ComplexNumber
from AlphameticsSolver import AlphameticsSolver
import itertools

#for n in Feibonacci(1000):
#    print(n,end=" ")

word="hobby"
#for match,apply in ComplexNumber((('[sxz]$', '$', 'es'),('[^aeioudgkprt]h$', '$', 'es'),('(qu|[^aeiou])y$', 'y$', 'ies'),('$', '$', 's'))):
#    if match(word):
#        result=apply(word)
#        break
#print(result)   

#matchandapply=list(ComplexNumber((('[sxz]$', '$', 'es'),('[^aeioudgkprt]h$', '$', 'es'),('(qu|[^aeiou])y$', 'y$', 'ies'),('$', '$', 's'))))
#for match,apply in matchandapply:
#    if match(word):
#        result=apply(word)
#        break
#print(result)  


string="HAWAII + IDAHO + IOWA + OHIO == STATES"
print(AlphameticsSolver(string).solve1())
print(AlphameticsSolver(string).solve())

