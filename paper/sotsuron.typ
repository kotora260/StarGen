#import "@preview/physica:0.9.0": *
#import "@preview/metro:0.1.0": *
// solar massは数式で、pcはテキストで入力
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
      星形成は分子ガスの塊である分子雲で起こると考えられているが,分子雲がどのような構造をとりながら星形成に至るかという詳細なシナリオはまだ明らかになっていない. このシナリオを形成するためには,シミュレーションを用いた研究が重要である. シミュレーションは観測と比較して,時間発展に伴う構造の変化を追跡することが容易である. 故に分子雲進化のシミュレーションを解析することは,星形成を詳細に理解する上で有効な手段である. 本研究では,分子雲進化を想定した自己重力流体シミュレーションを Dendrogram を用いて解析することで,シミュレーションにおける分子雲進化の構造を調べた. 対象のデータは四つの時点に分かれており,それぞれ視線速度×位置×位置からなる三次元空間にガスの質量が格納されている. 解析はデータを視線方向に積分した積分強度図と,三次元散布図それぞれに対して行った. 解析の結果,積分強度図において同定された構造のうち,最も外側の構造については自己重力により収縮していく様子が確認できた. しかしその収縮スピードやこの構造のビリアルパラメータの推移から,分子雲全体としてビリアル平衡に近づいていることがわかった. また内側にある構造については, 膨張と収縮を繰り返していることがわかった. 三次元散布図の解析結果からは,同定された各構造が膨張と収縮を繰り返していることがわかった. 一方で時間発展につれ比較的大きな構造が生じ,成長していく様子も見られた. 以上の解析結果から,シミュレーションにおける分子雲進化の構造について,より詳細なシナリオを仮定することが可能になった.
  ],
)

= 序論

== 星間物質と星形成

=== 星間物質

宇宙空間には星と星の間に様々な星間物質が存在している. 星間物質は星間ガスや星間ダストからなり, 密度や温度の違いによって分類されている. 図に様々な密度, 温度における星間物質を掲載する.

#img(
  image("interstellar_matter.png", width: 70%),
  caption: [様々な密度, 温度での星間物質（天文学辞典（日本天文学会））],
) <img:interstellar_matter>\

=== 分子雲と星形成

星間物質のうち, 最も密度が高い星間ガスは分子雲と呼ばれる. 分子雲は低温なため, 内部では水素が分子の状態で存在している. 分子雲中で特に密度が高い領域は分子雲コアと呼ばれる. 分子雲コアは重力的に不安定なため, その中心部で星形成が行われると考えられている. だがそのようなコアがどのような構造を経て生じ, 星形成に至るかという詳細なシナリオはまだ明らかになっていない.

=== ビリアルパラメータ

分子雲では自身の内圧など外へ広がろうとする力と, 自己重力など内へ収縮しようとする力がはたらいている. この二つの力がつり合っている状態をビリアル平衡と呼ぶ. ビリアルパラメータは,分子雲が平衡にどの程度近いかを評価する際に用いられる指標である. ビリアルパラメータは以下のような式で表せる.

$ alpha_("Gvir") = (5sigma^2R) / (3G M) $ <eq:vir>

