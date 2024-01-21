#import "@preview/physica:0.9.0": *
#import "@preview/metro:0.1.1": *

#import "./template.typ": *

#show: master_thesis.with(

  title: "分子雲の構造進化の理解に向けた自己重力流体シミュレーションの解析",
  author: "佐々木誇虎",
  university: "筑波大学",
  school: "理工学群",
  department: "物理学類",
  id: "202011722",
  mentor: "久野成夫",
  mentor-post: "",
  class: "卒業",

  abstract_ja: [
      星形成は分子ガスの塊である分子雲で起こることがわかっているが，分子雲がどのような構造をとりながら星形成に至るかという詳細な進化過程はまだ明らかになっていない．星形成に至る分子雲の進化過程を理解するためには，観測に加え，シミュレーションを用いた研究が重要である．シミュレーションは観測と比較して，時間発展に伴う構造の変化を追跡することが容易である．故に分子雲進化のシミュレーションを解析することは，星形成を詳細に理解する上で有効な手段である．
      
      #set par(first-line-indent: 1em, justify: true)
      
      本研究では，分子雲進化を想定した自己重力流体シミュレーションを観測的研究でしばしば用いられるDendrogramを用いて解析することで，シミュレーションにおける分子雲内の構造進化を調べた．対象のデータは四つの時点に分かれており，それぞれ視線速度，位置，位置からなる三次元空間にガスの質量が格納されている．解析は観測データと同じようにデータを視線方向に積分した積分強度図と，三次元散布図それぞれに対して行った．
      
      解析の結果，積分強度図において同定された構造のうち，最も外側の構造については自己重力により収縮していく様子が確認できた．またこの構造のビリアルパラメータの推移から，分子雲全体としてビリアル平衡に近づいていることがわかった．また内部構造については，そのサイズと質量が増加と減少を繰り返していることがわかった．三次元散布図の解析結果からは，同定された各構造のサイズと質量が増加と減少を繰り返していることがわかった．一方で時間発展につれ比較的大きな構造が生じ，成長していく様子も見られた．
      
      以上の解析結果から，シミュレーションにおける分子雲進化の構造について，自己重力による収縮が平衡に近づき，内部では小規模な構造がより大きい構造へ成長するという，より詳細なシナリオを推定することが可能になった．
  ]
)

= 序論

== 星間物質と星形成

=== 星間物質

宇宙空間には星と星の間に様々な星間物質が存在している．星間物質は星間ガスや星間ダストからなり，密度や温度の違いによって分類されている．@img:interstellar_matter に様々な密度，温度における星間物質を掲載する．

#img(
  image("interstellar_matter.png", width: 70%),
  caption: [様々な密度，温度での星間物質(天文学辞典(日本天文学会))],
) <img:interstellar_matter>\

=== 分子雲と星形成

星間物質のうち，最も密度が高い星間ガスは分子雲と呼ばれる．分子雲は低温なため，内部では水素が分子の状態で存在している．分子雲中で特に密度が高い領域は分子雲コアと呼ばれる．分子雲コアは重力的に不安定なため，その中心部で星形成が行われると考えられている．だがそのようなコアがどのような構造を経て生じ，星形成に至るかという詳細なシナリオはまだ明らかになっていない．

=== ビリアルパラメータ

分子雲では自身の内圧など外へ広がろうとする力と，自己重力など内へ収縮しようとする力がはたらいている．この二つの力がつり合っている状態をビリアル平衡と呼ぶ．ビリアルパラメータは，分子雲が平衡にどの程度近いかを評価する際に用いられる指標である．ビリアルパラメータは以下のような式で表せる．

$ alpha_("Gvir") = (5sigma^2R) / (3G M) $ <eq:vir>

