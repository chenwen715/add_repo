# -*- coding:utf-8 -*-
import pymssql

class sqlOperation(object):
    def __init__(self,server,user,pwd,database,port):
        try:
            self.db=pymssql.connect(host=server,user=user,password=pwd,database=database,port=port)
        except Exception as e:
            raise e

    def selectAll(self,sql,as_dict=False):
        '''
        获取所有查询结果

        sql：输入的查询语句
        as_dict：结果是否为dict形式，默认为False
        return：查询到的结果list，as_dict=False时里面为tuple，as_dict=True时里面为dict
        '''
        with self.db.cursor(as_dict=as_dict) as cur:
            cur.execute(sql)
            self.result=cur.fetchall()
            return self.result
        self.db.close()

    def selectOne(self,sql,as_dict=False):
        '''
        获取查询结果

        sql：输入的查询语句
        as_dict：结果是否为dict形式，默认为False
        return：查询到的结果----as_dict=False时返回tuple，as_dict=True时返回dict
        '''
        with self.db.cursor(as_dict=as_dict) as cur:
            cur.execute(sql)
            self.result=cur.fetchone()
            return self.result
        self.db.close()

    def executeOne(self,sql):
        '''
        执行除select语句外的其他单条语句

        sql：输入的执行语句
        '''
        with self.db.cursor() as cur:
            cur.execute(sql)
            self.db.commit()
        #self.db.close()

    def executeMany(self,sql,params=[]):
        '''
        一次执行除select语句外的其他多条语句，语句内容一样，只有部分参数不同

        sql：输入的执行语句
        params：参数
        '''
        with self.db.cursor() as cur:
            cur.executemany(sql,params)
            self.db.commit()
        #self.db.close()

    def executePro(self,proName,proParams=()):
        '''
        调用存储过程

        proName：存储过程名字
        proParams：存储过程输入参数
        '''
        with self.db.cursor() as cur:
            cur.execute(f"exec %s @name=%s,@age=%d"%(proName,proParams[0],proParams[1]))
            #cur.callproc(proName,proParams)#作用同上            
            cur.nextset()
            r=cur.fetchone()
            return r



if __name__=="__main__":
    db=sqlOperation("127.0.0.1","sa","abc123*","XueXi",1433)
    '''sql="SELECT Name, Password FROM dbo.T_User WHERE Name = 'hm1'"
    sql1="INSERT INTO dbo.T_User (Name, Password) VALUES ('hma','1998') "
    r=db.selectAll(sql,True)
    print(r)
    db.executeOne(sql1)
    db.executeMany("INSERT INTO dbo.T_User (Name, Password) VALUES (%s,%s)",[('hm1','1212'),('hm2','1313')])
    r1=db.selectAll(sql,True)
    print(r1)'''
    age=db.executePro("tmp_test",("he",1))
    print(age)
