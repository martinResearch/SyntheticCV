import urllib
import os
import subprocess
import platform
import zipfile
system=platform.system()
dowloadProjectZip=False

if system=='Windows':
    pass



elif system=='Darwin':
    pass

elif system=='Linux':   
    #print 'dowloading images'    
    ##urllib.urlretrieve ("http://redwood-data.org/indoor/data/livingroom1-color.zip","./data/livingroom1-color.zip")
    #subprocess.call('wget http://redwood-data.org/indoor/data/livingroom1-color.zip -P ./data/',shell=True)# better as there are progress display
    #print 'extracting images from zip file'
    #fh = open('./data/livingroom1-color.zip', 'rb')
    #z = zipfile.ZipFile(fh)
    #z.extractall('./data/livingroom')
    #fh.close()   
    #print 'deleting zip file'
    #os.remove('./data/livingroom1-color.zip') 
    #print 'getting camera trajectory'
    #subprocess.call('wget http://redwood-data.org/indoor/data/livingroom1-traj.txt -P ./data/',shell=True)
    #print 'gettign mesh model'
    #subprocess.call('wget http://redwood-data.org/indoor/data/livingroom.ply.zip -P ./data/',shell=True)
    #print 'extracting mesh from zip file'
    fh = open('./data/livingroom.ply.zip', 'rb')
    z = zipfile.ZipFile(fh)
    z.extractall('./data/')
    fh.close()   
    print 'deleting zip file'
    os.remove('./data/livingroom.ply.zip')     
