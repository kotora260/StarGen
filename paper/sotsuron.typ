#import "@preview/physica:0.9.0": *
#import "@preview/metro:0.1.0": *
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
      星形成は分子ガスの塊である分子雲で起こると考えられているが, 分子雲がどのような構造をとりながら星形成に至るかという詳細なシナリオはまだ明らかになっていない. このシナリオを形成するためには, シミュレーションを用いた研究が重要である. シミュレーションは観測と比較して, 時間発展に伴う構造の変化を追跡することが容易である. 故に分子雲進化のシミュレーションを解析することは, 星形成を詳細に理解する上で有効な手段である. 本研究では, 分子雲進化を想定した自己重力流体シミュレーションを Dendrogram を用いて解析することで, シミュレーションにおける分子雲進化の構造を調べた. 対象のデータは四つの時点に分かれており, それぞれ視線速度×位置×位置からなる三次元空間にガスの質量が格納されている. 解析はデータを視線方向に積分した積分強度図と, 三次元散布図それぞれに対して行った. 解析の結果, 積分強度図において同定された構造のうち, 最も外側の構造については自己重力により収縮していく様子が確認できた. しかしその収縮スピードやこの構造のビリアルパラメータの推移から, 分子雲全体としてビリアル平衡に近づいていることがわかった. また内側にある構造については, 膨張と収縮を繰り返していることがわかった. 三次元散布図の解析結果からは,同定された各構造が膨張と収縮を繰り返していることがわかった. 一方で時間発展につれ比較的大きな構造が生じ, 成長していく様子も見られた. 以上の解析結果から, シミュレーションにおける分子雲進化の構造について, より詳細なシナリオを仮定することが可能になった.
  ],
)

= 序論

== 星間物質と星形成

=== 星間物質

宇宙空間には星と星の間に様々な星間物質が存在している. 星間物質は星間ガスや星間ダストからなり, 密度や温度の違いによって分類されている. 図 1 に様々な密度, 温度における星間物質を掲載する.

=== 分子雲と星形成

星間物質のうち, 最も密度が高い星間ガスは分子雲と呼ばれる. 分子雲は低温なため, 内部では水素が分子の状態で存在している. 分子雲中で特に密度が高い領域は分子雲コアと呼ばれる. 分子雲コアは重力的に不安定なため, その中心部で星形成が行われると考えられている. だがそのようなコアがどのような構造を経て生じ, 星形成に至るかという詳細なシナリオはまだ明らかになっていない.

=== ビリアルパラメータ

分子雲では自身の内圧など外へ広がろうとする力と, 自己重力など内へ収縮しようとする力がはたらいている. この二つの力がつり合っている状態をビリアル平衡と呼ぶ. ビリアルパラメータは,分子雲が平衡にどの程度近いかを評価する際に用いられる指標である. ビリアルパラメータは以下のような式で表せる.

$ alpha_("Gvir") = (5sigma^2R) / (3G M) $

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