ここで$sigma$は分子雲の三次元速度分散 [#unit("km/s")]，$R$は分子雲の半径 [$"pc"$]，$G$は万有引力定数，$M$は分子雲の質量 [$M_⊙$]である．

分子雲内部で外へ広がろうとする力が強くはたらいている状態では，ビリアルパラメータの値は$alpha_("Gvir") >> 1$である．その状態から分子雲が重力平衡に近づくと値は$alpha_("Gvir") = 1$へ近づいていく．

== 星形成の研究手法

星形成の研究は，観測とシミュレーションの二つのアプローチがある．

=== 観測を用いた研究

分子雲コアに代表されるような星形成領域の観測は，これまで盛んにおこなわれてきた．

例えばTokuda, et al. 2020やKondo, et al. 2021では，M33北部に存在するGMC-8，NGC 604，GMC-16の3つの分子雲をALMAにより観測して構造や質量を比較している．@img:gmc_example にM33北部の$isotope("CO",a:12) (J=2-1)$積分強度図とH$alpha$輝線を示す．図中でこれら3つの分子雲の位置が同定されている．Tokuda, et al. 2020では，HII領域を伴うGMC-16が@img:gmc-16 に示すような大規模なフィラメント構造を持つことが示されている．一方でKondo, et al. 2021では，星形成が不活発なGMC-8が@img:gmc-8 に示すような円形に広がった構造を持つことなどが示されている．

#img(
  image("gmc_example.png", width: 100%),
  caption: [(a)M33北部の$isotope("CO",a:12) (J=2-1)$積分強度図．(b)M33北部のH$alpha$輝線．(Kondo, et al. 2021)],
) <img:gmc_example>

#img(
  image("gmc-16.png", width: 100%),
  caption: [(a)M33 GMC-16の$isotope("CO",a:12) (J=2-1)$積分強度図．(b)同分子雲の$isotope("CO",a:13) (J=2-1)$積分強度図．(Tokuda, et al. 2020)],
) <img:gmc-16>

#img(
  image("gmc-8.png", width: 100%),
  caption: [(a)M33 GMC-8の$isotope("CO",a:12) (J=2-1)$積分強度図．(b)同分子雲の$isotope("CO",a:13) (J=2-1)$積分強度図．(Kondo, et al. 2021)],
) <img:gmc-8>\

このように，観測を用いた研究では複数の分子雲を比較してその進化段階を相対的に評価することとなる．反対に，単一の分子雲の観測データのみからでは，構造進化を理解するのは困難である．分子雲が収縮し星となるまでに要する時間は#num(1,e:5,print-unity-mantissa:false)年から#num(1,e:6,print-unity-mantissa:false)年であり，観測データはその長い時間における一時点の情報に過ぎないからである．

=== シミュレーションを用いた研究

シミュレーションを用いて研究する場合，そのシミュレーションが観測データを再現するものであることが重要である．多様な観測データを再現するため，シミュレーションにおいては自己重力流体に対して様々なモデルを仮定する．

星形成の研究では，この自己重力流体のモデルに応じて星形成機構を探ることが多い．例えばFederrath et al.(2012)では，星形成率(SFR)に関する6つの理論モデルを磁場を含む形に拡張して解析し，SFRと他のパラメータの依存性について調べている．

一方，流体の中で分子雲コアに対応するシンク粒子などの構造がどのような過程を経て形成されるかについては，まだあまり考えられていなかった．前項で述べたように，観測データのみを用いて単一の分子雲の構造進化を追うことは難しい．しかし，観測データを十分に再現したシミュレーションであれば，自己重力流体の時間発展を解析することで，このような構造進化の研究を容易に行うことができる．

== 本研究の目的

本研究では，星形成に至るまでの分子雲進化の詳細な理解を目的とする．この目的を達成するため，自己重力流体シミュレーションの解析を行う．解析においては時間発展に伴う流体の構造の変化に注目する．また解析の手法として，観測データに対し頻繁に用いられる手法をシミュレーション対して用いることで，実際の観測データとの比較がこれまでより容易になると考える．得られた解析結果から分子雲進化のシナリオを推定し，星形成過程のより詳細な理解を目指す．

= 対象データ

== シミュレーション概要

