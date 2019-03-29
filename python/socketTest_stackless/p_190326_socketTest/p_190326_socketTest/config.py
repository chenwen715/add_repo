# -*- coding:utf-8 -*-
import configparser
import os

class myconfig(object):

    def __init__(self):
        self.currentpath=os.getcwd()
        self.getFileData()

    def getFileData(self):
        '''
        获取文件config.ini中的内容
        e.g.
        [db]
        driver:SQL Server Native Client 11.0
        server:127.0.0.1
        user:sa
        password:abc123*
        database:ACS_MNLM
        '''
        if "conf.ini" in os.listdir(self.currentpath):
            self.cf=configparser.ConfigParser()
            #read读取文件内容
            self.cf.read("conf.ini")
            #sections()得到所有的section，并以列表的形式返回，即[db]
            self.secs = self.cf.sections()
        else:
            print("无配置文件conf.ini")


    def getDB(self):
        '''
        获取数据库信息
        '''
        section="db"
        return self.getData(section)

    def getServer(self):
        '''
        获取服务端信息
        '''
        section="server"
        return self.getData(section)

    def getTime(self):
        '''
        获取等待时间信息
        '''
        section="wait_time"
        return self.getData(section)

    def getData(self,section):
        '''
        获取指定信息
        '''
        kvs={}
        if not len(self.secs)==0:
            if section in self.secs:
                #options(section)得到该section的所有option
                #opts = cf.options('db')
                #items(section)得到该section的所有键值对
                for x in self.cf.items(section):
                    kvs[x[0]]=x[1]
                return kvs
            else:
                print("文件中无%s信息"%section)
        else:
            print("文件中无信息")

if __name__=="__main__":
    c=myconfig()
    print(c.getDB())