ここで$sigma$は分子雲の三次元速度分散 [#unit("km/s")],$R$は分子雲の半径 [pc],$G$は万有引力定数,$M$は分子雲の質量 [$M_⊙$]である.

分子雲内部で外へ広がろうとする力が強くはたらいている状態では, ビリアルパラメータの値は$alpha_("Gvir") >> 1$である. その状態から分子雲が平衡に近づくと値は $alpha_("Gvir") = 1$ へ近づいていく.

== 星形成の研究手法

星形成の研究は, 観測とシミュレーションのどちらかを用いて行われることが多い.

=== 観測を用いた研究

分子雲コアに代表されるような星形成領域の観測は, これまで盛んにおこなわれてきた. しかし分子雲が収縮し星となるまでに要する時間はは$10^5$年から$10^6$年である. そのため観測によって得られたデータはその長い時間における一時点の情報ということになる. よって観測データだけでは,分子雲の構造進化を理解するのは困難である.

=== シミュレーションを用いた研究

シミュレーションを用いた星形成の研究においては, 自己重力流体のパラメータやモデルに応じた星形成率(SFR)や星形成効率(SFE)の変化を探ることが多い. 一方, 流体の中で分子雲コアに対応するシンク粒子などの構造がどのような過程を経て形成されるかについては, まだあまり考えられていなかった.
前節で述べたように, 観測データを用いて分子雲の構造進化を追うことは難しい. しかしシミュレーションであれば, 自己重力流体の時間発展を解析することで, このような構造進化の研究を容易に行うことができる.

== 本研究の目的

本研究では, 星形成に至るまでの分子雲進化の詳細な理解を目的とする. この目的を達成するため, 自己重力流体シミュレーションの解析を行う. 解析においては時間発展に伴う流体の構造の変化に注目する. 解析の結果から, 分子雲進化のシナリオを構築することによって, 星形成の過程をより詳細に理解できると考える.

= 対象データ

== シミュレーション概要

本研究で解析の対象としたのは SFUMATO を用いて計算された自己重力流体シミュレーションである. SFUMATO は自己重力 MHD 問題を解くための天体物理シミュレーションコードである. コードの詳細は”Sfumato AMR”(https://redmagic.i.hosei.ac.jp/research/sfumato/) に記載されている.

シミュレーションは磁場のない一様な分子雲を想定して雲質量$10^6$ $M_⊙$, 面密度$350$ $M_⊙"pc"^(-2)$
, 半径 30 pc の一様な流体の球を自己重力により変化させた.

== データ詳細

本研究では,先述のシミュレーションのうち,それぞれ0.5702 Myr, 1.104 Myr, 1.703 Myr, 2.188 Myrの時点における質量のデータ(それぞれ m400, m1000, m2200, m2800 とラベリングしている)を取得して解析した. これらのデータは視線速度, 位置, 位置からなる三次元データである. 40 $*$ 65 $*$ 65 個のボクセルの中に質量が数値として格納されている. また 1 つのボクセルは 0.65 #unit("km/s") $*$ 1.4 pc $*$ 1.4 pc の三次元空間に相当する.

解析はこのデータを視線速度方向に積分した積分強度図と, もとのデータをそのまま三次元空間
にプロットした散布図に対して行った.

以下にそれぞれの時点における積分強度図を示す.

#img(
  image("c:media/int_map_400.png", width: 70%),
  caption: [m400の積分強度図],
) <img:int_map_400>

#img(
  image("c:media/int_map_1000.png", width: 70%),
  caption: [m1000の積分強度図],
) <img:int_map_1000>

#img(
  image("c:media/int_map_2200.png", width: 70%),
  caption: [m2200の積分強度図],
) <img:int_map_2200>

#img(
  image("c:media/int_map_2800.png", width: 70%),
  caption: [m2800の積分強度図],
) <img:int_map_2800>\

以下にそれぞれの時点における三次元散布図を示す. なおガスの構造がわかりやすいよう, プロットは質量が 40 $M_⊙$ 以上のボクセルに対して行った.

#img(
  image("c:media/3Dmap_400.png", width: 70%),
  caption: [m400の三次元散布図],
) <img:3Dmap_400>

#img(
  image("c:media/3Dmap_1000.png", width: 70%),
  caption: [m1000の三次元散布図],
) <img:3Dmap_1000>

#img(
  image("c:media/3Dmap_2200.png", width: 70%),
  caption: [m2200の三次元散布図],
) <img:3Dmap_2200>

#img(
  image("c:media/3Dmap_2800.png", width: 70%),
  caption: [m2800の三次元散布図],
) <img:3Dmap_2800>\