本研究で解析の対象としたのは，筑波大学宇宙理論研究室の福島肇助教により行われた，SFUMATOを用いて計算された自己重力流体シミュレーションである．SFUMATOは自己重力MHD問題を解くための天体物理シミュレーションコードである．コードの詳細は"Sfumato AMR"(https://redmagic.i.hosei.ac.jp/research/sfumato/)に記載されている．

シミュレーションは磁場のない一様な分子雲を想定して質量#num(1,e:6,print-unity-mantissa:false) $M_⊙$，面密度$350$ $M_⊙$ $"pc"^(-2)$，半径$30$ $"pc"$の一様な流体の球を自己重力により変化させた．



== データ詳細

本研究では，先述のシミュレーションのうち，それぞれ$0.57$ Myr，$1.1$ Myr，$1.7$ Myr，$2.2$ Myrの時点における質量のデータを福島助教に提供していただき，解析した．これらのデータは観測データとの比較が容易な，視線速度，位置，位置からなる三次元データである．$40$×$65$×$65$個のボクセルの中に質量が数値として格納されている．また1つのボクセルは#qty(0.65,"km/s")×$1.4$ $"pc"$×$1.4$ $"pc"$の三次元空間に相当する．

解析はこのデータを視線速度方向に積分した積分強度図と，もとのデータをそのまま三次元空間にプロットした散布図に対して行った．

@img:int_map_400 から@img:int_map_2800 にそれぞれの時点における積分強度図を示す．

#img(
  image("c:media/int_map_400.png", width: 70%),
  caption: [0.57 Myrの積分強度図],
) <img:int_map_400>

#img(
  image("c:media/int_map_1000.png", width: 70%),
  caption: [1.1 Myrの積分強度図],
) <img:int_map_1000>

#img(
  image("c:media/int_map_2200.png", width: 70%),
  caption: [1.7 Myrの積分強度図],
) <img:int_map_2200>

#img(
  image("c:media/int_map_2800.png", width: 70%),
  caption: [2.2 Myrの積分強度図],
) <img:int_map_2800>\

@img:3Dmap_400 から@img:3Dmap_2800 にそれぞれの時点における三次元散布図を示す．なおガスの構造がわかりやすいよう，プロットは質量が$40$ $M_⊙$以上のボクセルに対して行った．

#img(
  image("c:media/3Dmap_400.png", width: 70%),
  caption: [0.57 Myrの三次元散布図],
) <img:3Dmap_400>

#img(
  image("c:media/3Dmap_1000.png", width: 70%),
  caption: [1.1 Myrの三次元散布図],
) <img:3Dmap_1000>

#img(
  image("c:media/3Dmap_2200.png", width: 70%),
  caption: [1.7 Myrの三次元散布図],
) <img:3Dmap_2200>

#img(
  image("c:media/3Dmap_2800.png", width: 70%),
  caption: [2.2 Myrの三次元散布図],
) <img:3Dmap_2800>\

= 解析方法

== Dendrogram概要

本研究では，Dendrogramを用いて構造の同定を行っていく．

Dendrogramは，多次元のデータセットにおける階層構造を樹形図上に分類するアルゴリズムである．それぞれの階層は,内部に構造を持たない最小構造であるリーフ(leaf)と，内部に構造を持つブランチ(branch)に分類される．また最も上位の構造をトランク(trunk)と呼ぶ．詳細は"Astronomical Dendrograms in Python"(https://dendrograms.readthedocs.io/en/stable/)に記載されている．

解析対象のデータにおいては，ガスの質量が大きい部分ほどより多くの内部構造を持つ．

#img(
  image("dendrogram_example.png", width: 70%),
  caption: [Dendrogramによる階層構造],
) <img:dendrogram_example>\

== アルゴリズム詳細

Dendrogramのアルゴリズムにおいては，最大値を持つピクセルから分類が始まり，徐々に他のピクセルが構造に加えられていく．

