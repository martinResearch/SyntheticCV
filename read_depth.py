
import matplotlib.pyplot as plt
from scipy.misc import imsave,imread

import numpy as np

file='./data/office/office-focalblur/office-left/office_stereo1_megapov.depth'

depth=np.fromfile(file,dtype=np.float)
depth2=depth.byteswap()# the data is save in the little indian forma tin the file
depth3=depth2.reshape((240,320))
depth4=np.minimum(depth3,800 )
plt.ion()
plt.imshow(depth4)
imsave('images/depth_left.png', depth4)
print 'done'

file_occ='./data/office/office-focalblur/office-left/office_stereo1_megapov.office_stereo2_megapov.occ.tif'
occ=imread(file_occ)
imsave('images/occlusion.png', occ)

file_mx='./data/office/office-focalblur/office-left/office_stereo1_megapov.office_stereo2_megapov.mx.tif'
plt.subplot(1,2,1)
mx=imread(file_mx)
plt.imshow(mx)
imsave('images/motionfield_mx.png', mx)

file_my='./data/office/office-focalblur/office-left/office_stereo1_megapov.office_stereo2_megapov.my.tif'
my=imread(file_my)
plt.subplot(1,2,2)
plt.imshow(my)
imsave('images/motionfield_my.png', my)