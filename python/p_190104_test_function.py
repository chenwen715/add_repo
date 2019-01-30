#  -*- coding:utf-8 -*-
import unittest
import ddt
from p_190103_function import *
import p_190103_function

class InputError(TypeError):pass

@ddt.ddt
class TestWhichDay(unittest.TestCase):
    '''测试WhichDay函数正确性'''
    ndata=({"input":19940110,"output":10}, \
            {"input":19950208,"output":39}, \
            {"input":19960321,"output":81}, \
            {"input":19970402,"output":92}, \
            {"input":19980512,"output":132}, \
            {"input":19990622,"output":173}, \
            {"input":20000705,"output":187}, \
            {"input":20010815,"output":227}, \
            {"input":20020925,"output":268}, \
            {"input":20031006,"output":279}, \
            {"input":20041116,"output":321}, \
            {"input":20051226,"output":360})
    indata=({"input":9940110,"output":p_190103_function.InputError}, \
            {"input":19850229,"output":p_190103_function.InputError}, \
            {"input":16451305,"output":p_190103_function.InputError}, \
            {"input":"123","output":TypeError})

    def test_normalcase(self):
        '''使用subTest测试多条正常数据'''
        for i in self.ndata:
            with self.subTest(i=i):
                self.assertEqual(i["output"],whichDay(i["input"]))

    @ddt.data(*ndata)
    def test_normalcase_1(self,value):
        '''使用ddt测试多条正常数据'''
        self.assertEqual(value["output"],whichDay(value["input"]))

    @ddt.data(*indata)
    def test_innormalcase(self,value):
        '''使用ddt测试多条非正常数据'''
        self.assertRaises(value["output"],whichDay,value["input"])


if __name__=="__main__":
    unittest.main()
