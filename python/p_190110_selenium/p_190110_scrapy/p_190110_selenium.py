from selenium import webdriver
import unittest
import time 
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.select import Select
from selenium.common import exceptions
import requests
from bs4 import BeautifulSoup
from fake_useragent.fake import UserAgent

class BaiDuTestCase(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        ua=UserAgent().random
        cls.headers={"User-Agent":ua}
        cls.wb=webdriver.Chrome()
        cls.wb.maximize_window()
        cls.wb.implicitly_wait(5)
        '''隐式等待和显示等待都存在时，超时时间取二者中较大的'''
        cls.wb.get("https://www.baidu.com")


    @classmethod
    def tearDownClass(cls):
        cls.wb.close()
        cls.wb.quit()


    def test_baiDuLoginIn_1_wrongSecret(self):
        '''测试百度登录，密码错误'''
        self.logIn()
        self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__userName']").clear()
        self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__userName']").send_keys("文")
        time.sleep(1)
        self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__submit']").click()
        errorMsg=self.wb.find_element_by_id("TANGRAM__PSP_10__error").text
        self.wb.find_element_by_id("TANGRAM__PSP_4__closeBtn").click()
        self.assertEqual("请您输入密码",errorMsg)

    def test_baiDuLoginIn_2_noUsername(self):
        '''测试百度登录，用户名为空'''
        self.logIn()
        self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__userName']").clear()
        time.sleep(1)
        self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__submit']").click()
        errorMsg=self.wb.find_element_by_id("TANGRAM__PSP_10__error").text
        self.wb.find_element_by_id("TANGRAM__PSP_4__closeBtn").click()
        self.assertEqual("请您输入手机/邮箱/用户名",errorMsg)

    def test_baiDuLoginIn_3_success(self):
        '''测试百度登录，成功登录'''
        self.logIn()
        self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__userName']").clear()
        self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__userName']").send_keys("a")
        self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__password']").send_keys("1")
        checkbx=self.wb.find_element_by_id("TANGRAM__PSP_10__memberPass")
        if checkbx.is_selected():
            checkbx.click()
            WebDriverWait(self.wb,5).until_not(EC.element_to_be_selected(checkbx))                  
        time.sleep(5)
        self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__submit']").click()
        self.assertTrue(WebDriverWait(self.wb,5).until(EC.presence_of_element_located((By.CLASS_NAME,"user-name"))))
    
    def test_baiDuLoginIn_4_alreadyLogIn(self):
         '''测试百度登录，若已登录，则退出登录'''
         if self.isLogIn():
             self.logOut(user)
             self.assertEqual(WebDriverWait(self.wb,5).until(EC.presence_of_element_located((By.CLASS_NAME,"lb"))))
         else:
            print("当前尚未登录，不好测试退出登录")
            return False

    def test_setting(self):
        time.sleep(3)
        setting=self.wb.find_element_by_class_name("pf")

        #move_to_element不好用时，使用以下方法移动鼠标
        js = """
        var evObj = document.createEvent('MouseEvents'); 
        evObj.initMouseEvent(\"mouseover\",true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
        arguments[0].dispatchEvent(evObj);"""
        self.wb.execute_script(js, setting)

        #ActionChains(self.wb).move_to_element(setting).perform()

        time.sleep(2)
        WebDriverWait(self.wb,5).until(EC.presence_of_element_located((By.CSS_SELECTOR,"[class='pf pfhover']")))
        highlevelsearch=self.wb.find_element_by_xpath("//*[@id='wrapper']/div[6]/a[2]")
        ActionChains(self.wb).move_to_element(highlevelsearch).perform()
        time.sleep(2)
        highlevelsearch.click()
        time.sleep(3)
        WebDriverWait(self.wb,5).until(EC.presence_of_element_located((By.CSS_SELECTOR,"[class='bdlayer pfpanel']")))
        self.wb.find_element_by_css_selector("[class='pfpanelclose close briiconsbg']").click()
        time.sleep(3)
        self.assertTrue(WebDriverWait(self.wb,5).until(EC.invisibility_of_element_located((By.CSS_SELECTOR,"[class='bdlayer pfpanel']"))))

    def isLogIn(self):
        '''判断当前是否已经登录'''
        WebDriverWait(self.wb,5).until(EC.presence_of_element_located((By.ID,"lg")))
        #time.sleep(5)
        try:
            user=self.wb.find_element_by_class_name("user-name")
            print("当前已登录，需退出后重新登录")
            return True
        except exceptions.NoSuchElementException: 
            print("当前未登录，点击登录")
            return False

    def logOut(self,user):
        '''退出登录操作'''
        js = """
        var evObj = document.createEvent('MouseEvents'); 
        evObj.initMouseEvent(\"mouseover\",true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
        arguments[0].dispatchEvent(evObj);"""
        self.wb.execute_script(js, user)
        #ActionChains(self.wb).move_to_element(user).perform()等价于上两句，但谷歌浏览器中move_to_element可能不好用
        quit=self.wb.find_element_by_class_name("quit")
        ActionChains(self.wb).move_to_element(quit).perform()
        quit.click()
        WebDriverWait(self.wb,5).until(EC.presence_of_element_located((By.CLASS_NAME,"sui-dialog-title")))
        self.wb.find_element_by_css_selector("[class='s-btn btn-ok']").click()
        
    def logIn(self):
        '''登录操作'''
        if not self.isLogIn():
            elements=self.wb.find_elements_by_css_selector("#u1 > a")
            for ele in elements:
                #print(ele.text)
                if ele.text=="登录":
                    ele.click()
                    break
        WebDriverWait(self.wb,10).until(EC.presence_of_element_located((By.XPATH,"//*[@id='passport-login-pop']")))
        self.switchPage()

    def switchPage(self):
        '''若当前为扫描登录，则切换页面至用户名密码登录'''
        #print(dir(self.wb.find_element_by_class_name('pass-form-logo')))
        #print(self.wb.find_element_by_class_name('pass-form-logo').is_displayed())查看元素是否被隐藏，若隐藏则无法使用element.text获取元素文本，此时可使用以下3种方法
        #print(self.wb.find_element_by_class_name('pass-form-logo').get_attribute("innerText"))#只会得到文本内容，而不会包含 HTML 标签，FireFox不支持
        #print(self.wb.find_element_by_class_name('pass-form-logo').get_attribute("textContent"))#只会得到文本内容，而不会包含 HTML 标签，IE 不支持
        #print(self.wb.find_element_by_class_name('pass-form-logo').get_attribute("innerHTML"))#返回元素的内部 HTML， 包含所有的HTML标签

        #print(self.wb.find_element_by_class_name('tang-pass-qrcode-img').is_displayed())#True
        #print(self.wb.find_element_by_class_name('pass-form-logo').is_displayed())#False
        #self.wb.find_element_by_xpath("//*[@id='TANGRAM__PSP_10__footerULoginBtn']").click()
        #print(self.wb.find_element_by_class_name('tang-pass-qrcode-img').is_displayed())#False
        #print(self.wb.find_element_by_class_name('pass-form-logo').is_displayed())#True
        if self.wb.find_element_by_class_name('tang-pass-qrcode-img')!=None and self.wb.find_element_by_class_name('tang-pass-qrcode-img').is_displayed():
            #print(self.wb.find_element_by_id('TANGRAM__PSP_10__submit').is_displayed())#False
            self.wb.find_element_by_id("TANGRAM__PSP_10__footerULoginBtn").click()
            WebDriverWait(self.wb,10).until(EC.invisibility_of_element_located((By.CLASS_NAME,'tang-pass-qrcode-img')))
            #print(self.wb.find_element_by_id('TANGRAM__PSP_10__submit').is_displayed())#True
            WebDriverWait(self.wb,10).until(EC.presence_of_element_located((By.ID,'TANGRAM__PSP_10__submit')))    



class XieChengTest(unittest.TestCase):
    def setUp(self):
        ua=UserAgent().random
        self.headers={"User-Agent":ua}
        self.wb=webdriver.Chrome()
        self.wb.maximize_window()
        self.wb.get("https://www.baidu.com")
       

    def tearDown(self):
        self.wb.close()
        self.wb.quit()

    def test_indexpage(self):
        '''测试携程首页'''
        self.startIndexPage()

    def test_hotelpage(self):
        self.startIndexPage()

        #这3句相当于self.wb.page_source方法
        #href=self.wb.current_url
        #response=requests.get(href,headers=self.headers)
        #soup=BeautifulSoup(response.content,"lxml")

        soup=BeautifulSoup(self.wb.page_source,"lxml")
        idlist=[(el.attrs["id"],el.attrs["href"]) for el in soup.select("#cui_nav_ul > li > a")]
        subidlist={}
        #for id in idlist:
        #    sublist=soup.select("{0}> li >a['id']".format(id))
        #    subidlist[id[0]]=sublist
        for i in idlist:
            with self.subTest(i=i):
                if not "log" in i:
                    self.wb.find_element_by_id(i[0]).click()
                    time.sleep(5)
                    self.assertEqual(i[1],self.wb.current_url,"网址不一致")

    def test_guoNeiJiuDian(self):
        '''测试携程国内酒店'''
        self.startIndexPage()
        WebDriverWait(self.wb,10).until(EC.visibility_of_any_elements_located((By.CLASS_NAME,"s_content")))
        self.wb.find_element_by_id("HD_CityName").clear()
        self.wb.find_element_by_id("HD_CityName").send_keys("苏州")
        roomCount=self.wb.find_element_by_id("J_roomCountList")
        Select(roomCount).select_by_value("3")
        print(Select(roomCount).all_selected_options[0].text)#3间
        print(Select(roomCount).all_selected_options[0].get_attribute("value"))#3
        hotelLevel=self.wb.find_element_by_id("searchHotelLevelSelect")
        for i in Select(hotelLevel).options:
            if i.text==u"四星级/高档":
                #Select(hotelLevel).select_by_value(i.get_attribute("value"))#通过value属性选择
                Select(hotelLevel).select_by_visible_text(u"四星级/高档")#通过文本选择，全匹配
                #Select(hotelLevel).select_by_index(Select(hotelLevel).options.index(i))#通过下标选择
        print(Select(hotelLevel).all_selected_options[0].text)#四星级/高档
        print(Select(hotelLevel).all_selected_options[0].get_attribute("value"))#4

    def test_tujiagongyu(self):
        '''测试携程途家公寓'''
        self.startIndexPage()
        ActionChains(self.wb).move_to_element(self.wb.find_element_by_id("cui_nav_hotel")).perform()
        WebDriverWait(self.wb,10).until(EC.presence_of_element_located((By.CLASS_NAME,"cui_nav_o")))
        ActionChains(self.wb).move_to_element(self.wb.find_element_by_id("c_ph_tujia_h")).click().perform()
        time.sleep(2)
        print(self.wb.current_url)
        frame=self.wb.find_element_by_class_name("tj_iframe")
        self.wb.switch_to_frame(frame)
        WebDriverWait(self.wb,10).until(EC.text_to_be_present_in_element((By.CLASS_NAME,"column-naem"),"途家"))
        destination=self.wb.find_element_by_class_name("ipt-text")
        destination.clear()
        city="苏州"
        destination.send_keys(city)
        WebDriverWait(self.wb,10).until(EC.presence_of_element_located((By.CLASS_NAME,"key-roteline")))
        self.wb.find_element_by_class_name("key-roteline").click()
        time.sleep(3)
        startDate=self.wb.find_element_by_id("startDate")
        startDate.click()
        self.wb.find_element_by_xpath("//*[@id='calcontent']/div/div[1]/table/tbody/tr[3]/td[6]").click()
        time.sleep(2)
        print(startDate.get_attribute("value"))
        ##WebDriverWait(self.wb,10).until(EC.presence_of_element_located((By.CLASS_NAME,"calendar")))
        #startDate.send_keys("2019-01-18")
        #time.sleep(3)
        endDate=self.wb.find_element_by_id("endDate")
        endDate.click()
        time.sleep(2)
        eday=self.wb.find_element_by_xpath("//*[@id='calcontent']/div/div[1]/table/tbody/tr[4]/td[4]").text
        self.wb.find_element_by_xpath("//*[@id='calcontent']/div/div[1]/table/tbody/tr[4]/td[4]").click()
        time.sleep(2)
        print(eday)
        print(endDate.get_attribute("value"))

        self.wb.find_element_by_class_name("search-btn").click()
        self.assertEqual(city,self.wb.find_element_by_id("cityBooking").get_attribute("value"))


    def startIndexPage(self):
        '''携程首页'''
        inputbox=self.wb.find_element_by_id("kw")
        inputbox.send_keys("携程")
        time.sleep(2)
        button=self.wb.find_element_by_id("su")
        button.click()
        waiter=WebDriverWait(self.wb,10)
        waiter.until(EC.presence_of_element_located((By.CLASS_NAME,"favurl")))
        self.wb.find_element_by_class_name("favurl").click()
        time.sleep(5)
        self.switch_to_win("官网")
        WebDriverWait(self.wb,10).until(EC.presence_of_element_located((By.CLASS_NAME,"base_nav")))
        #return self.wb

    def switch_to_win(self,title):
        '''切换至最新页签'''
        for handle in self.wb.window_handles:
            self.wb.switch_to_window(handle)
            if title in self.wb.title:
                return True 
            else:
			    #返回父frame
                self.wb.switch_to_default_content()

if __name__=="__main__":
    try:
        suite=unittest.TestSuite()
        #suite.addTest(BaiDuTestCase("test_baiDuLoginIn"))
        load=unittest.TestLoader()       
        #suite.addTests(load.loadTestsFromTestCase(BaiDuTestCase))
        suite.addTests(load.loadTestsFromName("p_190110_selenium.BaiDuTestCase.test_setting"))
        #suite.addTests(load.loadTestsFromName("p_190110_selenium.XieChengTest.test_guoNeiJiuDian"))
       
        '''不能分开写成(报错)
        #load.loadTestsFromName("p_190110_selenium.BaiDuTestCase.test_setting")
        #suite.addTests(load)
        '''
        runner=unittest.TextTestRunner(verbosity=2)
        runner.run(suite)
        


    except Exception as e:
        print(e)