= 解析方法

本研究では Dendrogram を用いて構造の同定を行っていく.

Dendrogram は, 多次元のデータセットにおける階層構造を樹形図上に分類するアルゴリズムである. それぞれの階層は, 内部に構造を持たない最小構造であるリーフ(leaf)と, 内部に構造を持つブランチ(branch)に分類される. また最も上位の構造をトランク(trunk)と呼ぶ. 詳細は”Astronomical Dendrograms in Python”(https://dendrograms.readthedocs.io/en/stable/) に記載されている.

解析対象のデータにおいては, ガスの質量が大きい部分ほどより多くの内部構造を持つ.

#img(
  image("dendrogram_example.png", width: 70%),
  caption: [Dendrogram による階層構造],
) <img:dendrogram_example>\

= 解析結果

== 積分強度図の解析結果

まず, 積分強度図に対して Dendrogram を実行した. 以下に同定された構造を示す. 赤の線がリーフの輪郭, 黄色の線がブランチの輪郭を表している.

#img(
  image("c:media/dendro_400_contour.png", width: 70%),
  caption: [m400の積分強度図の解析結果],
) <img:dendro_400_contour>

#img(
  image("c:media/dendro_1000_contour.png", width: 70%),
  caption: [m1000の積分強度図の解析結果],
) <img:dendro_1000_contour>

#img(
  image("c:media/dendro_2200_contour.png", width: 70%),
  caption: [m2200の積分強度図の解析結果],
) <img:dendro_2200_contour>

#img(
  image("c:media/dendro_2800_contour.png", width: 70%),
  caption: [m2800の積分強度図の解析結果],
) <img:dendro_2800_contour>\

== 三次元散布図の解析結果

続いて三次元散布図において Dendrogram を実行した. 以下に同定された構造を示す. 赤の表面がリーフの輪郭, 黄色の表面がブランチの輪郭を表している.

#img(
  image("c:media/dendro3D_400_contour.png", width: 70%),
  caption: [m400の三次元散布図の解析結果],
) <img:dendro3D_400_contour>

#img(
  image("c:media/dendro3D_1000_contour.png", width: 70%),
  caption: [m1000の三次元散布図の解析結果],
) <img:dendro3D_1000_contour>

#img(
  image("c:media/dendro3D_2200_contour.png", width: 70%),
  caption: [m2200の三次元散布図の解析結果],
) <img:dendro3D_2200_contour>

#img(
  image("c:media/dendro3D_2800_contour.png", width: 70%),
  caption: [m2800の三次元散布図の解析結果],
) <img:dendro3D_2800_contour>\



= 議論

== 積分強度図上のトランクのサイズと質量の変化

以下では積分強度図の解析で得られた構造のうち, 最外部の構造であるトランクのサイズと質量
の変化を考察していく.

=== トランクのサイズ変化

以下はトランクのサイズ変化のグラフである. グラフから, トランクは徐々に収縮していることがわかる. しかしグラフの傾きに相当する, 収縮のスピードは減少していることがわかる.

#img(
  image("c:media/trunk_size_2D.png", width: 70%),
  caption: [積分強度図上のトランクのサイズ変化],
) <img:trunk_size_2D>\

=== トランクの質量変化 <trunk_mass>

以下はトランクの質量変化のグラフである. グラフから, トランクの質量は徐々に減少していることがわかる. この事実は, トランクの内部でフィラメント構造が発達していることを示している.フィラメント構造の発達により質量の粗密が増大することで, Dendrogram の最小値を上回るような質量を持つ部分が減少するため, 質量の数値に減少傾向がみられたと考えられる.

#img(
  image("c:media/trunk_mass_2D.png", width: 70%),
  caption: [積分強度図上のトランクの質量変化],
) <img:trunk_mass_2D>\

=== トランクのビリアルパラメータ <trunk_vir>