@img:dendrogram_step1 から@img:dendrogram_step4 は，1変数のデータを例にとってDendrogramのアルゴリズムについて図示したものである．まずアルゴリズムはデータの最大値を検出する(@img:dendrogram_step1)．その後アルゴリズムはcurrent valueを最大値から降下させ，その最大値をピークに持つリーフを生成する．current valueが二つ目のピークに到達した段階で，その値をピークとして，最初に生成していたリーフとは独立した二つ目のリーフが生成される(@img:dendrogram_step2)．current valueが降下を続けると二つのピークが一つの山に結合されるが，それに対応して二つのリーフも一つのブランチに結合される(@img:dendrogram_step3)．同様の手順が繰り返され，結局今回の例ではデータは一つのツリーに結合される(@img:dendrogram_step4)．

#img(
  image("dendrogram_step1.png", width: 70%),
  caption: [Dendrogramによる解析開始],
) <img:dendrogram_step1>

#img(
  image("dendrogram_step2.png", width: 70%),
  caption: [リーフの生成],
) <img:dendrogram_step2>

#img(
  image("dendrogram_step3.png", width: 70%),
  caption: [リーフの結合],
) <img:dendrogram_step3>

#img(
  image("dendrogram_step4.png", width: 70%),
  caption: [解析完了],
) <img:dendrogram_step4>

== パラメータ

Dendrogramを実行する際は，以下の3つのパラメータを設定する必要がある．

- min_value:アルゴリズム実行の際にcurrent valueが到達できる最小の値．これより小さい値を持つピクセルは考慮されない．
- min_delta:current valueに加算される値．この値よりも小さいピークは独立したリーフとはみなされない．
- min_npix:独立したリーフを生成する際に必要なピクセル数の最小値．

@img:dendrogram_mindelta1 や@img:dendrogram_mindelta2 において，current valueがmin_valueよりも下に降下することはない．また@img:dendrogram_mindelta1 では，まだピークは加算されたmin_deltaの幅よりも小さいため，リーフとはみなされていない．その後current valueが降下を続け@img:dendrogram_mindelta2 のようになると，ピークがmin_deltaの幅より大きくなり，ピークはリーフとみなされるようになる．

#img(
  image("dendrogram_mindelta1.png", width: 70%),
  caption: [パラメータ詳細:この段階ではまだリーフは生成されていない],
) <img:dendrogram_mindelta1>

#img(
  image("dendrogram_mindelta2.png", width: 70%),
  caption: [パラメータ詳細:ピークの大きさがmin_deltaを超えるとリーフ生成],
) <img:dendrogram_mindelta2>\

= 解析結果

== 積分強度図の解析結果

まず，積分強度図に対してDendrogramを実行した．パラメータは全時刻に対して同様に以下のように設定した．

- min_value = 400
- min_delta = 120
- min_npix = 15

@img:dendro_400_contour から@img:dendro_2800_contour に同定された構造を示す．赤の線がリーフの輪郭，黄色の線がブランチの輪郭を表している．

#img(
  image("c:media/dendro_400_contour.png", width: 70%),
  caption: [0.57 Myrの積分強度図の解析結果],
) <img:dendro_400_contour>

#img(
  image("c:media/dendro_1000_contour.png", width: 70%),
  caption: [1.1 Myrの積分強度図の解析結果],
) <img:dendro_1000_contour>

#img(
  image("c:media/dendro_2200_contour.png", width: 70%),
  caption: [1.7 Myrの積分強度図の解析結果],
) <img:dendro_2200_contour>

#img(
  image("c:media/dendro_2800_contour.png", width: 70%),
  caption: [2.2 Myrの積分強度図の解析結果],
) <img:dendro_2800_contour>\

== 三次元散布図の解析結果

続いて三次元散布図においてDendrogramを実行した．パラメータは全時刻に対して同様に以下のように設定した．

- min_value = 90
- min_delta = 20
- min_npix = 50

@img:dendro3D_400_contour から@img:dendro3D_2800_contour に同定された構造を示す．赤の表面がリーフの輪郭，黄色の表面がブランチの輪郭を表している．

