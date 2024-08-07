#set text(10pt, font: (
  "New Computer Modern Math",
  "IPAexMincho", 
  ))

#align(center, text(14pt)[
  分子雲の構造進化の理解に向けた自己重力流体シミュレーションの解析
])

#grid(
  columns: (1fr, 1fr),
  align()[],
  align(right)[
    202011722 佐々木誇虎 \
    指導教員 久野成夫
  ]
)

#show: rest => columns(2, rest)

#set heading(numbering: "1．")
#show heading: it => [
  #set text(10pt, font: "IPAexGothic")
  //#counter(heading).display()
  #block(counter(heading).display() + it.body)
]

#show par: set block(spacing: 0.65em)
#set par(
  first-line-indent: 1em,
  justify: true,
)
#show heading: it => {
    it
    par(text(size: 0pt, ""))
}

#show figure.caption: it => [
  #set text(10pt, font: "IPAexGothic")
  図#it.counter.display(it.numbering):
  #it.body
]

#set ref(supplement: it => {"図"})

= 研究背景，目的

星形成は分子ガスの塊である分子雲で起こることがわかっているが，分子雲がどのような構造をとりながら星形成に至るかという詳細な進化過程はまだ明らかになっていない．星形成に至る分子雲の進化過程を理解するためには，観測に加え，分子雲の時間変化を追跡できるシミュレーションを用いた研究が重要である．

本研究では，分子雲進化を想定した自己重力流体シミュレーションを解析することで，分子雲の構造進化を調べた．

= 対象データ，解析手法

解析の対象となるデータは四つの時点に分かれており，観測データと同じようにそれぞれ視線速度，位置，位置からなる三次元空間にガスの質量が格納されている．解析はデータを視線方向に積分した積分強度図と，三次元散布図それぞれに対して行った．

これらのデータに対し，観測的研究でしばしば用いられるDendrogramを用いた構造の同定を行った．

= 解析結果，議論

積分強度図の解析結果のうち，0.57 Myrと2.2 Myrにおける積分強度図の解析結果を@dendro_400 と@dendro_2800 にそれぞれ示す．積分強度図において同定された構造のうち，最も外側の構造については自己重力により収縮していく様子が確認できた．またこの構造のビリアルパラメータの推移から，分子雲全体としてビリアル平衡に近づいていることがわかった．また内部構造については，そのサイズ，質量，ビリアルパラメータが増減を繰り返していることがわかった．三次元散布図の解析結果からは，同定された各構造のサイズ，質量，ビリアルパラメータが増減を繰り返していることがわかった．一方で時間発展につれ比較的大きな構造が生じ，成長していく様子も見られた．

以上の解析結果から，シミュレーションにおける分子雲進化の構造について，自己重力による収縮が平衡に近づき，内部では小規模な構造がより大規模な構造へ成長するということが明らかとなった．小規模な構造が大規模な構造へ成長する過程において，構造同士の衝突などの原因で星形成が促進される可能性がある．

= まとめ，今後の展望

分子雲の構造進化を調べるため，自己重力流体シミュレーションをDendrogramを用いて解析した．得られた結果をもとに星形成過程のシナリオを推定することができた．

今後は時間分解能を上げ，密度や温度など他のパラメータのもとでシミュレーションの解析を行い，さらに観測データとの比較を行うことで星形成のさらなる理解につなげていきたい．

#figure(
  image("dendro_for_abst_1.png", width: 70mm),
  caption: "0.57 Myrにおける積分強度図の解析結果．質量の大きい部分ほど多くの内部構造を持つ．"
) <dendro_400>

#figure(
  image("dendro_for_abst_2.png", width: 70mm),
  caption: "2.2 Myrにおける積分強度図の解析結果．0.57 Myr時点と比べ，外側の構造が小さく，内側の構造が大きくなっていることがわかる．"
) <dendro_2800>