トランクのサイズや質量の変化についてより詳細に考察するため, ビリアルパラメータ$alpha_("Gvir")$を式 @eq:vir を用いて算出した. なお$R$はトランクの面積から, トランクを円形と考えることで導出した.また$sigma$はトランク内部の速度スペクトルを足し合わせて最小二乗法を用いてガウスフィッテイングを行い, フィッティング結果の半値幅とした. 以下にそれぞれの時点でのフィッテングの結果を示す.

#img(
  image("c:media/fwhm_400_branch_0.png", width: 70%),
  caption: [m400のトランクの速度スペクトルとフィッテイング結果],
) <img:fwhm_400>

#img(
  image("c:media/fwhm_1000_branch_2.png", width: 70%),
  caption: [m1000のトランクの速度スペクトルとフィッテイング結果],
) <img:fwhm_1000>

#img(
  image("c:media/fwhm_2200_branch_1.png", width: 70%),
  caption: [m2200のトランクの速度スペクトルとフィッテイング結果],
) <img:fwhm_2200>

#img(
  image("c:media/fwhm_2800_branch_0.png", width: 70%),
  caption: [m2800のトランクの速度スペクトルとフィッテイング結果],
) <img:fwhm_2800>\

算出したビリアルパラメータの推移を以下に示す.

#img(
  image("c:media/alpha_gvir_trunk_2D.png", width: 70%),
  caption: [ビリアルパラメータ$alpha_("Gvir")$の推移],
) <img:alpha_gvir_trunk_2D>\

@img:alpha_gvir_trunk_2D より, ビリアルパラメータは徐々に減少しながら $alpha_("Gvir") = 1$に漸近していることがわかる. よってトランクは徐々にビリアル平衡に向かっていると考えられる. この事実はトランクの収縮スピードが減少している事実に対応する.

== 積分強度図上の各構造のヒストグラム

次に積分強度図の解析で得られた各構造について, サイズと質量のヒストグラムを作成した. 青のビンがリーフの個数, オレンジのビンがブランチの個数を表している.

#img(
  image("c:media/size_hist_2D_paper.png", width: 100%),
  caption: [積分強度図上の各構造のサイズのヒストグラム],
) <img:size_hist_2D>

#img(
  image("c:media/mass_hist_2D_paper.png", width: 100%),
  caption: [積分強度図上の各構造の質量のヒストグラム],
) <img:mass_hist_2D>\

@img:size_hist_2D から, 最もサイズの大きいブランチ(トランク)が収縮していることが確認できる. またリーフやトランク以外のブランチについては, 構造によって膨張と収縮を繰り返しているような挙動がみられる.

@img:mass_hist_2D より、質量についても各構造において同様の傾向がみられる.

== 三次元散布図上の各構造のヒストグラム

三次元散布図の解析で得られた各構造についても, サイズと質量のヒストグラムを作成した. 青のビンがリーフの個数, オレンジのビンがブランチの個数を表している.

#img(
  image("c:media/size_hist_3D_paper.png", width: 100%),
  caption: [三次元散布図上の各構造のサイズのヒストグラム],
) <img:size_hist_3D_>

#img(
  image("c:media/mass_hist_3D_paper.png", width: 100%),
  caption: [三次元散布図上の各構造の質量のヒストグラム],
) <img:mass_hist_3D>\

@img:size_hist_3D_ より, 積分強度図上の構造と同様, 三次元散布図上の各構造も膨張と収縮を繰り返していると考えられる. 一方でm2200やm2800において,1000 $"pc"^2$ #unit("km/s")を上回るサイズのリーフやブランチが生じていることがわかる. 特にm2800における最大のブランチがリーフを覆うような巨大な構造となっていることが,図から定性的にも確認できる.

@img:mass_hist_3D より, 質量についてもサイズと同様の傾向がみられる.

