# StarGen

## 概要
星形成に至るまでの分子雲進化を理解するため,自己重力流体シミュレーションを解析する.

## 研究環境
- Windows10
- Python3
- Jupyter Notebook

## 詳細
### datasets
各時刻におけるガス雲のデータ.  
例えば400.npzには,0.5702Myrにおけるガス質量が視線速度×位置×位置の三次元空間に格納されている.

### media
解析の結果得られた図をまとめている.

### paper
論文等をTypstで作成するためのフォルダ.  
typファイルとpdfファイルをまとめている.

### slide
スライドをMarpで作成するためのフォルダ.  
mdファイルとpdfファイルをまとめている.

### dendro2D
ガス質量を視線速度方向に積分した積分強度図に対してDendrogramによる解析を行うためのNotebook.  
例えばdendro2D_400ではm400について解析を行っている.

### dendro3D
ガス質量を三次元空間にプロットした散布図に対してDendrogramによる解析を行うためのNotebook.  
例えばdendro3D_400ではm400について解析を行っている.

### discuss_2D
dendro2Dの解析結果から図を作成するためのNotebook.

### discuss_3D
dendro3Dの解析結果から図を作成するためのNotebook.

### mass_function
ガス質量からmass funcitonを作成するためのNotebook.

## 参考
[天文データ解析入門](https://qiita.com/Shinji_Fujita/items/ecb869e5b6a9fa468483)  
[astrodendroドキュメント](https://dendrograms.readthedocs.io/en/stable/)

## 著者
B4.北海道出身.  
[著者Instagram](https://www.instagram.com/melan_cozmo/)
