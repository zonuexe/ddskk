;;; skk-azik.el --- $B3HD%%m!<%^;zF~NO(B "AZIK" $B$r(B SKK $B$G;H$&$?$a$N@_Dj(B -*- coding: iso-2022-jp -*-

;; Copyright (C) 2002 ONODA Arata <onoto@ma.nma.ne.jp>

;; Author: ONODA Arata <onoto@ma.nma.ne.jp>
;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Keywords: japanese, mule, input method
;; Created: Jan. 9, 2002

;; This file is part of Daredevil SKK.

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; $B3HD%%m!<%^;zF~NO(B "AZIK" $B$r(B SKK $B$G;H$&$?$a$N@_Dj$G$9!#(B
;; "AZIK"$B$K$D$$$F$O!"0J2<$N(B URL $B$r;2>H$7$F2<$5$$!#(B
;;   http://hp.vector.co.jp/authors/VA002116/azik/azikindx.htm

;; $B;H$$J}(B - $B2<5-$N@_Dj$r(B .skk $B$K2C$($F$/$@$5$$!#(B
;;          $B$=$N8e(B Emacs(Mule) $B$r:F5/F0$9$l$P(B skk $B$K$h$k(B AZIK $B$G$N(B
;;          $BF~NO$,2DG=$G$9!#(B

;;          (setq skk-use-azik t)
;;          (setq skk-azik-keyboard-type 'jp106)

;;          $BJQ?t(B skk-azik-keyboard-type $B$K$*;H$$$N%-!<%\!<%I$N%?%$%W$r(B
;;          $B;XDj$7$F2<$5$$!#(Bskk-azik-keyboard-type $B$O%7%s%\%k$G(B
;;          'jp106 $B$b$7$/$O(B 'jp-pc98 $B!"$^$?$O!"(B 'en $B$r;XDj$7$^$9!#(B


;; $BCm0U(B 1 - AZIK $B$G$O(B "q" $B$r(B "$B$s(B" $B$NF~NO$K;H$&$N$G!"(B"q" $B$N$b$H$b$H(B
;;          $B$N5!G=$G$"$k(B "skk-toggle-characters" $B$K$O!"F|K\8l%-!<%\!<%I(B
;;          $B$G$"$l$P(B "@" $B$r!"1Q8l%-!<%\!<%I$G$"$l$P!"(B"[" $B$GBeMQ$7$^$9!#(B
;;          SKK $BI8=`$N(B "@"($BF|K\8l%-!<%\!<%I(B) $B$d(B "["($B1Q8l%-!<%\!<%I(B) $B$O!"(B
;;          $B$O!"(B x $B$rIU$1$F!"$=$l$>$l(B "x@" $B$H(B "x[" $B$G;HMQ$G$-$^$9!#(B

;;      2 - $B=c@5$N(B AZIK $B$G$O(B "la" $B$G(B "$B$!(B" $B$rF~NO$7$^$9!#$7$+$7(B
;;          SKK $B$G$O(B L $B$r(B ASCII/$BA41Q%b!<%I$N@Z$jBX$(%-!<$H$7$F(B
;;          $B;HMQ$9$k$N$G!"(B "xxa" $B$G(B "$B$!(B" $B$,F~NO$G$-$k$h$&$K$7$F(B
;;          $B$$$^$9!#(B


;;; Code:

(require 'skk)

(eval-when-compile
  (defvar skk-jisx0201-rule-list)
  (defvar skk-jisx0201-base-rule-list))

(defvar skk-azik-unnecessary-base-rule-list
  '("cha" "che" "chi" "cho" "chu"
    "dha" "dhe" "dhi" "dho" "dhu"
    "sha" "she" "shi" "sho" "shu"
    "tha" "the" "thi" "tho" "thu"))

(defvar skk-azik-additional-rom-kana-rule-list
  '((";" nil ("$B%C(B" . "$B$C(B"))
    ("x;" nil ";")
    ("bd" nil ("$B%Y%s(B" . "$B$Y$s(B"))
    ("bh" nil ("$B%V%&(B" . "$B$V$&(B"))
    ("bj" nil ("$B%V%s(B" . "$B$V$s(B"))
    ("bk" nil ("$B%S%s(B" . "$B$S$s(B"))
    ("bl" nil ("$B%\%s(B" . "$B$\$s(B"))
    ("bn" nil ("$B%P%s(B" . "$B$P$s(B"))
    ("bp" nil ("$B%\%&(B" . "$B$\$&(B"))
    ("bq" nil ("$B%P%$(B" . "$B$P$$(B"))
    ("br" nil ("$B%P%i(B" . "$B$P$i(B"))
    ("bt" nil ("$B%S%H(B" . "$B$S$H(B"))
    ("bw" nil ("$B%Y%$(B" . "$B$Y$$(B"))
    ("bx" nil ("$B%Y%$(B" . "$B$Y$$(B"))
    ("byd" nil ("$B%S%'%s(B" . "$B$S$'$s(B"))
    ("byh" nil ("$B%S%e%&(B" . "$B$S$e$&(B"))
    ("byj" nil ("$B%S%e%s(B" . "$B$S$e$s(B"))
    ("byl" nil ("$B%S%g%s(B" . "$B$S$g$s(B"))
    ("byn" nil ("$B%S%c%s(B" . "$B$S$c$s(B"))
    ("byp" nil ("$B%S%g%&(B" . "$B$S$g$&(B"))
    ("byq" nil ("$B%S%c%$(B" . "$B$S$c$$(B"))
    ("byw" nil ("$B%S%'%$(B" . "$B$S$'$$(B"))
    ("byz" nil ("$B%S%c%s(B" . "$B$S$c$s(B"))
    ("bz" nil ("$B%P%s(B" . "$B$P$s(B"))
    ("ca" nil ("$B%A%c(B" . "$B$A$c(B"))
    ("cc" nil ("$B%A%c(B" . "$B$A$c(B"))
    ("cd" nil ("$B%A%'%s(B" . "$B$A$'$s(B"))
    ("ce" nil ("$B%A%'(B" . "$B$A$'(B"))
    ("cf" nil ("$B%A%'(B" . "$B$A$'(B"))
    ("ch" nil ("$B%A%e%&(B" . "$B$A$e$&(B"))
    ("ci" nil ("$B%A(B" . "$B$A(B"))
    ("cj" nil ("$B%A%e%s(B" . "$B$A$e$s(B"))
    ("ck" nil ("$B%A%s(B" . "$B$A$s(B"))
    ("cl" nil ("$B%A%g%s(B" . "$B$A$g$s(B"))
    ("cn" nil ("$B%A%c%s(B" . "$B$A$c$s(B"))
    ("co" nil ("$B%A%g(B" . "$B$A$g(B"))
    ("cp" nil ("$B%A%g%&(B" . "$B$A$g$&(B"))
    ("cq" nil ("$B%A%c%$(B" . "$B$A$c$$(B"))
    ("cu" nil ("$B%A%e(B" . "$B$A$e(B"))
    ("cv" nil ("$B%A%c%$(B" . "$B$A$c$$(B"))
    ("cw" nil ("$B%A%'%$(B" . "$B$A$'$$(B"))
    ("cx" nil ("$B%A%'%$(B" . "$B$A$'$$(B"))
    ("cz" nil ("$B%A%c%s(B" . "$B$A$c$s(B"))
    ("dch" nil ("$B%G%e!<(B" . "$B$G$e!<(B"))
    ("dci" nil ("$B%G%#(B" . "$B$G$#(B"))
    ("dck" nil ("$B%G%#%s(B" . "$B$G$#$s(B"))
    ("dcp" nil ("$B%I%%!<(B" . "$B$I$%!<(B"))
    ("dcu" nil ("$B%G%e(B" . "$B$G$e(B"))
    ("dd" nil ("$B%G%s(B" . "$B$G$s(B"))
    ("df" nil ("$B%G(B" . "$B$G(B"))
    ("dg" nil ("$B%@%,(B" . "$B$@$,(B"))
    ("dh" nil ("$B%E%&(B" . "$B$E$&(B"))
    ("dj" nil ("$B%E%s(B" . "$B$E$s(B"))
    ("dk" nil ("$B%B%s(B" . "$B$B$s(B"))
    ("dl" nil ("$B%I%s(B" . "$B$I$s(B"))
    ("dm" nil ("$B%G%b(B" . "$B$G$b(B"))
    ("dn" nil ("$B%@%s(B" . "$B$@$s(B"))
    ("dp" nil ("$B%I%&(B" . "$B$I$&(B"))
    ("dq" nil ("$B%@%$(B" . "$B$@$$(B"))
    ("dr" nil ("$B%G%"%k(B" . "$B$G$"$k(B"))
    ("ds" nil ("$B%G%9(B" . "$B$G$9(B"))
    ("dt" nil ("$B%@%A(B" . "$B$@$A(B"))
    ("dv" nil ("$B%G%s(B" . "$B$G$s(B"))
    ("dw" nil ("$B%G%$(B" . "$B$G$$(B"))
    ("dy" nil ("$B%G%#(B" . "$B$G$#(B"))
    ("dz" nil ("$B%@%s(B" . "$B$@$s(B"))
    ("fd" nil ("$B%U%'%s(B" . "$B$U$'$s(B"))
    ("fh" nil ("$B%U%&(B" . "$B$U$&(B"))
    ("fj" nil ("$B%U%s(B" . "$B$U$s(B"))
    ("fk" nil ("$B%U%#%s(B" . "$B$U$#$s(B"))
    ("fl" nil ("$B%U%)%s(B" . "$B$U$)$s(B"))
    ("fm" nil ("$B%U%`(B" . "$B$U$`(B"))
    ("fn" nil ("$B%U%!%s(B" . "$B$U$!$s(B"))
    ("fp" nil ("$B%U%)!<(B" . "$B$U$)!<(B"))
    ("fq" nil ("$B%U%!%$(B" . "$B$U$!$$(B"))
    ("fr" nil ("$B%U%k(B" . "$B$U$k(B"))
    ("fs" nil ("$B%U%!%$(B" . "$B$U$!$$(B"))
    ("fw" nil ("$B%U%'%$(B" . "$B$U$'$$(B"))
    ("fz" nil ("$B%U%!%s(B" . "$B$U$!$s(B"))
    ("gd" nil ("$B%2%s(B" . "$B$2$s(B"))
    ("gh" nil ("$B%0%&(B" . "$B$0$&(B"))
    ("gj" nil ("$B%0%s(B" . "$B$0$s(B"))
    ("gk" nil ("$B%.%s(B" . "$B$.$s(B"))
    ("gl" nil ("$B%4%s(B" . "$B$4$s(B"))
    ("gn" nil ("$B%,%s(B" . "$B$,$s(B"))
    ("gp" nil ("$B%4%&(B" . "$B$4$&(B"))
    ("gq" nil ("$B%,%$(B" . "$B$,$$(B"))
    ("gr" nil ("$B%,%i(B" . "$B$,$i(B"))
    ("gt" nil ("$B%4%H(B" . "$B$4$H(B"))
    ("gw" nil ("$B%2%$(B" . "$B$2$$(B"))
    ("gyd" nil ("$B%.%'%s(B" . "$B$.$'$s(B"))
    ("gyh" nil ("$B%.%e%&(B" . "$B$.$e$&(B"))
    ("gyj" nil ("$B%.%e%s(B" . "$B$.$e$s(B"))
    ("gyl" nil ("$B%.%g%s(B" . "$B$.$g$s(B"))
    ("gyn" nil ("$B%.%c%s(B" . "$B$.$c$s(B"))
    ("gyp" nil ("$B%.%g%&(B" . "$B$.$g$&(B"))
    ("gyq" nil ("$B%.%c%$(B" . "$B$.$c$$(B"))
    ("gyw" nil ("$B%.%'%$(B" . "$B$.$'$$(B"))
    ("gyz" nil ("$B%.%c%s(B" . "$B$.$c$s(B"))
    ("gz" nil ("$B%,%s(B" . "$B$,$s(B"))
    ("hd" nil ("$B%X%s(B" . "$B$X$s(B"))
    ("hf" nil ("$B%U(B" . "$B$U(B"))
    ("hga" nil ("$B%R%c(B" . "$B$R$c(B"))
    ("hgd" nil ("$B%R%'%s(B" . "$B$R$'$s(B"))
    ("hge" nil ("$B%R%'(B" . "$B$R$'(B"))
    ("hgh" nil ("$B%R%e%&(B" . "$B$R$e$&(B"))
    ("hgj" nil ("$B%R%e%s(B" . "$B$R$e$s(B"))
    ("hgl" nil ("$B%R%g%s(B" . "$B$R$g$s(B"))
    ("hgn" nil ("$B%R%c%s(B" . "$B$R$c$s(B"))
    ("hgo" nil ("$B%R%g(B" . "$B$R$g(B"))
    ("hgp" nil ("$B%R%g%&(B" . "$B$R$g$&(B"))
    ("hgq" nil ("$B%R%c%$(B" . "$B$R$c$$(B"))
    ("hgu" nil ("$B%R%e(B" . "$B$R$e(B"))
    ("hgw" nil ("$B%R%'%$(B" . "$B$R$'$$(B"))
    ("hgz" nil ("$B%R%c%s(B" . "$B$R$c$s(B"))
    ("hh" nil ("$B%U%&(B" . "$B$U$&(B"))
    ("hj" nil ("$B%U%s(B" . "$B$U$s(B"))
    ("hk" nil ("$B%R%s(B" . "$B$R$s(B"))
    ("hl" nil ("$B%[%s(B" . "$B$[$s(B"))
    ("hn" nil ("$B%O%s(B" . "$B$O$s(B"))
    ("hp" nil ("$B%[%&(B" . "$B$[$&(B"))
    ("hq" nil ("$B%O%$(B" . "$B$O$$(B"))
    ("ht" nil ("$B%R%H(B" . "$B$R$H(B"))
    ("hw" nil ("$B%X%$(B" . "$B$X$$(B"))
    ("hyd" nil ("$B%R%'%s(B" . "$B$R$'$s(B"))
    ("hyh" nil ("$B%R%e%&(B" . "$B$R$e$&(B"))
    ("hyl" nil ("$B%R%g%s(B" . "$B$R$g$s(B"))
    ("hyp" nil ("$B%R%g%&(B" . "$B$R$g$&(B"))
    ("hyq" nil ("$B%R%c%$(B" . "$B$R$c$$(B"))
    ("hyw" nil ("$B%R%'%$(B" . "$B$R$'$$(B"))
    ("hyz" nil ("$B%R%c%s(B" . "$B$R$c$s(B"))
    ("hz" nil ("$B%O%s(B" . "$B$O$s(B"))
    ("jd" nil ("$B%8%'%s(B" . "$B$8$'$s(B"))
    ("jf" nil ("$B%8%e(B" . "$B$8$e(B"))
    ("jh" nil ("$B%8%e%&(B" . "$B$8$e$&(B"))
    ("jj" nil ("$B%8%e%s(B" . "$B$8$e$s(B"))
    ("jk" nil ("$B%8%s(B" . "$B$8$s(B"))
    ("jl" nil ("$B%8%g%s(B" . "$B$8$g$s(B"))
    ("jn" nil ("$B%8%c%s(B" . "$B$8$c$s(B"))
    ("jp" nil ("$B%8%g%&(B" . "$B$8$g$&(B"))
    ("jq" nil ("$B%8%c%$(B" . "$B$8$c$$(B"))
    ("jv" nil ("$B%8%e%&(B" . "$B$8$e$&(B"))
    ("jw" nil ("$B%8%'%$(B" . "$B$8$'$$(B"))
    ("jz" nil ("$B%8%c%s(B" . "$B$8$c$s(B"))
    ("kA" nil ("$B%u(B" . "$B%u(B"))
    ("kE" nil ("$B%v(B" . "$B%v(B"))
    ("kd" nil ("$B%1%s(B" . "$B$1$s(B"))
    ("kf" nil ("$B%-(B" . "$B$-(B"))
    ("kga" nil ("$B%-%c(B" . "$B$-$c(B"))
    ("kgd" nil ("$B%-%'%s(B" . "$B$-$'$s(B"))
    ("kge" nil ("$B%-%'(B" . "$B$-$'(B"))
    ("kgh" nil ("$B%-%e%&(B" . "$B$-$e$&(B"))
    ("kgl" nil ("$B%-%g%s(B" . "$B$-$g$s(B"))
    ("kgn" nil ("$B%-%c%s(B" . "$B$-$c$s(B"))
    ("kgo" nil ("$B%-%g(B" . "$B$-$g(B"))
    ("kgp" nil ("$B%-%g%&(B" . "$B$-$g$&(B"))
    ("kgq" nil ("$B%-%c%$(B" . "$B$-$c$$(B"))
    ("kgu" nil ("$B%-%e(B" . "$B$-$e(B"))
    ("kgw" nil ("$B%-%'%$(B" . "$B$-$'$$(B"))
    ("kgz" nil ("$B%-%c%s(B" . "$B$-$c$s(B"))
    ("kh" nil ("$B%/%&(B" . "$B$/$&(B"))
    ("kj" nil ("$B%/%s(B" . "$B$/$s(B"))
    ("kk" nil ("$B%-%s(B" . "$B$-$s(B"))
    ("kl" nil ("$B%3%s(B" . "$B$3$s(B"))
    ("km" nil ("$B%+%b(B" . "$B$+$b(B"))
    ("kn" nil ("$B%+%s(B" . "$B$+$s(B"))
    ("kp" nil ("$B%3%&(B" . "$B$3$&(B"))
    ("kq" nil ("$B%+%$(B" . "$B$+$$(B"))
    ("kr" nil ("$B%+%i(B" . "$B$+$i(B"))
    ("kt" nil ("$B%3%H(B" . "$B$3$H(B"))
    ("kv" nil ("$B%-%s(B" . "$B$-$s(B"))
    ("kw" nil ("$B%1%$(B" . "$B$1$$(B"))
    ("kyd" nil ("$B%-%'%s(B" . "$B$-$'$s(B"))
    ("kyh" nil ("$B%-%e%&(B" . "$B$-$e$&(B"))
    ("kyj" nil ("$B%-%e%s(B" . "$B$-$e$s(B"))
    ("kyl" nil ("$B%-%g%s(B" . "$B$-$g$s(B"))
    ("kyn" nil ("$B%-%c%s(B" . "$B$-$c$s(B"))
    ("kyp" nil ("$B%-%g%&(B" . "$B$-$g$&(B"))
    ("kyq" nil ("$B%-%c%$(B" . "$B$-$c$$(B"))
    ("kyw" nil ("$B%-%'%$(B" . "$B$-$'$$(B"))
    ("kyz" nil ("$B%-%c%s(B" . "$B$-$c$s(B"))
    ("kz" nil ("$B%+%s(B" . "$B$+$s(B"))
    ("md" nil ("$B%a%s(B" . "$B$a$s(B"))
    ("mf" nil ("$B%`(B" . "$B$`(B"))
    ("mga" nil ("$B%_%c(B" . "$B$_$c(B"))
    ("mgd" nil ("$B%_%'%s(B" . "$B$_$'$s(B"))
    ("mge" nil ("$B%_%'(B" . "$B$_$'(B"))
    ("mgh" nil ("$B%_%e%&(B" . "$B$_$e$&(B"))
    ("mgj" nil ("$B%_%e%s(B" . "$B$_$e$s(B"))
    ("mgl" nil ("$B%_%g%s(B" . "$B$_$g$s(B"))
    ("mgn" nil ("$B%_%c%s(B" . "$B$_$c$s(B"))
    ("mgo" nil ("$B%_%g(B" . "$B$_$g(B"))
    ("mgp" nil ("$B%_%g%&(B" . "$B$_$g$&(B"))
    ("mgq" nil ("$B%_%c%$(B" . "$B$_$c$$(B"))
    ("mgu" nil ("$B%_%e(B" . "$B$_$e(B"))
    ("mgw" nil ("$B%_%'%$(B" . "$B$_$'$$(B"))
    ("mgz" nil ("$B%_%c%s(B" . "$B$_$c$s(B"))
    ("mh" nil ("$B%`%&(B" . "$B$`$&(B"))
    ("mj" nil ("$B%`%s(B" . "$B$`$s(B"))
    ("mk" nil ("$B%_%s(B" . "$B$_$s(B"))
    ("ml" nil ("$B%b%s(B" . "$B$b$s(B"))
    ("mn" nil ("$B%b%N(B" . "$B$b$N(B"))
    ("mp" nil ("$B%b%&(B" . "$B$b$&(B"))
    ("mq" nil ("$B%^%$(B" . "$B$^$$(B"))
    ("mr" nil ("$B%^%k(B" . "$B$^$k(B"))
    ("ms" nil ("$B%^%9(B" . "$B$^$9(B"))
    ("mt" nil ("$B%^%?(B" . "$B$^$?(B"))
    ("mv" nil ("$B%`%s(B" . "$B$`$s(B"))
    ("mw" nil ("$B%a%$(B" . "$B$a$$(B"))
    ("myd" nil ("$B%_%'%s(B" . "$B$_$'$s(B"))
    ("myh" nil ("$B%_%e%&(B" . "$B$_$e$&(B"))
    ("myj" nil ("$B%_%e%s(B" . "$B$_$e$s(B"))
    ("myl" nil ("$B%_%g%s(B" . "$B$_$g$s(B"))
    ("myn" nil ("$B%_%c%s(B" . "$B$_$c$s(B"))
    ("myp" nil ("$B%_%g%&(B" . "$B$_$g$&(B"))
    ("myq" nil ("$B%_%c%$(B" . "$B$_$c$$(B"))
    ("myw" nil ("$B%_%'%$(B" . "$B$_$'$$(B"))
    ("myz" nil ("$B%_%c%s(B" . "$B$_$c$s(B"))
    ("mz" nil ("$B%^%s(B" . "$B$^$s(B"))
    ("nb" nil ("$B%M%P(B" . "$B$M$P(B"))
    ("nd" nil ("$B%M%s(B" . "$B$M$s(B"))
    ("nf" nil ("$B%L(B" . "$B$L(B"))
    ("nga" nil ("$B%K%c(B" . "$B$K$c(B"))
    ("ngd" nil ("$B%K%'%s(B" . "$B$K$'$s(B"))
    ("nge" nil ("$B%K%'(B" . "$B$K$'(B"))
    ("ngh" nil ("$B%K%e%&(B" . "$B$K$e$&(B"))
    ("ngj" nil ("$B%K%e%s(B" . "$B$K$e$s(B"))
    ("ngl" nil ("$B%K%g%s(B" . "$B$K$g$s(B"))
    ("ngn" nil ("$B%K%c%s(B" . "$B$K$c$s(B"))
    ("ngo" nil ("$B%K%g(B" . "$B$K$g(B"))
    ("ngp" nil ("$B%K%g%&(B" . "$B$K$g$&(B"))
    ("ngq" nil ("$B%K%c%$(B" . "$B$K$c$$(B"))
    ("ngu" nil ("$B%K%e(B" . "$B$K$e(B"))
    ("ngw" nil ("$B%K%'%$(B" . "$B$K$'$$(B"))
    ("ngz" nil ("$B%K%c%s(B" . "$B$K$c$s(B"))
    ("nh" nil ("$B%L%&(B" . "$B$L$&(B"))
    ("nj" nil ("$B%L%s(B" . "$B$L$s(B"))
    ("nk" nil ("$B%K%s(B" . "$B$K$s(B"))
    ("nl" nil ("$B%N%s(B" . "$B$N$s(B"))
    ("np" nil ("$B%N%&(B" . "$B$N$&(B"))
    ("nq" nil ("$B%J%$(B" . "$B$J$$(B"))
    ("nr" nil ("$B%J%k(B" . "$B$J$k(B"))
    ("nt" nil ("$B%K%A(B" . "$B$K$A(B"))
    ("nv" nil ("$B%L%s(B" . "$B$L$s(B"))
    ("nw" nil ("$B%M%$(B" . "$B$M$$(B"))
    ("nyd" nil ("$B%K%'%s(B" . "$B$K$'$s(B"))
    ("nyh" nil ("$B%K%e%&(B" . "$B$K$e$&(B"))
    ("nyj" nil ("$B%K%e%s(B" . "$B$K$e$s(B"))
    ("nyl" nil ("$B%K%g%s(B" . "$B$K$g$s(B"))
    ("nyn" nil ("$B%K%c%s(B" . "$B$K$c$s(B"))
    ("nyp" nil ("$B%K%g%&(B" . "$B$K$g$&(B"))
    ("nyq" nil ("$B%K%c%$(B" . "$B$K$c$$(B"))
    ("nyw" nil ("$B%K%'%$(B" . "$B$K$'$$(B"))
    ("nyz" nil ("$B%K%c%s(B" . "$B$K$c$s(B"))
    ("nz" nil ("$B%J%s(B" . "$B$J$s(B"))
    ("pd" nil ("$B%Z%s(B" . "$B$Z$s(B"))
    ("pf" nil ("$B%]%s(B" . "$B$]$s(B"))
    ("pga" nil ("$B%T%c(B" . "$B$T$c(B"))
    ("pgd" nil ("$B%T%'%s(B" . "$B$T$'$s(B"))
    ("pge" nil ("$B%T%'(B" . "$B$T$'(B"))
    ("pgh" nil ("$B%T%e%&(B" . "$B$T$e$&(B"))
    ("pgj" nil ("$B%T%e%s(B" . "$B$T$e$s(B"))
    ("pgl" nil ("$B%T%g%s(B" . "$B$T$g$s(B"))
    ("pgn" nil ("$B%T%c%s(B" . "$B$T$c$s(B"))
    ("pgo" nil ("$B%T%g(B" . "$B$T$g(B"))
    ("pgp" nil ("$B%T%g%&(B" . "$B$T$g$&(B"))
    ("pgq" nil ("$B%T%c%$(B" . "$B$T$c$$(B"))
    ("pgu" nil ("$B%T%e(B" . "$B$T$e(B"))
    ("pgw" nil ("$B%T%'%$(B" . "$B$T$'$$(B"))
    ("pgz" nil ("$B%T%c%s(B" . "$B$T$c$s(B"))
    ("ph" nil ("$B%W%&(B" . "$B$W$&(B"))
    ("pj" nil ("$B%W%s(B" . "$B$W$s(B"))
    ("pk" nil ("$B%T%s(B" . "$B$T$s(B"))
    ("pl" nil ("$B%]%s(B" . "$B$]$s(B"))
    ("pn" nil ("$B%Q%s(B" . "$B$Q$s(B"))
    ("pp" nil ("$B%]%&(B" . "$B$]$&(B"))
    ("pq" nil ("$B%Q%$(B" . "$B$Q$$(B"))
    ("pv" nil ("$B%]%&(B" . "$B$]$&(B"))
    ("pw" nil ("$B%Z%$(B" . "$B$Z$$(B"))
    ("pyd" nil ("$B%T%'%s(B" . "$B$T$'$s(B"))
    ("pyh" nil ("$B%T%e%&(B" . "$B$T$e$&(B"))
    ("pyj" nil ("$B%T%e%s(B" . "$B$T$e$s(B"))
    ("pyl" nil ("$B%T%g%s(B" . "$B$T$g$s(B"))
    ("pyn" nil ("$B%T%c%s(B" . "$B$T$c$s(B"))
    ("pyp" nil ("$B%T%g%&(B" . "$B$T$g$&(B"))
    ("pyq" nil ("$B%T%c%$(B" . "$B$T$c$$(B"))
    ("pyw" nil ("$B%T%'%$(B" . "$B$T$'$$(B"))
    ("pyz" nil ("$B%T%c%s(B" . "$B$T$c$s(B"))
    ("pz" nil ("$B%Q%s(B" . "$B$Q$s(B"))
    ("q" nil ("$B%s(B" . "$B$s(B"))
    ("rd" nil ("$B%l%s(B" . "$B$l$s(B"))
    ("rh" nil ("$B%k%&(B" . "$B$k$&(B"))
    ("rj" nil ("$B%k%s(B" . "$B$k$s(B"))
    ("rk" nil ("$B%j%s(B" . "$B$j$s(B"))
    ("rl" nil ("$B%m%s(B" . "$B$m$s(B"))
    ("rn" nil ("$B%i%s(B" . "$B$i$s(B"))
    ("rp" nil ("$B%m%&(B" . "$B$m$&(B"))
    ("rq" nil ("$B%i%$(B" . "$B$i$$(B"))
    ("rr" nil ("$B%i%l(B" . "$B$i$l(B"))
    ("rw" nil ("$B%l%$(B" . "$B$l$$(B"))
    ("ryd" nil ("$B%j%'%s(B" . "$B$j$'$s(B"))
    ("ryh" nil ("$B%j%e%&(B" . "$B$j$e$&(B"))
    ("ryj" nil ("$B%j%e%s(B" . "$B$j$e$s(B"))
    ("ryk" nil ("$B%j%g%/(B" . "$B$j$g$/(B"))
    ("ryl" nil ("$B%j%g%s(B" . "$B$j$g$s(B"))
    ("ryn" nil ("$B%j%c%s(B" . "$B$j$c$s(B"))
    ("ryp" nil ("$B%j%g%&(B" . "$B$j$g$&(B"))
    ("ryq" nil ("$B%j%c%$(B" . "$B$j$c$$(B"))
    ("ryw" nil ("$B%j%'%$(B" . "$B$j$'$$(B"))
    ("ryz" nil ("$B%j%c%s(B" . "$B$j$c$s(B"))
    ("rz" nil ("$B%i%s(B" . "$B$i$s(B"))
    ("sd" nil ("$B%;%s(B" . "$B$;$s(B"))
    ("sf" nil ("$B%5%$(B" . "$B$5$$(B"))
    ("sh" nil ("$B%9%&(B" . "$B$9$&(B"))
    ("sj" nil ("$B%9%s(B" . "$B$9$s(B"))
    ("sk" nil ("$B%7%s(B" . "$B$7$s(B"))
    ("sl" nil ("$B%=%s(B" . "$B$=$s(B"))
    ("sm" nil ("$B%7%b(B" . "$B$7$b(B"))
    ("sn" nil ("$B%5%s(B" . "$B$5$s(B"))
    ("sp" nil ("$B%=%&(B" . "$B$=$&(B"))
    ("sq" nil ("$B%5%$(B" . "$B$5$$(B"))
    ("sr" nil ("$B%9%k(B" . "$B$9$k(B"))
    ("ss" nil ("$B%;%$(B" . "$B$;$$(B"))
    ("st" nil ("$B%7%?(B" . "$B$7$?(B"))
    ("sv" nil ("$B%5%$(B" . "$B$5$$(B"))
    ("sw" nil ("$B%;%$(B" . "$B$;$$(B"))
    ("syd" nil ("$B%7%'%s(B" . "$B$7$'$s(B"))
    ("syh" nil ("$B%7%e%&(B" . "$B$7$e$&(B"))
    ("syj" nil ("$B%7%e%s(B" . "$B$7$e$s(B"))
    ("syl" nil ("$B%7%g%s(B" . "$B$7$g$s(B"))
    ("syp" nil ("$B%7%g%&(B" . "$B$7$g$&(B"))
    ("syq" nil ("$B%7%c%$(B" . "$B$7$c$$(B"))
    ("syw" nil ("$B%7%'%$(B" . "$B$7$'$$(B"))
    ("syz" nil ("$B%7%c%s(B" . "$B$7$c$s(B"))
    ("sz" nil ("$B%5%s(B" . "$B$5$s(B"))
    ("tU" nil ("$B%C(B" . "$B$C(B"))
    ("tb" nil ("$B%?%S(B" . "$B$?$S(B"))
    ("td" nil ("$B%F%s(B" . "$B$F$s(B"))
    ("tgh" nil ("$B%F%e!<(B" . "$B$F$e!<(B"))
    ("tgi" nil ("$B%F%#(B" . "$B$F$#(B"))
    ("tgk" nil ("$B%F%#%s(B" . "$B$F$#$s(B"))
    ("tgp" nil ("$B%H%%!<(B" . "$B$H$%!<(B"))
    ("tgu" nil ("$B%F%e(B" . "$B$F$e(B"))
    ("th" nil ("$B%D%&(B" . "$B$D$&(B"))
    ("tj" nil ("$B%D%s(B" . "$B$D$s(B"))
    ("tk" nil ("$B%A%s(B" . "$B$A$s(B"))
    ("tl" nil ("$B%H%s(B" . "$B$H$s(B"))
    ("tm" nil ("$B%?%a(B" . "$B$?$a(B"))
    ("tn" nil ("$B%?%s(B" . "$B$?$s(B"))
    ("tp" nil ("$B%H%&(B" . "$B$H$&(B"))
    ("tq" nil ("$B%?%$(B" . "$B$?$$(B"))
    ("tr" nil ("$B%?%i(B" . "$B$?$i(B"))
    ("tsU" nil ("$B%C(B" . "$B$C(B"))
    ("tsa" nil ("$B%D%!(B" . "$B$D$!(B"))
    ("tse" nil ("$B%D%'(B" . "$B$D$'(B"))
    ("tsi" nil ("$B%D%#(B" . "$B$D$#(B"))
    ("tso" nil ("$B%D%)(B" . "$B$D$)(B"))
    ("tt" nil ("$B%?%A(B" . "$B$?$A(B"))
    ("tw" nil ("$B%F%$(B" . "$B$F$$(B"))
    ("tyd" nil ("$B%A%'%s(B" . "$B$A$'$s(B"))
    ("tyh" nil ("$B%A%e%&(B" . "$B$A$e$&(B"))
    ("tyj" nil ("$B%A%e%s(B" . "$B$A$e$s(B"))
    ("tyl" nil ("$B%A%g%s(B" . "$B$A$g$s(B"))
    ("tyn" nil ("$B%A%c%s(B" . "$B$A$c$s(B"))
    ("typ" nil ("$B%A%g%&(B" . "$B$A$g$&(B"))
    ("tyq" nil ("$B%A%c%$(B" . "$B$A$c$$(B"))
    ("tyw" nil ("$B%A%'%$(B" . "$B$A$'$$(B"))
    ("tyz" nil ("$B%A%c%s(B" . "$B$A$c$s(B"))
    ("tz" nil ("$B%?%s(B" . "$B$?$s(B"))
    ("vd" nil ("$B%t%'%s(B" . "$B$&!+$'$s(B"))
    ("vk" nil ("$B%t%#%s(B" . "$B$&!+$#$s(B"))
    ("vl" nil ("$B%t%)%s(B" . "$B$&!+$)$s(B"))
    ("vn" nil ("$B%t%!%s(B" . "$B$&!+$!$s(B"))
    ("vp" nil ("$B%t%)!<(B" . "$B$&!+$)!<(B"))
    ("vq" nil ("$B%t%!%$(B" . "$B$&!+$!$$(B"))
    ("vw" nil ("$B%t%'%$(B" . "$B$&!+$'$$(B"))
    ("vya" nil ("$B%t%c(B" . "$B$&!+$c(B"))
    ("vye" nil ("$B%t%'(B" . "$B$&!+$'(B"))
    ("vyo" nil ("$B%t%g(B" . "$B$&!+$g(B"))
    ("vyu" nil ("$B%t%e(B" . "$B$&!+$e(B"))
    ("vz" nil ("$B%t%!%s(B" . "$B$&!+$!$s(B"))
    ("wA" nil ("$B%n(B" . "$B$n(B"))
    ("wd" nil ("$B%&%'%s(B" . "$B$&$'$s(B"))
    ("wf" nil ("$B%o%$(B" . "$B$o$$(B"))
    ("wha" nil ("$B%&%!(B" . "$B$&$!(B"))
    ("whe" nil ("$B%&%'(B" . "$B$&$'(B"))
    ("whi" nil ("$B%&%#(B" . "$B$&$#(B"))
    ("who" nil ("$B%&%)(B" . "$B$&$)(B"))
    ("whu" nil ("$B%&(B" . "$B$&(B"))
    ("wk" nil ("$B%&%#%s(B" . "$B$&$#$s(B"))
    ("wl" nil ("$B%&%)%s(B" . "$B$&$)$s(B"))
    ("wn" nil ("$B%o%s(B" . "$B$o$s(B"))
    ("wp" nil ("$B%&%)!<(B" . "$B$&$)!<(B"))
    ("wq" nil ("$B%o%$(B" . "$B$o$$(B"))
    ("wr" nil ("$B%o%l(B" . "$B$o$l(B"))
    ("wso" nil ("$B%&%)(B" . "$B$&$)(B"))
    ("wt" nil ("$B%o%?(B" . "$B$o$?(B"))
    ("wz" nil ("$B%o%s(B" . "$B$o$s(B"))
    ("xa" nil ("$B%7%c(B" . "$B$7$c(B"))
    ("xc" nil ("$B%7%c(B" . "$B$7$c(B"))
    ("xd" nil ("$B%7%'%s(B" . "$B$7$'$s(B"))
    ("xe" nil ("$B%7%'(B" . "$B$7$'(B"))
    ("xf" nil ("$B%7%'%$(B" . "$B$7$'$$(B"))
    ("xh" nil ("$B%7%e%&(B" . "$B$7$e$&(B"))
    ("xi" nil ("$B%7(B" . "$B$7(B"))
    ("xj" nil ("$B%7%e%s(B" . "$B$7$e$s(B"))
    ("xk" nil ("$B%7%s(B" . "$B$7$s(B"))
    ("xl" nil ("$B%7%g%s(B" . "$B$7$g$s(B"))
    ("xn" nil ("$B%7%c%s(B" . "$B$7$c$s(B"))
    ("xo" nil ("$B%7%g(B" . "$B$7$g(B"))
    ("xp" nil ("$B%7%g%&(B" . "$B$7$g$&(B"))
    ("xq" nil ("$B%7%c%$(B" . "$B$7$c$$(B"))
    ("xt" nil ("$B%7%e%D(B" . "$B$7$e$D(B"))
    ("xu" nil ("$B%7%e(B" . "$B$7$e(B"))
    ("xv" nil ("$B%7%c%$(B" . "$B$7$c$$(B"))
    ("xw" nil ("$B%7%'%$(B" . "$B$7$'$$(B"))
    ("xxa" nil ("$B%!(B" . "$B$!(B"))
    ("xxe" nil ("$B%'(B" . "$B$'(B"))
    ("xxi" nil ("$B%#(B" . "$B$#(B"))
    ("xxo" nil ("$B%)(B" . "$B$)(B"))
    ("xxu" nil ("$B%%(B" . "$B$%(B"))
    ("xxh" nil "$B"+(B")
    ("xxj" nil "$B"-(B")
    ("xxk" nil "$B",(B")
    ("xxl" nil "$B"*(B")
    ("xz" nil ("$B%7%c%s(B" . "$B$7$c$s(B"))
    ("y<" nil "$B"+(B")
    ("y>" nil "$B"*(B")
    ("y^" nil "$B",(B")
    ("yf" nil ("$B%f(B" . "$B$f(B"))
    ("yh" nil ("$B%f%&(B" . "$B$f$&(B"))
    ("yi" nil ("$B%p(B" . "$B$p(B"))
    ("yj" nil ("$B%f%s(B" . "$B$f$s(B"))
    ("yl" nil ("$B%h%s(B" . "$B$h$s(B"))
    ("yn" nil ("$B%d%s(B" . "$B$d$s(B"))
    ("yp" nil ("$B%h%&(B" . "$B$h$&(B"))
    ("yq" nil ("$B%d%$(B" . "$B$d$$(B"))
    ("yr" nil ("$B%h%k(B" . "$B$h$k(B"))
    ("yv" nil ("$B%f%&(B" . "$B$f$&(B"))
    ("yz" nil ("$B%d%s(B" . "$B$d$s(B"))
    ("zc" nil ("$B%6(B" . "$B$6(B"))
    ("zd" nil ("$B%<%s(B" . "$B$<$s(B"))
    ("zf" nil ("$B%<(B" . "$B$<(B"))
    ("zh" nil ("$B%:%&(B" . "$B$:$&(B"))
    ("zj" nil ("$B%:%s(B" . "$B$:$s(B"))
    ("zk" nil ("$B%8%s(B" . "$B$8$s(B"))
    ("zl" nil ("$B%>%s(B" . "$B$>$s(B"))
    ("zn" nil ("$B%6%s(B" . "$B$6$s(B"))
    ("zp" nil ("$B%>%&(B" . "$B$>$&(B"))
    ("zq" nil ("$B%6%$(B" . "$B$6$$(B"))
    ("zr" nil ("$B%6%k(B" . "$B$6$k(B"))
    ("zv" nil ("$B%6%$(B" . "$B$6$$(B"))
    ("zw" nil ("$B%<%$(B" . "$B$<$$(B"))
    ("zx" nil ("$B%<%$(B" . "$B$<$$(B"))
    ("zyd" nil ("$B%8%'%s(B" . "$B$8$'$s(B"))
    ("zyh" nil ("$B%8%e%&(B" . "$B$8$e$&(B"))
    ("zyj" nil ("$B%8%e%s(B" . "$B$8$e$s(B"))
    ("zyl" nil ("$B%8%g%s(B" . "$B$8$g$s(B"))
    ("zyn" nil ("$B%8%c%s(B" . "$B$8$c$s(B"))
    ("zyp" nil ("$B%8%g%&(B" . "$B$8$g$&(B"))
    ("zyq" nil ("$B%8%c%$(B" . "$B$8$c$$(B"))
    ("zyw" nil ("$B%8%'%$(B" . "$B$8$'$$(B"))
    ("zyz" nil ("$B%8%c%s(B" . "$B$8$c$s(B"))
    ("zz" nil ("$B%6%s(B" . "$B$6$s(B"))))

(defvar skk-azik-keyboard-specific-additional-rom-kana-rule-list nil)

;; $B%-!<%\!<%I0MB8ItJ,!#(B
;; skk-azik-keyboard-type $B$,@_Dj$5$l$F$$$l$P0J2<$r<B9T!#(B
(if skk-azik-keyboard-type
    (cond
     ((eq skk-azik-keyboard-type 'jp106)
      (setq skk-set-henkan-point-key
            (append '(?+) skk-set-henkan-point-key))
      (setq skk-downcase-alist
            (append '((?+ . ?\;)) skk-downcase-alist))
      (setq skk-azik-keyboard-specific-additional-rom-kana-rule-list
	    '(("@" nil skk-toggle-characters)
	      ("x@" nil skk-today)
	      ("`" nil skk-set-henkan-point-subr)
	      (":" nil "$B!<(B"))))
     ((eq skk-azik-keyboard-type 'jp-pc98)
      (setq skk-set-henkan-point-key
            (append '(?+) skk-set-henkan-point-key))
      (setq skk-downcase-alist
            (append '((?+ . ?\;)) skk-downcase-alist))
      (setq skk-azik-keyboard-specific-additional-rom-kana-rule-list
	    '(("@" nil skk-toggle-characters)
	      ("x@" nil skk-today)
	      ("~" nil skk-set-henkan-point-subr)
	      ("x~" nil "~")
	      (":" nil "$B!<(B"))))
     (t
      (setq skk-set-henkan-point-key
            (append '(?:) skk-set-henkan-point-key))
      (setq skk-downcase-alist
            (append '((?: . ?\;)) skk-downcase-alist))
      (setq skk-azik-keyboard-specific-additional-rom-kana-rule-list
	    '(("\'" nil "$B!<(B")
	      ("x\'" nil "'")
	      ("[" nil skk-toggle-characters)
	      ("{" nil skk-set-henkan-point-subr)
	      ("x[" nil "$B!V(B"))))))

;; $B0J2<6&DL(B
(setq skk-set-henkan-point-key
      (append '(?Q ?X) skk-set-henkan-point-key))

;; skk-rom-kana-base-rule-list $B$+$iJQ495,B'$r:o=|$9$k(B
(dolist (str skk-azik-unnecessary-base-rule-list)
  (setq skk-rom-kana-base-rule-list
	(skk-del-alist str skk-rom-kana-base-rule-list)))

;; AZIK $BFCM-$NJQ495,B'$rDI2C$9$k(B
(dolist (rule (append skk-azik-keyboard-specific-additional-rom-kana-rule-list
		      skk-azik-additional-rom-kana-rule-list))
  (add-to-list 'skk-rom-kana-rule-list rule))

;; for jisx0201
(eval-after-load "skk-jisx0201"
  '(progn
     (dolist (str skk-azik-unnecessary-base-rule-list)
       (setq skk-jisx0201-base-rule-list
	     (skk-del-alist str skk-jisx0201-base-rule-list)))

     (dolist (rule (append skk-azik-keyboard-specific-additional-rom-kana-rule-list
			   skk-azik-additional-rom-kana-rule-list))
       (add-to-list 'skk-jisx0201-rule-list
		    (if (listp (nth 2 rule))
			(list (nth 0 rule) (nth 1 rule)
			      (japanese-hankaku (car (nth 2 rule))))
		      rule)))

     (setq skk-jisx0201-base-rule-tree
	   (skk-compile-rule-list skk-jisx0201-base-rule-list
				  skk-jisx0201-rule-list))))

(run-hooks 'skk-azik-load-hook)

(provide 'skk-azik)

;;; skk-azik.el ends here