m2200やm2800において巨大な構造が形成される原因についてはまだ明らかでない. しかしこの二つの時点ではリーフの個数が減少していることから,m400やm1000 において存在している構造が合体や散逸を起こすことで, その時点よりもサイズや質量の大きい構造が形成される可能性が考えられる.

== mass functionとの比較

Dendrogramによる解析結果やその解釈についての正確性を確認するため,解析対象のデータについて各時点におけるmass functionを作成した. 青線がm400,黄色線がm1000,緑線がm2200,赤線がm2800における結果である.

#img(
  image("c:media/mass_function.png", width: 70%),
  caption: [各時点におけるmass function],
) <img:mass_function>\

mass function から,時間発展に伴い質量の大きい部分と小さい部分が増加していることがわかる. これは分子雲においてフィラメント構造が発展しているためと考えられる. この事実は@trunk_mass で述べたように,トランク内部でもみられる傾向である.

一方でフィラメント構造が発展するスピードについては徐々に減少していることがわかる. 特にm2200 から m2800においては質量の最大値がほぼ変わらないなど傾向が顕著である. これは分子雲が全体としてビリアル平衡に近づいているためと考えられる. この事実は@trunk_vir においてみられたようなビリアルパラメータの変化に対応する.

== 解析結果から仮定される分子雲進化シナリオ

以上の解析結果から,分子雲進化のシナリオを以下のように仮定できる.

まず分子雲は自己重力によって徐々に収縮してフィラメント構造を発展させる. 一方その内部では小規模な構造が膨張と収縮を繰り返す. その後,分子雲全体としてはビリアル平衡に近づくことによって,自己重力による収縮やフィラメント構造の発展のスピードは減少していく. 一方で膨張と収縮を繰り返していた構造は, 合体や散逸といった原因によって,より大きな構造を形成していく.

星形成においては,このように重力的に安定した巨大な構造の内部でガスの衝突が効率的に行われている可能性がある.

= 結論と今後の展望

== まとめ

本研究では,分子雲進化を想定した自己重力流体シミュレーションに対し,その進化の様子を構造的に理解し,星形成に至るまでのシナリオを構築するため,Dendrogram を用いた構造同定を行った. 主な結果を以下にまとめる.

- 三次元データを視線方向に積分した積分強度図を Dendrogram で解析した. 結果最も外側の構造であるトランクについて, 自己重力により収縮する様子が見られたが, そのスピードについては遅くなっていた. ビリアルパラメータの推移との比較から, 重力収縮については徐々に平衡に近づいていると考えられる. またトランク内部の質量が減少していたことから, 時間発展により分子雲はフィラメント構造を発展させるものと思われる.
- トランクの内部にある小規模な構造については, 膨張と収縮を繰り返していた.
- 三次元データをもとに作成したした三次元散布図についても同様に Dendrogram で解析した.結果, 各構造について膨張と収縮を繰り返す様子がみられた. 一方で時間発展につれ, 比較的大きな構造が生じ, 成長していく様子もみられた.
- 解析対象のデータに対し mass function を作成し,Dendrogram による解析と比較した結果, フィラメント構造の発展について共通する解釈が可能であることがわかった.
- 解析によって得られた情報をもとに, 分子雲の構造的な進化について, 自己重力による収縮が平衡に近づき, 内部では小規模な構造が膨張と収縮を繰り返しながらより大きい構造へ成長するという, より詳細なシナリオを仮定することができた.

== 今後の展望

本研究では主に四つの時点のデータに対し解析を行ったが, 他の時点のデータに対しても共通の解析を行うことで, 仮定した分子雲進化シナリオを拡張することができると考えられる. また本研究では視線速度, 位置, 位置からなる三次元データを扱ったが, その他のパラメータからなるデータも扱うことで, このシミュレーションに対するより深い理解が可能となる.

一方で観測データとの比較も行い, 今回得られた構造と観測データとの対応などについても考察を進めたいと考えている.