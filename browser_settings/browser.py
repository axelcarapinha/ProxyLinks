from selenium import webdriver
from selenium.webdriver.firefox.options import Options

SYSTEM_PROXY = 5  # number checked on about:config firefox "page"

def set_proxy_with_option(options, profile, opt_number):	
	
	profile.set_preference("network.proxy.type", opt_number)
	profile.set_preference("network.proxy.no_proxies_on", "localhost, 127.0.0.1")
	
	options.profile = profile # Use the options when launching Firefox

# Define the user instances
options = Options()
profile = webdriver.FirefoxProfile()

options.headless = True	
set_proxy_with_option(options, profile, SYSTEM_PROXY)	
options.headless = False 

# Apply and quit
driver = webdriver.Firefox(options=options)

print("Firefox proxy settings successfully changed.")
driver.quit()
