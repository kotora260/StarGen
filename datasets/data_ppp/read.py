import h5py
import numpy as np

cgs_mp    = 1.672621777e-24      # 陽子質量 (in g)
cgs_me    = 9.10938291e-28       # 電子質量 (in g)
cgs_xmh   =  cgs_mp + cgs_me     # 水素原子質量 (in g) 近似的に正しい。
yHe       = 9.7222222e-2 # Helium abundance
mu        = (1.e0+4.e0*yHe)*cgs_xmh

def get_data(filename):
  d = {}
  with h5py.File(filename, "r") as data:
    data_list = list(data)
    for ls in data_list:
      d[ls] = data[ls][()]
  return d

# 使用例
d = get_data("./cb1000.h5")

Ni    = d["dimension1"]   # x方向のセル数
Nj    = d["dimension2"]   # y方向のセル数
Nk    = d["dimension3"]   # z方向のセル数
hx    = d["space1"]       # x方向のセル長 [pc]
hy    = d["space2"]       # y方向のセル長 [pc]
hz    = d["space3"]       # z方向のセル長 [pc]

T     = d["T"]      # ガス温度  [K]
Td    = d["Td"]     # ダスト温度[K]
vx    = d["vx"]     # x 方向の速度 [km/s]
vy    = d["vy"]     # y 方向の速度 [km/s]
vz    = d["vz"]     # z 方向の速度 [km/s]
nH    = d["nH"]     # ガス数密度 [cm^-3]
rho   = nH*mu       # ガス密度 [g/cm^3]


