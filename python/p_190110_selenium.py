from selenium import webdriver
import unittest
import time 

class BaiDuTestCase(unittest.TestCase):
    def setUp(self):
        self.wb=webdriver.Chrome()
        self.wb.get("http://www.baidu.com")

    def tearDown(self):
        self.wb.close()

    def test_indexpage(self):
        inputbox=self.wb.find_element_by_id("kw")
        inputbox.send_keys("python")
        time.sleep(2)
        button=self.wb.find_element_by_id("su")
        time.sleep(1)



if __name__=="__main__":
    try:
        unittest.main()
    except Exception as e:
        print(e)