#img(
  image("c:media/dendro3D_400_contour.png", width: 70%),
  caption: [0.57 Myrの三次元散布図の解析結果],
) <img:dendro3D_400_contour>

#img(
  image("c:media/dendro3D_1000_contour.png", width: 70%),
  caption: [1.1 Myrの三次元散布図の解析結果],
) <img:dendro3D_1000_contour>

#img(
  image("c:media/dendro3D_2200_contour.png", width: 70%),
  caption: [1.7 Myrの三次元散布図の解析結果],
) <img:dendro3D_2200_contour>

#img(
  image("c:media/dendro3D_2800_contour.png", width: 70%),
  caption: [2.2 Myrの三次元散布図の解析結果],
) <img:dendro3D_2800_contour>\



= 議論

== 積分強度図上のトランクの変化 <discuss_trunk>

以下では分子雲の全体像についてその構造進化を議論する．そのために，積分強度図の解析で得られた構造のうち，最外部の構造であるトランクのサイズ，質量，ビリアルパラメータの変化を考察していく．

@img:trunk_size_2D はトランクのサイズ変化のグラフである．グラフから，トランクは徐々に収縮していることがわかる．しかしグラフの傾きに相当する収縮のスピードは減少していることがわかる．

#img(
  image("c:media/trunk_size_2D.png", width: 70%),
  caption: [積分強度図上のトランクのサイズ変化],
) <img:trunk_size_2D>\

@img:trunk_mass_2D はトランクの質量変化のグラフである．グラフから，トランクの質量はサイズとは異なりほぼ線形に減少していることがわかる．質量がこのように減少する原因としては，サイズの減少だけでなく，@img:dendro_400_contour から@img:dendro_2800_contour で定性的に見られるような，トランクの内部におけるフィラメント構造の発達が挙げられる．@img:trunk_int_400 から@img:trunk_int_2800 に，それぞれの時刻におけるトランク内部の質量分布を示す．これらの分布から，トランク内部では時間発展に伴い質量のばらつきが大きくなっていることがわかる．これはフィラメント構造の発達を定量的に示している．フィラメント構造の発達によりトランク内部に穴が開く形となった結果，質量がより急速に減少したと考えられる．

#img(
  image("c:media/trunk_mass_2D.png", width: 70%),
  caption: [積分強度図上のトランクの質量変化],
) <img:trunk_mass_2D>

#img(
  image("c:media/trunk_int_400.png", width: 70%),
  caption: [0.57 Myrにおけるトランク内部の質量分布],
) <img:trunk_int_400>

#img(
  image("c:media/trunk_int_1000.png", width: 70%),
  caption: [1.1 Myrにおけるトランク内部の質量分布],
) <img:trunk_int_1000>

#img(
  image("c:media/trunk_int_2200.png", width: 70%),
  caption: [1.7 Myrにおけるトランク内部の質量分布],
) <img:trunk_int_2200>

#img(
  image("c:media/trunk_int_2800.png", width: 70%),
  caption: [2.2 Myrにおけるトランク内部の質量分布],
) <img:trunk_int_2800>

#img(
  image("c:paper/filament_ponchi.jpg", width: 70%),
  caption: [フィラメント構造発展の模式図],
) <img:filament_ponchi>\

ビリアルパラメータは@eq:vir を用いて算出した．なお$R$はトランクの面積から，トランクを円形と考えることで導出した．また$sigma$はトランク内部の速度スペクトルを足し合わせて最小二乗法を用いてガウスフィッテイングを行い，フィッティング結果の半値幅とした．@img:dv_trunk_2D に速度分散$sigma$の変化を示す． 

#img(
  image("c:media/dv_trunk_2D.png", width: 70%),
  caption: [積分強度図上のトランクの速度分散変化],
) <img:dv_trunk_2D>\

算出したビリアルパラメータの推移を@img:alpha_gvir_trunk_2D に示す．@img:alpha_gvir_trunk_2D より，ビリアルパラメータは徐々に減少しながら1に漸近していることがわかる．よってトランクは徐々にビリアル平衡に向かっていると考えられる．この事実はトランクの収縮スピードが減少している事実に対応する．

