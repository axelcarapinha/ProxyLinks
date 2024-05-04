from selenium import webdriver
from selenium.webdriver.firefox.options import Options

SYSTEM_PROXY=5 # number checked on about:config firefox "page"

options = Options()
options.headless = True # not visible, because it's for the configs
driver = webdriver.Firefox(options=options)

driver.set_preference("network.proxy.type", SYSTEM_PROXY)
driver.set_preference("network.proxy.no_proxies_on", "localhost, 127.0.0.1")

driver.quit()