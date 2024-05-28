from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.firefox.options import Options

#! Firefox new profile' session startup settings
#! (NO data from the normal profile is ever changed)
SYSTEM_PROXY = 5  # number checked on about:config firefox "page"
IDX_WORKING_WINDOW = 1

class InvalidProxyOption(Exception):
	pass

def set_proxy_with_option(options, profile, opt_number):	
	if not opt_number:
		raise InvalidProxyOption("opt number is null. Please, use a valid value.")
	
	profile.set_preference("network.proxy.type", opt_number)
	profile.set_preference("network.proxy.no_proxies_on", "localhost, 127.0.0.1")
	options.profile = profile # Use the options when launching Firefox

def clear_browsing_data_on_exit(profile):
    profile.set_preference("browser.privatebrowsing.autostart", True)
    profile.set_preference("privacy.clearOnShutdown.history", True)
    profile.set_preference("privacy.clearOnShutdown.cookies", True)

# Create a new profile for browsing
options = Options()
profile = webdriver.FirefoxProfile() 

set_proxy_with_option(options, profile, SYSTEM_PROXY)	
clear_browsing_data_on_exit(profile)

# Permit the usage in non-graphical environment
options.headless = True

# Apply and locate
driver = webdriver.Firefox(options=options) 
driver.get("https://whatismyipaddress.com/")

driver.find_element_by_tag_name('body').send_keys(Keys.CONTROL + 't')
driver.switch_to.window(driver.window_handles[IDX_WORKING_WINDOW])

print("Firefox profile with proxy enabled created.")