#img(
  image("c:media/alpha_gvir_trunk_2D.png", width: 70%),
  caption: [積分強度図上のトランクのビリアルパラメータ変化],
) <img:alpha_gvir_trunk_2D>\

== 積分強度図上の内部構造の変化 <discuss_inner>

以下では分子雲の内部構造についてその構造進化を議論する．そのために，積分強度図の解析で得られた構造のうち，トランク以外の構造のサイズ，質量，ビリアルパラメータの平均値を算出してその変化を考察していく．

サイズ，質量，ビリアルパラメータの平均値の変化を，それぞれ@img:inner_size，@img:inner_mass，@img:inner_vir に示す．なおビリアルパラメータについては，各構造に対してトランクと同様の手順で算出した．

これらのグラフから，内部構造のサイズ，質量，ビリアルパラメータの平均値はすべて増減を繰り返していることがわかる．

#img(
  image("c:media/inner_size.png", width: 70%),
  caption: [積分強度図上の内部構造のサイズの平均値変化],
) <img:inner_size>

#img(
  image("c:media/inner_mass.png", width: 70%),
  caption: [積分強度図上の内部構造の質量の平均値変化],
) <img:inner_mass>

#img(
  image("c:media/inner_vir.png", width: 70%),
  caption: [積分強度図上の内部構造のビリアルパラメータの平均値変化],
) <img:inner_vir>\

== 積分強度図上の各構造のヒストグラム

//ビリアルパラメータのヒストグラムを追加

積分強度図の解析で得られた各構造について，サイズ，質量，ビリアルパラメータのヒストグラムを作成した．結果を@img:size_hist_2D，@img:mass_hist_2D，@img:alpha_givr_hist_2D に示す．青のビンがリーフの個数，オレンジのビンがブランチの個数を表している．

@img:size_hist_2D から，最もサイズの大きいブランチ(トランク)が収縮していることが確認できる．またリーフやトランク以外のブランチについては，サイズの大きい構造の個数と小さい構造の個数が交互に増減していると読み取ることができる．この事実は@discuss_inner で見られるような，サイズの平均値の増減に対応する．

@img:mass_hist_2D や@img:alpha_givr_hist_2D より，質量やビリアルパラメータについても各構造において同様の傾向がみられる．

#img(
  image("c:media/size_hist_2D.png"),
  caption: [積分強度図上の各構造のサイズのヒストグラム],
) <img:size_hist_2D>

#img(
  image("c:media/mass_hist_2D.png"),
  caption: [積分強度図上の各構造の質量のヒストグラム],
) <img:mass_hist_2D>

#img(
  image("c:media/alpha_gvir_hist_2D.png"),
  caption: [積分強度図上の各構造のビリアルパラメータのヒストグラム]
) <img:alpha_givr_hist_2D>\

== 三次元散布図上の各構造の変化 <discuss_3D>

以下では分子雲の内部構造についてより詳細に議論する．そのために，三次元散布図の解析で得られた構造のサイズ，質量，ビリアルパラメータの平均値を算出してその変化を考察していく．

サイズ，質量，ビリアルパラメータの平均値の変化を，それぞれに@img:size_ave，@img:mass_ave，@img:vir_ave に示す．青の線がリーフ，オレンジの線がブランチの平均値変化を表している．なおサイズについては，視線速度，位置，位置の三次元空間における体積であることを考慮し$"pc"^2$ #unit("km/s")という単位を用いている．またビリアルパラメータは@eq:vir を用いて算出した．$R$は構造の体積から，構造を球形と考えることで導出した．また$sigma$は構造が占めるボクセルの視線速度の値から分散の定義式を用いて導出した．

@img:size_ave や@img:mass_ave から，リーフのサイズや質量の平均値は増減を繰り返していることがわかる．一方ブランチのサイズ，質量の平均値は時間発展に伴い徐々に増加していることがわかる．

