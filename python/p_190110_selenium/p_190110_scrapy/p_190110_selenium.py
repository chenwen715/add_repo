from selenium import webdriver
import unittest
import time 
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.by import By

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
        button.click()
        waiter=WebDriverWait(self.wb,5)
        waiter.until(EC.presence_of_element_located((By.CSS_SELECTOR,"[class='t c-title-en']")))



if __name__=="__main__":
    try:
        unittest.main()
    except Exception as e:
        print(e)