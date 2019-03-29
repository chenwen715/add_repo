# -*- coding:utf-8 -*-
import pyodbc
#pyodbc参考文档-https://github.com/mkleehammer/pyodbc/wiki
import pymssql

class sqlOperation(object):
    '''
    数据库操作
    '''

    def __init__(self, driver,server,user,password,database):
        '''
        初始化
        driver：驱动   'SQL Server Native Client 11.0'--SqlServer
        server：数据库地址    "172.16.5.51"
        user：用户名    "sa"
        password：密码 "abc123*"
        database：数据库名   "XueXi"
        '''
        self.driver = driver
        self.server = server
        self.user = user
        self.password = password
        self.database = database

    def __GetConnect(self,as_dict=False):
        '''
        连接数据库
        '''
        if not self.database:
            raise(NameError,"没有设置数据库信息")
        self.conn = pymssql.connect(server=self.server,user=self.user,password=self.password,database=self.database)
        cur = self.conn.cursor(as_dict=as_dict)
        if not cur:
            raise(NameError,"连接数据库失败")
        else:
            return cur

    def ExecQuery(self,sql,as_dict=False):
        '''
        执行select操作
        '''
        cur = self.__GetConnect(as_dict)
        cur.execute(sql)
        resList = cur.fetchall()
        #查询完毕后必须关闭连接
        self.conn.close()
        return resList

    def ExecNonQuery(self,sql):
        '''
        执行更新，插入，删除操作
        '''
        cur = self.__GetConnect()
        cur.execute(sql)
		#更新，插入，删除操作后需提交commit
        self.conn.commit()
        self.conn.close()

if __name__=="__main__":
    #sqls=sqlOpreation('SQL Server Native Client 11.0','127.0.0.1','sa','abc123*','XueXi')
    #list=sqls.ExecQuery("SELECT * FROM dbo.T_flight")
    #print(list)
    pass