@img:vir_ave から，リーフのビリアルパラメータについては増減しながらも全体としては減少傾向にあることがわかる．一方ブランチのビリアルパラメータについては，1.1 Myrから2.2 Myrにかけて増加していることがわかる．
#img(
  image("c:media/size_ave.png", width:70%),
  caption: [三次元散布図上の各構造のサイズの平均値変化],
) <img:size_ave>

#img(
  image("c:media/mass_ave.png", width:70%),
  caption: [三次元散布図上の各構造の質量の平均値変化],
) <img:mass_ave>

#img(
  image("c:media/vir_ave.png",width:70%),
  caption: [三次元散布図上の各構造のビリアルパラメータの平均値変化],
) <img:vir_ave>\

== 三次元散布図上の各構造のヒストグラム

//ビリアルパラメータのヒストグラムを追加

三次元散布図の解析で得られた各構造について，サイズ，質量，ビリアルパラメータのヒストグラムを作成した．結果を@img:size_hist_3D_，@img:mass_hist_3D に示す．青のビンがリーフの個数，オレンジのビンがブランチの個数を表している．

@img:size_hist_3D_ より，積分強度図上の構造と同様，三次元散布図上の各構造においても，サイズの大きい構造の個数と小さい構造の個数が交互に増減していると読み取ることができる．この事実は@discuss_3D で見られるような，リーフのサイズの平均値の増減に対応する．一方で1.7 Myrや2.2 Myrにおいて，$1000$ $"pc"^2$ #unit("km/s")を上回るサイズのリーフやブランチが生じていることがわかる．特に2.2 Myrにおける最大のブランチがリーフを覆うような巨大な構造となっていることが，@img:dendro3D_2800_contour から定性的にも確認できる．またこの事実は@discuss_3D で見られるような，ブランチのサイズの平均値の増加に対応する．

@img:mass_hist_3D より，質量についてもサイズと同様の傾向がみられる．

@img:alpha_gvir_hist_3D より，時間発展に伴いビリアルパラメータの大きいリーフが減少し，小さいリーフが増加する傾向にあることがわかる．これは@discuss_3D で見られるような，リーフのビリアルパラメータの平均値の減少傾向に対応する．一方で特に2.2 Myrにおいて，ビリアルパラメータの大きいブランチが生じていることがわかる．これは@discuss_3D で見られるような，ブランチのビリアルパラメータの平均値の増加に対応する．

1.7 Myrや2.2 Myrにおいて巨大な構造が形成される原因についてはまだ明らかでない．しかしこの二つの時点ではリーフの個数が減少していることから，0.57 Myrや1.1 Myrにおいて存在している構造が衝突を起こすことで，その時点よりもサイズや質量の大きい構造が形成される可能性が考えられる．

#img(
  image("c:media/size_hist_3D.png"),
  caption: [三次元散布図上の各構造のサイズのヒストグラム],
) <img:size_hist_3D_>

#img(
  image("c:media/mass_hist_3D.png"),
  caption: [三次元散布図上の各構造の質量のヒストグラム],
) <img:mass_hist_3D>

#img(
  image("c:media/alpha_gvir_hist_3D.png"),
  caption: [三次元散布図上の各構造のビリアルパラメータのヒストグラム],
) <img:alpha_gvir_hist_3D>\

== mass functionとの比較

Dendrogramによる解析結果やその解釈についての正確性を確認するため，解析対象のデータについて各時点におけるmass functionを作成した．結果を@img:mass_function_ に示す．青線が0.57 Myr，黄色線が1.1 Myr，緑線が1.7 Myr，赤線が2.2 Myrにおける結果である．

mass functionから，時間発展に伴い質量の大きい部分と小さい部分が増加していることがわかる．これは分子雲においてフィラメント構造が発展しているためと考えられる．この事実は@discuss_trunk で述べたように，トランク内部でもみられる傾向である．

