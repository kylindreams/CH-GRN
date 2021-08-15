%计算pattern的时候用到的sig函数
function gene = sig(p,sita1)

k = 20;

gene = 1/(1+exp(-k*(p-sita1)));
