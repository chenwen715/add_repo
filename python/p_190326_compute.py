list=[]
listc=[]
for i in range(1,21):
    for j in range(1,21):
        a=[i,j,i+j,i*j]
        ac=[j,i,i+j,i*j]
        if not i==j:
            if not len(list)==0:
                if ac in list:
                    list.append(a)
                    continue
                for b in list:
                    if a[2]==b[2] or a[3]==b[3]:
                        listc.append(a)
                        break

                        #c=[b[1],b[0],b[2],b[3]]
                        #if not b in listc and not c in listc:
                            #listc.append(b)
                        #break
            list.append(a)
#print(len(list))
#print(list)
print(len(listc))
print(listc)