一方でフィラメント構造が発展するスピードについては徐々に減少していることがわかる．特に1.7 Myrから2.2 Myrにおいては質量の最大値がほぼ変わらないなど傾向が顕著である．これは分子雲が全体としてビリアル平衡に近づいているためと考えられる．この事実は@discuss_trunk においてみられたようなビリアルパラメータの変化に対応する．

#img(
  image("c:media/mass_function.png", width: 70%),
  caption: [各時点におけるmass function],
) <img:mass_function_>

== 解析結果から推定される分子雲進化シナリオ

以上の解析結果から，以下のような分子雲進化のシナリオが考えられる．

まず分子雲は，全体としては自己重力によって徐々に収縮しつつ，フィラメント構造を発展させる．一方で分子雲内部に存在する小規模な構造は，そのサイズと質量について増減を繰り返す．その後，分子雲全体としてビリアル平衡に近づくことによって，自己重力による収縮やフィラメント構造の発展のスピードは減少していく．一方で内部の小規模な構造は，衝突などの原因によって，より大きな構造を形成していく．

これまでの多数の観測により，分子雲の衝突によって星形成が起こる可能性が示されてきた．このような衝突は一般には，独立した複数の分子雲によるものとされている．しかしこのシナリオのように，重力的に安定した巨大な構造の内部で小規模な構造の衝突が効率的に行われ，星形成に至る可能性がある．

#img(
  image("gmc_evol_2.jpg", width: 90%),
  caption: [分子雲進化シナリオの模式図],
) <img:gmc_evol>

= 結論と今後の展望

== まとめ

本研究では，分子雲進化を想定した自己重力流体シミュレーションに対し，その進化の様子を構造的に理解し，星形成に至るまでのシナリオを構築するため，Dendrogramを用いた構造同定を行った．主な結果を以下にまとめる．

- 三次元データを視線方向に積分した積分強度図をDendrogramで解析した．結果最も外側の構造であるトランクについて，自己重力により収縮する様子が見られたが，そのスピードについては遅くなっていた．ビリアルパラメータの推移との比較から，重力収縮については徐々に平衡に近づいていると考えられる．またトランク内部の質量が減少していたことから，時間発展により分子雲はフィラメント構造を発展させるものと思われる．
- トランクの内部にある小規模な構造においては，そのサイズと質量は増加と減少を繰り返していた．
- 三次元データをもとに作成したした三次元散布図についても同様にDendrogramで解析した．結果，各構造のサイズと質量が増加と減少を繰り返している様子がみられた．一方で時間発展につれ，比較的大きな構造が生じ，成長していく様子もみられた．
- 解析対象のデータに対しmass functionを作成し，Dendrogramによる解析と比較した結果，フィラメント構造の発展について共通する解釈が可能であることがわかった．
- 解析によって得られた情報をもとに，分子雲の構造的な進化について，自己重力による収縮が平衡に近づき，内部では小規模な構造がより大きい構造へ成長するというシナリオを推定することができた．

== 今後の展望

本研究では主に四つの時点のデータに対し解析を行ったが，時間発展をより詳しく調べることで，仮定した分子雲進化シナリオを確認することができると考えられる．また本研究では視線速度，位置，位置からなる三次元データを扱ったが，その他のパラメータからなるデータも扱うことで，このシミュレーションに対するより深い理解が可能となる．

一方で観測データとの比較も行い，今回得られた構造と観測データとの対応などについても考察を進めたいと考えている．

#set heading(numbering: none)

= 謝辞

= 参考文献

Federrath, C., et al. 2012, ApJ, 761, 156

Fukushima, H., et al. 2020, MNRAS, 497, 3830

Hiroshi, K., et al. 2021, ApJ, 912, 66

Kim, J. G., et al. 2018, ApJ, 859, 68

Kondo et al. 

Rie, E. Miura, et al. 2012, ApJ, 761, 37

Astronomical Dendrograms in Python, https://dendrograms.readthedocs.io/en/stable/

Sfumato AMR, https://redmagic.i.hosei.ac.jp/research/sfumato/

天文学辞典(公益社団法人 日本天文学会), https://astro-dic.jp









