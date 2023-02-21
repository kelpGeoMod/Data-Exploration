# Tested on Python 3
#!/usr/bin/python
from http.cookiejar import CookieJar
import urllib


# The user credentials that will be used to authenticate access to the data

username = "jfrench_6"
password = "Happyday1!"


# The url of the file we wish to retrieve

url = "https://daacdata.apps.nsidc.org/pub/DATASETS/nsidc0192_seaice_trends_climo_v3/total-ice-area-extent/nasateam/gsfc.nasateam.month.anomaly.area.1978-2021.s"


# Create a password manager to deal with the 401 reponse that is returned from
# Earthdata Login

password_manager = urllib.request.HTTPPasswordMgrWithDefaultRealm()
password_manager.add_password(None, "https://urs.earthdata.nasa.gov", username, password)


# Create a cookie jar for storing cookies. This is used to store and return
# the session cookie given to use by the data server (otherwise it will just
# keep sending us back to Earthdata Login to authenticate).  Ideally, we
# should use a file based cookie jar to preserve cookies between runs. This
# will make it much more efficient.

cookie_jar = CookieJar()


# Install all the handlers.

opener = urllib.request.build_opener(
    urllib.request.HTTPBasicAuthHandler(password_manager),
    #urllib.request.HTTPHandler(debuglevel=1),    # Uncomment these two lines to see
    #urllib.request.HTTPSHandler(debuglevel=1),   # details of the requests/responses
    urllib.request.HTTPCookieProcessor(cookie_jar))
urllib.request.install_opener(opener)


# Create and submit the request. There are a wide range of exceptions that
# can be thrown here, including HTTPError and URLError. These should be
# caught and handled.

request = urllib.request.Request(url)
response = urllib.request.urlopen(request)


# Print out the result (not a good idea with binary data!)

body = response.read()
print(body)