;;; skk-act.el --- $B3HD%%m!<%^;zF~NO(B "ACT" $B$r(B SKK $B$G;H$&$?$a$N@_Dj(B -*- coding: iso-2022-jp -*-

;; Copyright (C) 2003, 2007 IRIE Tetsuya <irie@t.email.ne.jp>

;; Author: IRIE Tetsuya <irie@t.email.ne.jp>
;; Keywords: japanese, mule, input method

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
;;
;; dvorak $BG[Ns$G$N3HD%%m!<%^;zF~NO(B "ACT" $B$r(B SKK $B$G;H$&$?$a$N@_Dj$G$9!%(B
;; "ACT" $B$K$D$$$F$O!$0J2<$N(B URL $B$r;2>H$7$F2<$5$$!%(B
;;   http://www1.vecceed.ne.jp/~bemu/act/act_index.html
;;
;; $B;H$$J}(B - $B2<5-$N@_Dj$r(B .skk $B$K2C$($F$/$@$5$$!%(B
;;          $B$=$N8e(B Emacs(Mule) $B$r:F5/F0$9$l$P(B skk $B$K$h$k(B ACT $B$G$N(B
;;          $BF~NO$,2DG=$G$9!%(B
;;
;;          (setq skk-use-act t)
;;
;;
;;   $BCm0U(B 1 - ACT $B$G$O(B "q" $B$r(B "$B$*$s(B" $B$NF~NO$K;H$&$N$G!$(B"q" $B$N$b$H$b$H$N(B
;;            $B5!G=$G$"$k(B `skk-toggle-characters' $B$O(B "\" $B$K3dEv$F$F$$$^$9!%(B
;;            SKK $BI8=`$G(B "\" $B$N(B `skk-input-by-code-or-menu' $B$O3dEv$F$F(B
;;            $B$$$J$$$N$G%^%K%e%"%k$G8F=P$9I,MW$,$"$j$^$9!%(B
;;
;;        2 - $BF1MM$K(B "Q" $B$b;HMQ$G$-$^$;$s$N$G(B
;;            `skk-set-henkan-point-subr' $B$O(B "|" $B$K3dEv$F$F$$$^$9!%(B
;;
;;        3 - $B=c@5$N(B ACT $B$G$O(B "la" $B$G(B "$B$!(B" $B$rF~NO$7$^$9!%$7$+$7(B
;;            SKK $B$G$O(B l $B$r(B ASCII/$B$+$J%b!<%I$N@Z$jBX$(%-!<$H$7$F(B
;;            $B;HMQ$9$k$N$G!$(B"`a" $B$G(B "$B$!(B" $B$rF~NO$G$-$k$h$&$K$7$F$$$^$9!%(B
;;
;;        4 - SKK $BI8=`$N(B "z*" ($B!V!A!W!V!D!W$J$I(B)$B!$(B"x*" ($B!V$#!W!V$n!W$J(B
;;            $B$I(B)$B$O(B "`*" $B$K3dEv$F$F$$$^$9!%(B
;;
;;        5 - $B%G%U%)%k%H$G$O;R2;$N8e$N(B "y" $B$K$O(B2$B=EJl2;$N(B "ui" $B$r3dEv$F(B
;;            $B$F$$$k$N$G!$(B"y" $B$r;H$C$?Y92;$NF~NO$OL58z$G$9!%(B"y" $B$r;H$C(B
;;            $B$FY92;$rF~NO$7$?$$>l9g$O(B `skk-act-use-normal-y' $B$r(B
;;            non-nil $B$K@_Dj$7$F(B skk $B$r5/F0$7$F2<$5$$!%(B(skk-act $B$r%m!<(B
;;            $B%I$7$?$H$-$NCM$,M-8z$K$J$j$^$9(B)
;;
;;   $B%-!<3dEv$FJQ99E@(B
;;                                  SKK$BI8=`(B     ACT
;;	`skk-toggle-characters'        q         \
;;	`skk-set-henkan-point-subr'    Q         |
;;	`skk-input-by-code-or-menu'    \     $B3dEv$F$J$7(B
;;	`skk-purge-from-jisyo'         X     $B3dEv$F$J$7(B

;;; Code:

(require 'skk)

(eval-when-compile
  (defvar skk-jisx0201-rule-list)
  (defvar skk-jisx0201-base-rule-list))

(defvar skk-act-unnecessary-base-rule-list
  (let ((list
	 `("bb" "cc" "dd" "ff" "gg" "jj" "kk" "pp" "rr" "ss" "tt" "vv"
	   "ww" "xx" "yy" "zz"
	   "cha" "che" "chi" "cho" "chu"
	   "dha" "dhe" "dhi" "dho" "dhu"
	   "ja" "je" "ji" "jo" "ju"
	   "jya" "jye" "jyi" "jyo" "jyu"
	   "ka" "ke" "ki" "ko" "ku"
	   "kya" "kye" "kyi" "kyo" "kyu"
	   "tsu"
	   "tha" "the" "thi" "tho" "thu"
	   "xa" "xe" "xi" "xo" "xu"
	   "xka" "xke"
	   "xtsu" "xtu"
	   "xwa" "xwe" "xwi"
	   "xya" "xyo" "xyu")))
    ;; skk-act-use-normal-y $B$,(B nil $B$G$"$l$PY92;$b:o=|(B
    (unless skk-act-use-normal-y
      (setq list
	    (append list
		    '("bya" "bye" "byi" "byo" "byu"
		      "cya" "cye" "cyi" "cyo" "cyu"
		      "dya" "dye" "dyi" "dyo" "dyu"
		      "fya" "fye" "fyi" "fyo" "fyu"
		      "gya" "gye" "gyi" "gyo" "gyu"
		      "hya" "hye" "hyi" "hyo" "hyu"
		      "mya" "mye" "myi" "myo" "myu"
		      "nya" "nye" "nyi" "nyo" "nyu"
		      "pya" "pye" "pyi" "pyo" "pyu"
		      "rya" "rye" "ryi" "ryo" "ryu"
		      "sya" "sye" "syi" "syo" "syu"
		      "tya" "tye" "tyi" "tyo" "tyu"
		      "zya" "zye" "zyi" "zyo" "zyu"))))
    list))

(defvar skk-act-additional-rom-kana-rule-list
  (let ((list
	 '(("\\" nil skk-toggle-characters)
	   ("|" nil skk-set-henkan-point-subr)
	   ("`|" nil "|")
	   ("'" nil ("$B%C(B" . "$B$C(B"))
	   ("`'" nil "'")
	   ("`;" nil ";")
	   ("`:" nil ":")
	   ("`\"" nil "\"")
	   ;; $BI8=`$N(B x* $B$NCV$-49$((B
	   ("`a" nil ("$B%!(B" . "$B$!(B"))
	   ("`i" nil ("$B%#(B" . "$B$#(B"))
	   ("`u" nil ("$B%%(B" . "$B$%(B"))
	   ("`e" nil ("$B%'(B" . "$B$'(B"))
	   ("`o" nil ("$B%)(B" . "$B$)(B"))
	   ("`ca" nil ("$B%u(B" . "$B$+(B"))
	   ("`ce" nil ("$B%v(B" . "$B$1(B"))
	   ;;("`tsu" nil ("$B%C(B" . "$B$C(B"))	; $B!V",!W$H>WFM$9$k$N$G%3%a%s%H%"%&%H(B
	   ;;("`tu" nil ("$B%C(B" . "$B$C(B"))	; $B!V",!W$H>WFM$9$k$N$G%3%a%s%H%"%&%H(B
	   ("`wa" nil ("$B%n(B" . "$B$n(B"))
	   ("`we" nil ("$B%q(B" . "$B$q(B"))
	   ("`wi" nil ("$B%p(B" . "$B$p(B"))
	   ("`ya" nil ("$B%c(B" . "$B$c(B"))
	   ("`yo" nil ("$B%g(B" . "$B$g(B"))
	   ("`yu" nil ("$B%e(B" . "$B$e(B"))
	   ;; $B%d9T$N8_49%-!<(B
	   ("`ys" nil ("$B%c(B" . "$B$c(B"))	; $B%j%U%!%l%s%9$K$O$J$7(B
	   ("`yn" nil ("$B%g(B" . "$B$g(B"))	; $B%j%U%!%l%s%9$K$O$J$7(B
	   ("`yh" nil ("$B%e(B" . "$B$e(B"))	; $B%j%U%!%l%s%9$K$O$J$7(B
	   ;; $BI8=`$N(B z* $B$NCV$-49$((B
	   ("`," nil "$B!E(B")
	   ("`-" nil "$B!A(B")
	   ("`." nil "$B!D(B")
	   ("`/" nil "$B!&(B")
	   ("`[" nil "$B!X(B")
	   ("`]" nil "$B!Y(B")
	   ("`d" nil "$B"+(B")
	   ("`h" nil "$B"-(B")
	   ("`t" nil "$B",(B")
	   ("`n" nil "$B"*(B")
	   ;; $B$+9T$O(B c $B$r;H$&(B
	   ("ca" nil ("$B%+(B" . "$B$+(B"))
	   ("ci" nil ("$B%-(B" . "$B$-(B"))
	   ("cu" nil ("$B%/(B" . "$B$/(B"))
	   ("ce" nil ("$B%1(B" . "$B$1(B"))
	   ("co" nil ("$B%3(B" . "$B$3(B"))
	   ;; $B@62;!$By2;!$Y{2;3HD%!$Fs=EJl2;3HD%(B
	   (";" nil ("$B%"%s(B" . "$B$"$s(B"))
	   ("x" nil ("$B%$%s(B" . "$B$$$s(B"))
	   ("k" nil ("$B%&%s(B" . "$B$&$s(B"))
	   ("j" nil ("$B%(%s(B" . "$B$($s(B"))
	   ("q" nil ("$B%*%s(B" . "$B$*$s(B"))
	   ("c;" nil ("$B%+%s(B" . "$B$+$s(B"))
	   ("cx" nil ("$B%-%s(B" . "$B$-$s(B"))
	   ("ck" nil ("$B%/%s(B" . "$B$/$s(B"))
	   ("cj" nil ("$B%1%s(B" . "$B$1$s(B"))
	   ("cq" nil ("$B%3%s(B" . "$B$3$s(B"))
	   ("c'" nil ("$B%+%$(B" . "$B$+$$(B"))
	   ("cp" nil ("$B%/%&(B" . "$B$/$&(B"))
	   ("c." nil ("$B%1%$(B" . "$B$1$$(B"))
	   ("c," nil ("$B%3%&(B" . "$B$3$&(B"))
	   ("s;" nil ("$B%5%s(B" . "$B$5$s(B"))
	   ("sx" nil ("$B%7%s(B" . "$B$7$s(B"))
	   ("sk" nil ("$B%9%s(B" . "$B$9$s(B"))
	   ("sj" nil ("$B%;%s(B" . "$B$;$s(B"))
	   ("sq" nil ("$B%=%s(B" . "$B$=$s(B"))
	   ("s'" nil ("$B%5%$(B" . "$B$5$$(B"))
	   ("sp" nil ("$B%9%&(B" . "$B$9$&(B"))
	   ("s." nil ("$B%;%$(B" . "$B$;$$(B"))
	   ("s," nil ("$B%=%&(B" . "$B$=$&(B"))
	   ("t;" nil ("$B%?%s(B" . "$B$?$s(B"))
	   ("tx" nil ("$B%A%s(B" . "$B$A$s(B"))
	   ("tk" nil ("$B%D%s(B" . "$B$D$s(B"))
	   ("tj" nil ("$B%F%s(B" . "$B$F$s(B"))
	   ("tq" nil ("$B%H%s(B" . "$B$H$s(B"))
	   ("t'" nil ("$B%?%$(B" . "$B$?$$(B"))
	   ("tp" nil ("$B%D%&(B" . "$B$D$&(B"))
	   ("t." nil ("$B%F%$(B" . "$B$F$$(B"))
	   ("t," nil ("$B%H%&(B" . "$B$H$&(B"))
	   ("n;" nil ("$B%J%s(B" . "$B$J$s(B"))
	   ("nx" nil ("$B%K%s(B" . "$B$K$s(B"))
	   ("nk" nil ("$B%L%s(B" . "$B$L$s(B"))
	   ("nj" nil ("$B%M%s(B" . "$B$M$s(B"))
	   ("nq" nil ("$B%N%s(B" . "$B$N$s(B"))
	   ("n'" nil ("$B%J%$(B" . "$B$J$$(B"))
	   ("np" nil ("$B%L%&(B" . "$B$L$&(B"))
	   ("n." nil ("$B%M%$(B" . "$B$M$$(B"))
	   ("n," nil ("$B%N%&(B" . "$B$N$&(B"))
	   ("h;" nil ("$B%O%s(B" . "$B$O$s(B"))
	   ("hx" nil ("$B%R%s(B" . "$B$R$s(B"))
	   ("hk" nil ("$B%U%s(B" . "$B$U$s(B"))
	   ("hj" nil ("$B%X%s(B" . "$B$X$s(B"))
	   ("hq" nil ("$B%[%s(B" . "$B$[$s(B"))
	   ("h'" nil ("$B%O%$(B" . "$B$O$$(B"))
	   ("hp" nil ("$B%U%&(B" . "$B$U$&(B"))
	   ("h." nil ("$B%X%$(B" . "$B$X$$(B"))
	   ("h," nil ("$B%[%&(B" . "$B$[$&(B"))
	   ("m;" nil ("$B%^%s(B" . "$B$^$s(B"))
	   ("mx" nil ("$B%_%s(B" . "$B$_$s(B"))
	   ("mk" nil ("$B%`%s(B" . "$B$`$s(B"))
	   ("mj" nil ("$B%a%s(B" . "$B$a$s(B"))
	   ("mq" nil ("$B%b%s(B" . "$B$b$s(B"))
	   ("m'" nil ("$B%^%$(B" . "$B$^$$(B"))
	   ("mp" nil ("$B%`%&(B" . "$B$`$&(B"))
	   ("m." nil ("$B%a%$(B" . "$B$a$$(B"))
	   ("m," nil ("$B%b%&(B" . "$B$b$&(B"))
	   ("y;" nil ("$B%d%s(B" . "$B$d$s(B"))
	   ;;("yx" nil ("$B%$%s(B" . "$B$$$s(B"))	; $B%j%U%!%l%s%9$K$O$J$7(B
	   ("yk" nil ("$B%f%s(B" . "$B$f$s(B"))
	   ;;("yj" nil ("$B%$%'%s(B" . "$B$$$'$s(B"))	; $B%j%U%!%l%s%9$K$O$J$7(B
	   ("yq" nil ("$B%h%s(B" . "$B$h$s(B"))
	   ("y'" nil ("$B%d%$(B" . "$B$d$$(B"))
	   ("yp" nil ("$B%f%&(B" . "$B$f$&(B"))
	   ("y." nil ("$B%$%&(B" . "$B$$$&(B"))
	   ("y," nil ("$B%h%&(B" . "$B$h$&(B"))
	   ("r;" nil ("$B%i%s(B" . "$B$i$s(B"))
	   ("rx" nil ("$B%j%s(B" . "$B$j$s(B"))
	   ("rk" nil ("$B%k%s(B" . "$B$k$s(B"))
	   ("rj" nil ("$B%l%s(B" . "$B$l$s(B"))
	   ("rq" nil ("$B%m%s(B" . "$B$m$s(B"))
	   ("r'" nil ("$B%i%$(B" . "$B$i$$(B"))
	   ("rp" nil ("$B%k%&(B" . "$B$k$&(B"))
	   ("r." nil ("$B%l%$(B" . "$B$l$$(B"))
	   ("r," nil ("$B%m%&(B" . "$B$m$&(B"))
	   ("w;" nil ("$B%o%s(B" . "$B$o$s(B"))
	   ("wx" nil ("$B%&%#%s(B" . "$B$&$#$s(B"))
	   ("wk" nil ("$B%&%s(B" . "$B$&$s(B"))
	   ("wj" nil ("$B%&%'%s(B" . "$B$&$'$s(B"))
	   ("wq" nil ("$B%&%)%s(B" . "$B$&$)$s(B"))
	   ("w'" nil ("$B%o%$(B" . "$B$o$$(B"))
	   ("wp" nil ("$B%&%%(B" . "$B$&$%(B"))
	   ("w." nil ("$B%&%'%$(B" . "$B$&$'$$(B"))
	   ("w," nil ("$B%&%)!<(B" . "$B$&$)!<(B"))
	   ("g;" nil ("$B%,%s(B" . "$B$,$s(B"))
	   ("gx" nil ("$B%.%s(B" . "$B$.$s(B"))
	   ("gk" nil ("$B%0%s(B" . "$B$0$s(B"))
	   ("gj" nil ("$B%2%s(B" . "$B$2$s(B"))
	   ("gq" nil ("$B%4%s(B" . "$B$4$s(B"))
	   ("g'" nil ("$B%,%$(B" . "$B$,$$(B"))
	   ("gp" nil ("$B%0%&(B" . "$B$0$&(B"))
	   ("g." nil ("$B%2%$(B" . "$B$2$$(B"))
	   ("g," nil ("$B%4%&(B" . "$B$4$&(B"))
	   ("z;" nil ("$B%6%s(B" . "$B$6$s(B"))
	   ("zx" nil ("$B%8%s(B" . "$B$8$s(B"))
	   ("zk" nil ("$B%:%s(B" . "$B$:$s(B"))
	   ("zj" nil ("$B%<%s(B" . "$B$<$s(B"))
	   ("zq" nil ("$B%>%s(B" . "$B$>$s(B"))
	   ("z'" nil ("$B%6%$(B" . "$B$6$$(B"))
	   ("zp" nil ("$B%:%&(B" . "$B$:$&(B"))
	   ("z." nil ("$B%<%$(B" . "$B$<$$(B"))
	   ("z," nil ("$B%>%&(B" . "$B$>$&(B"))
	   ("d;" nil ("$B%@%s(B" . "$B$@$s(B"))
	   ("dx" nil ("$B%B%s(B" . "$B$B$s(B"))
	   ("dk" nil ("$B%E%s(B" . "$B$E$s(B"))
	   ("dj" nil ("$B%G%s(B" . "$B$G$s(B"))
	   ("dq" nil ("$B%I%s(B" . "$B$I$s(B"))
	   ("d'" nil ("$B%@%$(B" . "$B$@$$(B"))
	   ("dp" nil ("$B%E%&(B" . "$B$E$&(B"))
	   ("d." nil ("$B%G%$(B" . "$B$G$$(B"))
	   ("d," nil ("$B%I%&(B" . "$B$I$&(B"))
	   ("b;" nil ("$B%P%s(B" . "$B$P$s(B"))
	   ("bx" nil ("$B%S%s(B" . "$B$S$s(B"))
	   ("bk" nil ("$B%V%s(B" . "$B$V$s(B"))
	   ("bj" nil ("$B%Y%s(B" . "$B$Y$s(B"))
	   ("bq" nil ("$B%\%s(B" . "$B$\$s(B"))
	   ("b'" nil ("$B%P%$(B" . "$B$P$$(B"))
	   ("bp" nil ("$B%V%&(B" . "$B$V$&(B"))
	   ("b." nil ("$B%Y%$(B" . "$B$Y$$(B"))
	   ("b," nil ("$B%\%&(B" . "$B$\$&(B"))
	   ("p;" nil ("$B%Q%s(B" . "$B$Q$s(B"))
	   ("px" nil ("$B%T%s(B" . "$B$T$s(B"))
	   ("pk" nil ("$B%W%s(B" . "$B$W$s(B"))
	   ("pj" nil ("$B%Z%s(B" . "$B$Z$s(B"))
	   ("pq" nil ("$B%]%s(B" . "$B$]$s(B"))
	   ("p'" nil ("$B%Q%$(B" . "$B$Q$$(B"))
	   ("pp" nil ("$B%W%&(B" . "$B$W$&(B"))
	   ("p." nil ("$B%Z%$(B" . "$B$Z$$(B"))
	   ("p," nil ("$B%]%&(B" . "$B$]$&(B"))
	   ;; $BY92;!$Y{2;3HD%!$Fs=EJl2;3HD%(B
	   ("cga" nil ("$B%-%c(B" . "$B$-$c(B"))
	   ("cgi" nil ("$B%-%#(B" . "$B$-$#(B"))
	   ("cgu" nil ("$B%-%e(B" . "$B$-$e(B"))
	   ("cge" nil ("$B%-%'(B" . "$B$-$'(B"))
	   ("cgo" nil ("$B%-%g(B" . "$B$-$g(B"))
	   ("cg;" nil ("$B%-%c%s(B" . "$B$-$c$s(B"))
	   ("cgx" nil ("$B%-%#%s(B" . "$B$-$#$s(B"))
	   ("cgk" nil ("$B%-%e%s(B" . "$B$-$e$s(B"))
	   ("cgj" nil ("$B%-%'%s(B" . "$B$-$'$s(B"))
	   ("cgq" nil ("$B%-%g%s(B" . "$B$-$g$s(B"))
	   ("cg'" nil ("$B%-%c%$(B" . "$B$-$c$$(B"))
	   ("cgp" nil ("$B%-%e%&(B" . "$B$-$e$&(B"))
	   ("cg." nil ("$B%-%'%$(B" . "$B$-$'$$(B"))
	   ("cg," nil ("$B%-%g%&(B" . "$B$-$g$&(B"))
	   ;; $BI8=`$G$3$&$J$C$F$$$k$1$I0l1~(B
	   ("sha" nil ("$B%7%c(B" . "$B$7$c(B"))
	   ("shi" nil ("$B%7%#(B" . "$B$7$#(B"))	; $B%j%U%!%l%s%9$G$O(B `$B$7(B' $B$@$1$I(B
	   ("shu" nil ("$B%7%e(B" . "$B$7$e(B"))
	   ("she" nil ("$B%7%'(B" . "$B$7$'(B"))
	   ("sho" nil ("$B%7%g(B" . "$B$7$g(B"))
	   ("sh;" nil ("$B%7%c%s(B" . "$B$7$c$s(B"))
	   ("shx" nil ("$B%7%#%s(B" . "$B$7$#$s(B"))
	   ("shk" nil ("$B%7%e%s(B" . "$B$7$e$s(B"))
	   ("shj" nil ("$B%7%'%s(B" . "$B$7$'$s(B"))
	   ("shq" nil ("$B%7%g%s(B" . "$B$7$g$s(B"))
	   ("sh'" nil ("$B%7%c%$(B" . "$B$7$c$$(B"))
	   ("shp" nil ("$B%7%e%&(B" . "$B$7$e$&(B"))
	   ("sh." nil ("$B%7%'%$(B" . "$B$7$'$$(B"))
	   ("sh," nil ("$B%7%g%&(B" . "$B$7$g$&(B"))
	   ("tha" nil ("$B%A%c(B" . "$B$A$c(B"))
	   ("thi" nil ("$B%A%#(B" . "$B$A$#(B"))
	   ("thu" nil ("$B%A%e(B" . "$B$A$e(B"))
	   ("the" nil ("$B%A%'(B" . "$B$A$'(B"))
	   ("tho" nil ("$B%A%g(B" . "$B$A$g(B"))
	   ("th;" nil ("$B%A%c%s(B" . "$B$A$c$s(B"))
	   ("thx" nil ("$B%A%#%s(B" . "$B$A$#$s(B"))
	   ("thk" nil ("$B%A%e%s(B" . "$B$A$e$s(B"))
	   ("thj" nil ("$B%A%'%s(B" . "$B$A$'$s(B"))
	   ("thq" nil ("$B%A%g%s(B" . "$B$A$g$s(B"))
	   ("th'" nil ("$B%A%c%$(B" . "$B$A$c$$(B"))
	   ("thp" nil ("$B%A%e%&(B" . "$B$A$e$&(B"))
	   ("th." nil ("$B%A%'%$(B" . "$B$A$'$$(B"))
	   ("th," nil ("$B%A%g%&(B" . "$B$A$g$&(B"))
	   ("nha" nil ("$B%K%c(B" . "$B$K$c(B"))
	   ("nhi" nil ("$B%K%#(B" . "$B$K$#(B"))
	   ("nhu" nil ("$B%K%e(B" . "$B$K$e(B"))
	   ("nhe" nil ("$B%K%'(B" . "$B$K$'(B"))
	   ("nho" nil ("$B%K%g(B" . "$B$K$g(B"))
	   ("nh;" nil ("$B%K%c%s(B" . "$B$K$c$s(B"))
	   ("nhx" nil ("$B%K%#%s(B" . "$B$K$#$s(B"))
	   ("nhk" nil ("$B%K%e%s(B" . "$B$K$e$s(B"))
	   ("nhj" nil ("$B%K%'%s(B" . "$B$K$'$s(B"))
	   ("nhq" nil ("$B%K%g%s(B" . "$B$K$g$s(B"))
	   ("nh'" nil ("$B%K%c%$(B" . "$B$K$c$$(B"))
	   ("nhp" nil ("$B%K%e%&(B" . "$B$K$e$&(B"))
	   ("nh." nil ("$B%K%'%$(B" . "$B$K$'$$(B"))
	   ("nh," nil ("$B%K%g%&(B" . "$B$K$g$&(B"))
	   ("hna" nil ("$B%R%c(B" . "$B$R$c(B"))
	   ("hni" nil ("$B%R%#(B" . "$B$R$#(B"))
	   ("hnu" nil ("$B%R%e(B" . "$B$R$e(B"))
	   ("hne" nil ("$B%R%'(B" . "$B$R$'(B"))
	   ("hno" nil ("$B%R%g(B" . "$B$R$g(B"))
	   ("hn;" nil ("$B%R%c%s(B" . "$B$R$c$s(B"))
	   ("hnx" nil ("$B%R%#%s(B" . "$B$R$#$s(B"))
	   ("hnk" nil ("$B%R%e%s(B" . "$B$R$e$s(B"))
	   ("hnj" nil ("$B%R%'%s(B" . "$B$R$'$s(B"))
	   ("hnq" nil ("$B%R%g%s(B" . "$B$R$g$s(B"))
	   ("hn'" nil ("$B%R%c%$(B" . "$B$R$c$$(B"))
	   ("hnp" nil ("$B%R%e%&(B" . "$B$R$e$&(B"))
	   ("hn." nil ("$B%R%'%$(B" . "$B$R$'$$(B"))
	   ("hn," nil ("$B%R%g%&(B" . "$B$R$g$&(B"))
	   ("mva" nil ("$B%_%c(B" . "$B$_$c(B"))
	   ("mvi" nil ("$B%_%#(B" . "$B$_$#(B"))
	   ("mvu" nil ("$B%_%e(B" . "$B$_$e(B"))
	   ("mve" nil ("$B%_%'(B" . "$B$_$'(B"))
	   ("mvo" nil ("$B%_%g(B" . "$B$_$g(B"))
	   ("mv;" nil ("$B%_%c%s(B" . "$B$_$c$s(B"))
	   ("mvx" nil ("$B%_%#%s(B" . "$B$_$#$s(B"))
	   ("mvk" nil ("$B%_%e%s(B" . "$B$_$e$s(B"))
	   ("mvj" nil ("$B%_%'%s(B" . "$B$_$'$s(B"))
	   ("mvq" nil ("$B%_%g%s(B" . "$B$_$g$s(B"))
	   ("mv'" nil ("$B%_%c%$(B" . "$B$_$c$$(B"))
	   ("mvp" nil ("$B%_%e%&(B" . "$B$_$e$&(B"))
	   ("mv." nil ("$B%_%'%$(B" . "$B$_$'$$(B"))
	   ("mv," nil ("$B%_%g%&(B" . "$B$_$g$&(B"))
	   ("rga" nil ("$B%j%c(B" . "$B$j$c(B"))
	   ("rgi" nil ("$B%j%#(B" . "$B$j$#(B"))
	   ("rgu" nil ("$B%j%e(B" . "$B$j$e(B"))
	   ("rge" nil ("$B%j%'(B" . "$B$j$'(B"))
	   ("rgo" nil ("$B%j%g(B" . "$B$j$g(B"))
	   ("rg;" nil ("$B%j%c%s(B" . "$B$j$c$s(B"))
	   ("rgx" nil ("$B%j%#%s(B" . "$B$j$#$s(B"))
	   ("rgk" nil ("$B%j%e%s(B" . "$B$j$e$s(B"))
	   ("rgj" nil ("$B%j%'%s(B" . "$B$j$'$s(B"))
	   ("rgq" nil ("$B%j%g%s(B" . "$B$j$g$s(B"))
	   ("rg'" nil ("$B%j%c%$(B" . "$B$j$c$$(B"))
	   ("rgp" nil ("$B%j%e%&(B" . "$B$j$e$&(B"))
	   ("rg." nil ("$B%j%'%$(B" . "$B$j$'$$(B"))
	   ("rg," nil ("$B%j%g%&(B" . "$B$j$g$&(B"))
	   ("gra" nil ("$B%.%c(B" . "$B$.$c(B"))
	   ("gri" nil ("$B%.%#(B" . "$B$.$#(B"))
	   ("gru" nil ("$B%.%e(B" . "$B$.$e(B"))
	   ("gre" nil ("$B%.%'(B" . "$B$.$'(B"))
	   ("gro" nil ("$B%.%g(B" . "$B$.$g(B"))
	   ("gr;" nil ("$B%.%c%s(B" . "$B$.$c$s(B"))
	   ("grx" nil ("$B%.%#%s(B" . "$B$.$#$s(B"))
	   ("grk" nil ("$B%.%e%s(B" . "$B$.$e$s(B"))
	   ("grj" nil ("$B%.%'%s(B" . "$B$.$'$s(B"))
	   ("grq" nil ("$B%.%g%s(B" . "$B$.$g$s(B"))
	   ("gr'" nil ("$B%.%c%$(B" . "$B$.$c$$(B"))
	   ("grp" nil ("$B%.%e%&(B" . "$B$.$e$&(B"))
	   ("gr." nil ("$B%.%'%$(B" . "$B$.$'$$(B"))
	   ("gr," nil ("$B%.%g%&(B" . "$B$.$g$&(B"))
	   ("zma" nil ("$B%8%c(B" . "$B$8$c(B"))
	   ("zmi" nil ("$B%8%#(B" . "$B$8$#(B"))
	   ("zmu" nil ("$B%8%e(B" . "$B$8$e(B"))
	   ("zme" nil ("$B%8%'(B" . "$B$8$'(B"))
	   ("zmo" nil ("$B%8%g(B" . "$B$8$g(B"))
	   ("zm;" nil ("$B%8%c%s(B" . "$B$8$c$s(B"))
	   ("zmx" nil ("$B%8%#%s(B" . "$B$8$#$s(B"))
	   ("zmk" nil ("$B%8%e%s(B" . "$B$8$e$s(B"))
	   ("zmj" nil ("$B%8%'%s(B" . "$B$8$'$s(B"))
	   ("zmq" nil ("$B%8%g%s(B" . "$B$8$g$s(B"))
	   ("zm'" nil ("$B%8%c%$(B" . "$B$8$c$$(B"))
	   ("zmp" nil ("$B%8%e%&(B" . "$B$8$e$&(B"))
	   ("zm." nil ("$B%8%'%$(B" . "$B$8$'$$(B"))
	   ("zm," nil ("$B%8%g%&(B" . "$B$8$g$&(B"))
	   ("dna" nil ("$B%B%c(B" . "$B$B$c(B"))
	   ("dni" nil ("$B%B%#(B" . "$B$B$#(B"))
	   ("dnu" nil ("$B%B%e(B" . "$B$B$e(B"))
	   ("dne" nil ("$B%B%'(B" . "$B$B$'(B"))
	   ("dno" nil ("$B%B%g(B" . "$B$B$g(B"))
	   ("dn;" nil ("$B%B%c%s(B" . "$B$B$c$s(B"))
	   ("dnx" nil ("$B%B%#%s(B" . "$B$B$#$s(B"))
	   ("dnk" nil ("$B%B%e%s(B" . "$B$B$e$s(B"))
	   ("dnj" nil ("$B%B%'%s(B" . "$B$B$'$s(B"))
	   ("dnq" nil ("$B%B%g%s(B" . "$B$B$g$s(B"))
	   ("dn'" nil ("$B%B%c%$(B" . "$B$B$c$$(B"))
	   ("dnp" nil ("$B%B%e%&(B" . "$B$B$e$&(B"))
	   ("dn." nil ("$B%B%'%$(B" . "$B$B$'$$(B"))
	   ("dn," nil ("$B%B%g%&(B" . "$B$B$g$&(B"))
	   ("bva" nil ("$B%S%c(B" . "$B$S$c(B"))
	   ("bvi" nil ("$B%S%#(B" . "$B$S$#(B"))
	   ("bvu" nil ("$B%S%e(B" . "$B$S$e(B"))
	   ("bve" nil ("$B%S%'(B" . "$B$S$'(B"))
	   ("bvo" nil ("$B%S%g(B" . "$B$S$g(B"))
	   ("bv;" nil ("$B%S%c%s(B" . "$B$S$c$s(B"))
	   ("bvx" nil ("$B%S%#%s(B" . "$B$S$#$s(B"))
	   ("bvk" nil ("$B%S%e%s(B" . "$B$S$e$s(B"))
	   ("bvj" nil ("$B%S%'%s(B" . "$B$S$'$s(B"))
	   ("bvq" nil ("$B%S%g%s(B" . "$B$S$g$s(B"))
	   ("bv'" nil ("$B%S%c%$(B" . "$B$S$c$$(B"))
	   ("bvp" nil ("$B%S%e%&(B" . "$B$S$e$&(B"))
	   ("bv." nil ("$B%S%'%$(B" . "$B$S$'$$(B"))
	   ("bv," nil ("$B%S%g%&(B" . "$B$S$g$&(B"))
	   ("pna" nil ("$B%T%c(B" . "$B$T$c(B"))
	   ("pni" nil ("$B%T%#(B" . "$B$T$#(B"))
	   ("pnu" nil ("$B%T%e(B" . "$B$T$e(B"))
	   ("pne" nil ("$B%T%'(B" . "$B$T$'(B"))
	   ("pno" nil ("$B%T%g(B" . "$B$T$g(B"))
	   ("pn;" nil ("$B%T%c%s(B" . "$B$T$c$s(B"))
	   ("pnx" nil ("$B%T%#%s(B" . "$B$T$#$s(B"))
	   ("pnk" nil ("$B%T%e%s(B" . "$B$T$e$s(B"))
	   ("pnj" nil ("$B%T%'%s(B" . "$B$T$'$s(B"))
	   ("pnq" nil ("$B%T%g%s(B" . "$B$T$g$s(B"))
	   ("pn'" nil ("$B%T%c%$(B" . "$B$T$c$$(B"))
	   ("pnp" nil ("$B%T%e%&(B" . "$B$T$e$&(B"))
	   ("pn." nil ("$B%T%'%$(B" . "$B$T$'$$(B"))
	   ("pn," nil ("$B%T%g%&(B" . "$B$T$g$&(B"))
	   ;; $BY92;(B(2$B%9%H%m!<%/7O(B)$B!$Y{2;3HD%!$Fs=EJl2;3HD%(B
	   ("f;" nil ("$B%U%!%s(B" . "$B$U$!$s(B"))
	   ("fx" nil ("$B%U%#%s(B" . "$B$U$#$s(B"))
	   ("fk" nil ("$B%U%s(B" . "$B$U$s(B"))
	   ("fj" nil ("$B%U%'%s(B" . "$B$U$'$s(B"))
	   ("fq" nil ("$B%U%)%s(B" . "$B$U$)$s(B"))
	   ("f'" nil ("$B%U%!%$(B" . "$B$U$!$$(B"))
	   ("fp" nil ("$B%U%&(B" . "$B$U$&(B"))
	   ("f." nil ("$B%U%'%$(B" . "$B$U$'$$(B"))
	   ("f," nil ("$B%U%)!<(B" . "$B$U$)!<(B"))
	   ("v;" nil ("$B%t%!%s(B" . "$B$&!+$!$s(B"))
	   ("vx" nil ("$B%t%#%s(B" . "$B$&!+$#$s(B"))
	   ("vk" nil ("$B%t%s(B" . "$B$&!+$s(B"))
	   ("vj" nil ("$B%t%'%s(B" . "$B$&!+$'$s(B"))
	   ("vq" nil ("$B%t%)%s(B" . "$B$&!+$)$s(B"))
	   ("v'" nil ("$B%t%!%$(B" . "$B$&!+$!$$(B"))
	   ("vp" nil ("$B%t!<(B" . "$B$&!+!<(B"))
	   ("v." nil ("$B%t%'%$(B" . "$B$&!+$'$$(B"))
	   ("v," nil ("$B%t%)!<(B" . "$B$&!+$)!<(B"))
	   ;; $BIQ=PY92;$N>JN,BG$A(B
	   ("pc" nil ("$B%T%e%&(B" . "$B$T$e$&(B"))
	   ("pl" nil ("$B%T%g%&(B" . "$B$T$g$&(B"))
	   ("fc" nil ("$B%U%e!<(B" . "$B$U$e!<(B"))
	   ("fl" nil ("$B%U%)!<(B" . "$B$U$)!<(B"))
	   ("gc" nil ("$B%.%e%&(B" . "$B$.$e$&(B"))
	   ("gl" nil ("$B%.%g%&(B" . "$B$.$g$&(B"))
	   ("cc" nil ("$B%-%e%&(B" . "$B$-$e$&(B"))
	   ("cl" nil ("$B%-%g%&(B" . "$B$-$g$&(B"))
	   ("rc" nil ("$B%j%e%&(B" . "$B$j$e$&(B"))
	   ("rl" nil ("$B%j%g%&(B" . "$B$j$g$&(B"))
	   ("ht" nil ("$B%R%e%&(B" . "$B$R$e$&(B"))
	   ("hs" nil ("$B%R%g%&(B" . "$B$R$g$&(B"))
	   ("tt" nil ("$B%A%e%&(B" . "$B$A$e$&(B"))
	   ("ts" nil ("$B%A%g%&(B" . "$B$A$g$&(B"))
	   ("nt" nil ("$B%K%e%&(B" . "$B$K$e$&(B"))
	   ("ns" nil ("$B%K%g%&(B" . "$B$K$g$&(B"))
	   ("st" nil ("$B%7%e%&(B" . "$B$7$e$&(B"))
	   ("ss" nil ("$B%7%g%&(B" . "$B$7$g$&(B"))
	   ("bw" nil ("$B%S%e%&(B" . "$B$S$e$&(B"))
	   ("bz" nil ("$B%S%g%&(B" . "$B$S$g$&(B"))
	   ("mw" nil ("$B%_%e!<(B" . "$B$_$e!<(B"))
	   ("mz" nil ("$B%_%g%&(B" . "$B$_$g$&(B"))
	   ("wz" nil ("$B%&%)!<(B" . "$B$&$)!<(B"))
	   ("vw" nil ("$B%t%e!<(B" . "$B$&!+$e!<(B"))
	   ("vz" nil ("$B%t%)!<(B" . "$B$&!+$)!<(B"))
	   ("zw" nil ("$B%8%e%&(B" . "$B$8$e$&(B"))
	   ("zz" nil ("$B%8%g%&(B" . "$B$8$g$&(B"))
	   ;; $BY92;!\%/!&%D$N>JN,BG$A(B
	   ("grr" nil ("$B%.%g%/(B" . "$B$.$g$/(B"))
	   ("grl" nil ("$B%.%c%/(B" . "$B$.$c$/(B"))
	   ("cgr" nil ("$B%-%g%/(B" . "$B$-$g$/(B"))
	   ("cgl" nil ("$B%-%c%/(B" . "$B$-$c$/(B"))
	   ("rgr" nil ("$B%j%g%/(B" . "$B$j$g$/(B"))
	   ("rgl" nil ("$B%j%c%/(B" . "$B$j$c$/(B"))
	   ("hns" nil ("$B%R%c%/(B" . "$B$R$c$/(B"))
	   ("thn" nil ("$B%A%g%/(B" . "$B$A$g$/(B"))
	   ("ths" nil ("$B%A%c%/(B" . "$B$A$c$/(B"))
	   ("nhn" nil ("$B%K%g%/(B" . "$B$K$g$/(B"))
	   ("nhs" nil ("$B%K%c%/(B" . "$B$K$c$/(B"))
	   ("shn" nil ("$B%7%g%/(B" . "$B$7$g$/(B"))
	   ("shs" nil ("$B%7%c%/(B" . "$B$7$c$/(B"))
	   ("sht" nil ("$B%7%e%D(B" . "$B$7$e$D(B"))
	   ("pns" nil ("$B%T%c%/(B" . "$B$T$c$/(B"))
	   ("bvv" nil ("$B%S%g%/(B" . "$B$S$g$/(B"))
	   ("bvz" nil ("$B%S%c%/(B" . "$B$S$c$/(B"))
	   ("mvv" nil ("$B%_%g%/(B" . "$B$_$g$/(B"))
	   ("mvz" nil ("$B%_%c%/(B" . "$B$_$c$/(B"))
	   ("zmv" nil ("$B%8%g%/(B" . "$B$8$g$/(B"))
	   ("zmz" nil ("$B%8%c%/(B" . "$B$8$c$/(B"))
	   ("zmw" nil ("$B%8%e%D(B" . "$B$8$e$D(B"))
	   ("shh" nil ("$B%7%e%/(B" . "$B$7$e$/(B"))
	   ("zmm" nil ("$B%8%e%/(B" . "$B$8$e$/(B"))
	   ;; $B%d9T$N8_49%-!<(B
	   ("yh" nil ("$B%f(B" . "$B$f(B"))
	   ("yg" nil ("$B%f%&(B" . "$B$f$&(B"))
	   ("yz" nil ("$B%d%s(B" . "$B$d$s(B"))
	   ("ym" nil ("$B%f%s(B" . "$B$f$s(B"))
	   ("yv" nil ("$B%h%s(B" . "$B$h$s(B"))
	   ;; $B%Q9T$N8_49%-!<(B
	   ("ps" nil ("$B%Q(B" . "$B$Q(B"))
	   ("pd" nil ("$B%T(B" . "$B$T(B"))
	   ("ph" nil ("$B%W(B" . "$B$W(B"))
	   ("pt" nil ("$B%Z(B" . "$B$Z(B"))
	   ("pz" nil ("$B%Q%s(B" . "$B$Q$s(B"))
	   ("pb" nil ("$B%T%s(B" . "$B$T$s(B"))
	   ("pm" nil ("$B%W%s(B" . "$B$W$s(B"))
	   ("pw" nil ("$B%Z%s(B" . "$B$Z$s(B"))
	   ("pv" nil ("$B%]%s(B" . "$B$]$s(B"))
	   ;; $B%d9TIQ=PJ8;zNs$N>JN,BG$A(B
	   ("yy" nil ("$B%$%&(B" . "$B$$$&(B"))
	   ("yf" nil ("$B%h%j(B" . "$B$h$j(B"))
	   ("yc" nil ("$B%$%&(B" . "$B$$$&(B"))
	   ("yr" nil ("$B%h%k(B" . "$B$h$k(B"))
	   ("yl" nil ("$B%d%k(B" . "$B$d$k(B"))
	   ("yd" nil ("$B%h%$(B" . "$B$h$$(B"))
	   ("yt" nil ("$B%h%C%F(B" . "$B$h$C$F(B"))
	   ("yn" nil ("$B%h%/(B" . "$B$h$/(B"))
	   ("ys" nil ("$B%d%/(B" . "$B$d$/(B"))
	   ("yb" nil ("$B%f%S(B" . "$B$f$S(B"))
	   ("yw" nil ("$B%$%o%l(B" . "$B$$$o$l(B"))
	   ;; $B$=$NB>$NIQ=PJ8;zNs$N>JN,BG$A(B
	   ("ff" nil ("$B%U%j(B" . "$B$U$j(B"))
	   ("fg" nil ("$B%U%k(B" . "$B$U$k(B"))
	   ("fr" nil ("$B%U%k(B" . "$B$U$k(B"))
	   ("fn" nil ("$B%U%!%s(B" . "$B$U$!$s(B"))
	   ("fm" nil ("$B%U%`(B" . "$B$U$`(B"))
	   ("gt" nil ("$B%4%H(B" . "$B$4$H(B"))
	   ("gn" nil ("$B%4%/(B" . "$B$4$/(B"))
	   ("gs" nil ("$B%,%/(B" . "$B$,$/(B"))
	   ("cr" nil ("$B%+%i(B" . "$B$+$i(B"))
	   ("cd" nil ("$B%+%?(B" . "$B$+$?(B"))
	   ("ct" nil ("$B%3%H(B" . "$B$3$H(B"))
	   ("cb" nil ("$B%+%s%,%((B" . "$B$+$s$,$((B"))
	   ("cn" nil ("$B%3%/(B" . "$B$3$/(B"))
	   ("cs" nil ("$B%+%/(B" . "$B$+$/(B"))
	   ("rr" nil ("$B%i%l(B" . "$B$i$l(B"))
	   ("rn" nil ("$B%i%s(B" . "$B$i$s(B"))
	   ("dg" nil ("$B%@%,(B" . "$B$@$,(B"))
	   ("dc" nil ("$B%G%-(B" . "$B$G$-(B"))
	   ("dr" nil ("$B%G%"%k(B" . "$B$G$"$k(B"))
	   ("dl" nil ("$B%G%7%g%&(B" . "$B$G$7$g$&(B"))
	   ("dd" nil ("$B%N%G(B" . "$B$N$G(B"))
	   ("dt" nil ("$B%@%A(B" . "$B$@$A(B"))
	   ("ds" nil ("$B%G%9(B" . "$B$G$9(B"))
	   ("dm" nil ("$B%G%b(B" . "$B$G$b(B"))
	   ("hg" nil ("$B%U%k(B" . "$B$U$k(B"))
	   ("hc" nil ("$B%R%e%&(B" . "$B$R$e$&(B"))
	   ("hr" nil ("$B%R%H%j(B" . "$B$R$H$j(B"))
	   ("hl" nil ("$B%R%g%&(B" . "$B$R$g$&(B"))
	   ("hd" nil ("$B%[%I(B" . "$B$[$I(B"))
	   ("hh" nil ("$B%R%H(B" . "$B$R$H(B"))
	   ("hz" nil ("$B%R%8%g%&(B" . "$B$R$8$g$&(B"))
	   ("tf" nil ("$B%H%j(B" . "$B$H$j(B"))
	   ("tg" nil ("$B%H%7%F(B" . "$B$H$7$F(B"))
	   ("tc" nil ("$B%D%$%F(B" . "$B$D$$$F(B"))
	   ("tr" nil ("$B%H%3%m(B" . "$B$H$3$m(B"))
	   ("tl" nil ("$B%H%/(B" . "$B$H$/(B"))
	   ("td" nil ("$B%H%$%&(B" . "$B$H$$$&(B"))
	   ("tn" nil ("$B%H%N(B" . "$B$H$N(B"))
	   ("tb" nil ("$B%?%S(B" . "$B$?$S(B"))
	   ("tm" nil ("$B%?%a(B" . "$B$?$a(B"))
	   ("tv" nil ("$B%H%-(B" . "$B$H$-(B"))
	   ("tz" nil ("$B%F%-(B" . "$B$F$-(B"))
	   ("nf" nil ("$B%J%j(B" . "$B$J$j(B"))
	   ("nc" nil ("$B%K%D%$%F(B" . "$B$K$D$$$F(B"))
	   ("nr" nil ("$B%J%k(B" . "$B$J$k(B"))
	   ("nl" nil ("$B%J%C%?(B" . "$B$J$C$?(B"))
	   ("nd" nil ("$B%J%I(B" . "$B$J$I(B"))
	   ("nb" nil ("$B%J%1%l%P(B" . "$B$J$1$l$P(B"))
	   ("nm" nil ("$B%J%/%F%b(B" . "$B$J$/$F$b(B"))
	   ("nw" nil ("$B%J%/%F%O(B" . "$B$J$/$F$O(B"))
	   ("nz" nil ("$B%J%/(B" . "$B$J$/(B"))
	   ("sf" nil ("$B%5%j(B" . "$B$5$j(B"))
	   ("sg" nil ("$B%5%l(B" . "$B$5$l(B"))
	   ("sc" nil ("$B%7%?(B" . "$B$7$?(B"))
	   ("sr" nil ("$B%9%k(B" . "$B$9$k(B"))
	   ("sd" nil ("$B%5%l(B" . "$B$5$l(B"))
	   ("sm" nil ("$B%7%b(B" . "$B$7$b(B"))
	   ("snb" nil ("$B%7%J%1%l%P(B" . "$B$7$J$1$l$P(B"))
	   ("snm" nil ("$B%7%J%/%F%b(B" . "$B$7$J$/$F$b(B"))
	   ("snt" nil ("$B%7%J%/%F(B" . "$B$7$J$/$F(B"))
	   ("snw" nil ("$B%7%J%/%F%O(B" . "$B$7$J$/$F$O(B"))
	   ("sz" nil ("$B%=%l%>%l(B" . "$B$=$l$>$l(B"))
	   ("bc" nil ("$B%S%e%&(B" . "$B$S$e$&(B"))
	   ("br" nil ("$B%P%i(B" . "$B$P$i(B"))
	   ("bl" nil ("$B%S%g%&(B" . "$B$S$g$&(B"))
	   ("bh" nil ("$B%V%D(B" . "$B$V$D(B"))
	   ("bt" nil ("$B%Y%D(B" . "$B$Y$D(B"))
	   ("mc" nil ("$B%_%e!<(B" . "$B$_$e!<(B"))
	   ("mr" nil ("$B%^%k(B" . "$B$^$k(B"))
	   ("ml" nil ("$B%_%g%&(B" . "$B$_$g$&(B"))
	   ("md" nil ("$B%^%G(B" . "$B$^$G(B"))
	   ("mt" nil ("$B%^%?(B" . "$B$^$?(B"))
	   ("mn" nil ("$B%b%N(B" . "$B$b$N(B"))
	   ("ms" nil ("$B%^%9(B" . "$B$^$9(B"))
	   ("mm" nil ("$B%*%b(B" . "$B$*$b(B"))
	   ("wr" nil ("$B%o%l(B" . "$B$o$l(B"))
	   ("wt" nil ("$B%o%?%7(B" . "$B$o$?$7(B"))
	   ("wn" nil ("$B%o%l%o%l(B" . "$B$o$l$o$l(B"))
	   ("vm" nil ("$B%3%H%J(B" . "$B$3$H$J(B"))
	   ("vv" nil ("$B%*%J%8(B" . "$B$*$J$8(B"))
	   ("zc" nil ("$B%8%e%&(B" . "$B$8$e$&(B"))
	   ("zr" nil ("$B%6%k(B" . "$B$6$k(B"))
	   ("zt" nil ("$B%:%D(B" . "$B$:$D(B"))
	   ("zn" nil ("$B%>%/(B" . "$B$>$/(B"))
	   ("zs" nil ("$B%6%/(B" . "$B$6$/(B"))
	   ("pf" nil ("$B%W%j(B" . "$B$W$j(B"))
	   ("pg" nil ("$B%W%k(B" . "$B$W$k(B"))
	   ("pr" nil ("$B%W%m(B" . "$B$W$m(B"))
	   ;; $BY92;$NBG$AJ}(B($B30Mh8l(B)
	   ("twa" nil ("$B%F%c(B" . "$B$F$c(B"))
	   ("twi" nil ("$B%F%#(B" . "$B$F$#(B"))
	   ("twu" nil ("$B%F%e(B" . "$B$F$e(B"))
	   ("twe" nil ("$B%F%'(B" . "$B$F$'(B"))
	   ("two" nil ("$B%F%g(B" . "$B$F$g(B"))
	   ("tw;" nil ("$B%F%c%s(B" . "$B$F$c$s(B"))
	   ("twx" nil ("$B%F%#%s(B" . "$B$F$#$s(B"))
	   ("twk" nil ("$B%F%e%s(B" . "$B$F$e$s(B"))
	   ("twj" nil ("$B%F%'%s(B" . "$B$F$'$s(B"))
	   ("twq" nil ("$B%F%g%s(B" . "$B$F$g$s(B"))
	   ("tw'" nil ("$B%F%c%&(B" . "$B$F$c$&(B"))
	   ("twp" nil ("$B%F%e%&(B" . "$B$F$e$&(B"))
	   ("tw." nil ("$B%F%'%$(B" . "$B$F$'$$(B"))
	   ("tw," nil ("$B%F%g%&(B" . "$B$F$g$&(B"))
	   ("dba" nil ("$B%G%c(B" . "$B$G$c(B"))
	   ("dbi" nil ("$B%G%#(B" . "$B$G$#(B"))
	   ("dbu" nil ("$B%G%e(B" . "$B$G$e(B"))
	   ("dbe" nil ("$B%G%'(B" . "$B$G$'(B"))
	   ("dbo" nil ("$B%G%g(B" . "$B$G$g(B"))
	   ("db;" nil ("$B%G%c%s(B" . "$B$G$c$s(B"))
	   ("dbx" nil ("$B%G%#%s(B" . "$B$G$#$s(B"))
	   ("dbk" nil ("$B%G%e%s(B" . "$B$G$e$s(B"))
	   ("dbj" nil ("$B%G%'%s(B" . "$B$G$'$s(B"))
	   ("dbq" nil ("$B%G%g%s(B" . "$B$G$g$s(B"))
	   ("db'" nil ("$B%G%c%&(B" . "$B$G$c$&(B"))
	   ("dbp" nil ("$B%G%e%&(B" . "$B$G$e$&(B"))
	   ("db." nil ("$B%G%'%$(B" . "$B$G$'$$(B"))
	   ("db," nil ("$B%G%g%&(B" . "$B$G$g$&(B"))
	   ("wma" nil ("$B%&%!(B" . "$B$&$!(B"))
	   ("wmi" nil ("$B%&%#(B" . "$B$&$#(B"))
	   ("wmu" nil ("$B%&%%(B" . "$B$&$%(B"))
	   ("wme" nil ("$B%&%'(B" . "$B$&$'(B"))
	   ("wmo" nil ("$B%&%)(B" . "$B$&$)(B"))
	   ("wm;" nil ("$B%&%!%s(B" . "$B$&$!$s(B"))
	   ("wmx" nil ("$B%&%#%s(B" . "$B$&$#$s(B"))
	   ("wmk" nil ("$B%&%%%s(B" . "$B$&$%$s(B"))
	   ("wmj" nil ("$B%&%'%s(B" . "$B$&$'$s(B"))
	   ("wmq" nil ("$B%&%)%s(B" . "$B$&$)$s(B"))
	   ("wm'" nil ("$B%&%!%&(B" . "$B$&$!$&(B"))
	   ("wmp" nil ("$B%&%%%&(B" . "$B$&$%$&(B"))
	   ("wm." nil ("$B%&%'%$(B" . "$B$&$'$$(B"))
	   ("wm," nil ("$B%&%)%&(B" . "$B$&$)$&(B")))))
    (unless skk-act-use-normal-y
      (setq list
	    (append list
		    '(("cy" nil ("$B%/%$(B" . "$B$/$$(B"))
		      ("sy" nil ("$B%9%$(B" . "$B$9$$(B"))
		      ("ty" nil ("$B%D%$(B" . "$B$D$$(B"))
		      ("ny" nil ("$B%L%$(B" . "$B$L$$(B"))
		      ("hy" nil ("$B%U%$(B" . "$B$U$$(B"))
		      ("my" nil ("$B%`%$(B" . "$B$`$$(B"))
		      ("yy" nil ("$B%f%$(B" . "$B$f$$(B"))
		      ("ry" nil ("$B%k%$(B" . "$B$k$$(B"))
		      ("wy" nil ("$B%&%$(B" . "$B$&$$(B"))
		      ("gy" nil ("$B%0%$(B" . "$B$0$$(B"))
		      ("zy" nil ("$B%:%$(B" . "$B$:$$(B"))
		      ("dy" nil ("$B%E%$(B" . "$B$E$$(B"))
		      ("by" nil ("$B%V%$(B" . "$B$V$$(B"))
		      ("py" nil ("$B%W%$(B" . "$B$W$$(B"))
		      ("cgy" nil ("$B%-%e%$(B" . "$B$-$e$$(B"))
		      ("shy" nil ("$B%7%e%$(B" . "$B$7$e$$(B"))
		      ("thy" nil ("$B%A%e%$(B" . "$B$A$e$$(B"))
		      ("nhy" nil ("$B%K%e%$(B" . "$B$K$e$$(B"))
		      ("hny" nil ("$B%R%e%$(B" . "$B$R$e$$(B"))
		      ("mvy" nil ("$B%_%e%$(B" . "$B$_$e$$(B"))
		      ("rgy" nil ("$B%j%e%$(B" . "$B$j$e$$(B"))
		      ("gry" nil ("$B%.%e%$(B" . "$B$.$e$$(B"))
		      ("zmy" nil ("$B%8%e%$(B" . "$B$8$e$$(B"))
		      ("dny" nil ("$B%B%e%$(B" . "$B$B$e$$(B"))
		      ("bvy" nil ("$B%S%e%$(B" . "$B$S$e$$(B"))
		      ("pny" nil ("$B%T%e%$(B" . "$B$T$e$$(B"))
		      ("fy" nil ("$B%U%$(B" . "$B$U$$(B"))	; $B%j%U%!%l%s%9$K$O$J$7(B
		      ("vy" nil ("$B%t%$(B" . "$B$&!+$$(B"))	; $B%j%U%!%l%s%9$K$O$J$7(B
		      ("twy" nil ("$B%F%e%$(B" . "$B$F$e$$(B"))
		      ("dby" nil ("$B%G%e%$(B" . "$B$G$e$$(B"))
		      ("wmy" nil ("$B%&%%%$(B" . "$B$&$%$$(B"))))))
    ;; shift $B$r2!$7$?$^$^$NFs=EJl2;3HD%(B
    ;; `skk-special-midashi-char-list' $B$K(B
    ;; < > $B$,L5$$>l9g$N$_DI2C$9$k(B
    (unless (memq ?< skk-special-midashi-char-list)
      (setq list
	    (append list
		    '(("c<" nil ("$B%3%&(B" . "$B$3$&(B"))
		      ("s<" nil ("$B%=%&(B" . "$B$=$&(B"))
		      ("t<" nil ("$B%H%&(B" . "$B$H$&(B"))
		      ("n<" nil ("$B%N%&(B" . "$B$N$&(B"))
		      ("h<" nil ("$B%[%&(B" . "$B$[$&(B"))
		      ("m<" nil ("$B%b%&(B" . "$B$b$&(B"))
		      ("y<" nil ("$B%h%&(B" . "$B$h$&(B"))
		      ("r<" nil ("$B%m%&(B" . "$B$m$&(B"))
		      ("w<" nil ("$B%&%)!<(B" . "$B$&$)!<(B"))
		      ("g<" nil ("$B%4%&(B" . "$B$4$&(B"))
		      ("z<" nil ("$B%>%&(B" . "$B$>$&(B"))
		      ("d<" nil ("$B%I%&(B" . "$B$I$&(B"))
		      ("b<" nil ("$B%\%&(B" . "$B$\$&(B"))
		      ("p<" nil ("$B%]%&(B" . "$B$]$&(B"))
		      ("cg<" nil ("$B%-%g%&(B" . "$B$-$g$&(B"))
		      ("sh<" nil ("$B%7%g%&(B" . "$B$7$g$&(B"))
		      ("th<" nil ("$B%A%g%&(B" . "$B$A$g$&(B"))
		      ("nh<" nil ("$B%K%g%&(B" . "$B$K$g$&(B"))
		      ("hn<" nil ("$B%R%g%&(B" . "$B$R$g$&(B"))
		      ("mv<" nil ("$B%_%g%&(B" . "$B$_$g$&(B"))
		      ("rg<" nil ("$B%j%g%&(B" . "$B$j$g$&(B"))
		      ("gr<" nil ("$B%.%g%&(B" . "$B$.$g$&(B"))
		      ("zm<" nil ("$B%8%g%&(B" . "$B$8$g$&(B"))
		      ("dn<" nil ("$B%B%g%&(B" . "$B$B$g$&(B"))
		      ("bv<" nil ("$B%S%g%&(B" . "$B$S$g$&(B"))
		      ("pn<" nil ("$B%T%g%&(B" . "$B$T$g$&(B"))
		      ("f<" nil ("$B%U%)!<(B" . "$B$U$)!<(B"))
		      ("v<" nil ("$B%t%)!<(B" . "$B$&!+$)!<(B"))
		      ("tw<" nil ("$B%F%g%&(B" . "$B$F$g$&(B"))
		      ("db<" nil ("$B%G%g%&(B" . "$B$G$g$&(B"))
		      ("wm<" nil ("$B%&%)%&(B" . "$B$&$)$&(B"))))))
    (unless (memq ?> skk-special-midashi-char-list)
      (setq list
	    (append list
		    '(("c>" nil ("$B%1%$(B" . "$B$1$$(B"))
		      ("s>" nil ("$B%;%$(B" . "$B$;$$(B"))
		      ("t>" nil ("$B%F%$(B" . "$B$F$$(B"))
		      ("n>" nil ("$B%M%$(B" . "$B$M$$(B"))
		      ("h>" nil ("$B%X%$(B" . "$B$X$$(B"))
		      ("m>" nil ("$B%a%$(B" . "$B$a$$(B"))
		      ("y>" nil ("$B%$%&(B" . "$B$$$&(B"))
		      ("r>" nil ("$B%l%$(B" . "$B$l$$(B"))
		      ("w>" nil ("$B%&%'%$(B" . "$B$&$'$$(B"))
		      ("g>" nil ("$B%2%$(B" . "$B$2$$(B"))
		      ("z>" nil ("$B%<%$(B" . "$B$<$$(B"))
		      ("d>" nil ("$B%G%$(B" . "$B$G$$(B"))
		      ("b>" nil ("$B%Y%$(B" . "$B$Y$$(B"))
		      ("p>" nil ("$B%Z%$(B" . "$B$Z$$(B"))
		      ("cg>" nil ("$B%-%'%$(B" . "$B$-$'$$(B"))
		      ("sh>" nil ("$B%7%'%$(B" . "$B$7$'$$(B"))
		      ("th>" nil ("$B%A%'%$(B" . "$B$A$'$$(B"))
		      ("nh>" nil ("$B%K%'%$(B" . "$B$K$'$$(B"))
		      ("hn>" nil ("$B%R%'%$(B" . "$B$R$'$$(B"))
		      ("mv>" nil ("$B%_%'%$(B" . "$B$_$'$$(B"))
		      ("rg>" nil ("$B%j%'%$(B" . "$B$j$'$$(B"))
		      ("gr>" nil ("$B%.%'%$(B" . "$B$.$'$$(B"))
		      ("zm>" nil ("$B%8%'%$(B" . "$B$8$'$$(B"))
		      ("dn>" nil ("$B%B%'%$(B" . "$B$B$'$$(B"))
		      ("bv>" nil ("$B%S%'%$(B" . "$B$S$'$$(B"))
		      ("pn>" nil ("$B%T%'%$(B" . "$B$T$'$$(B"))
		      ("f>" nil ("$B%U%'%$(B" . "$B$U$'$$(B"))
		      ("v>" nil ("$B%t%'%$(B" . "$B$&!+$'$$(B"))
		      ("tw>" nil ("$B%F%'%$(B" . "$B$F$'$$(B"))
		      ("db>" nil ("$B%G%'%$(B" . "$B$G$'$$(B"))
		      ("wm>" nil ("$B%&%'%$(B" . "$B$&$'$$(B"))))))
    list))

;; " : $B$O(B ' ; $B$H$7$FJQ49$5$;$k(B
(setq skk-downcase-alist
      (append skk-downcase-alist '((?\" . ?\') (?: . ?\;))))

;; '$B!V$C!W(B ;$B!V$"$s!W(B Q$B!V$*$s!W(B X$B!V$$$s!W(B $B$rJQ49%]%$%s%H$K2C$($k(B
(setq skk-set-henkan-point-key
      (append skk-set-henkan-point-key '(?\" ?: ?Q ?X)))

;; skk-rom-kana-base-rule-list $B$+$iJQ495,B'$r:o=|$9$k(B
(dolist (str skk-act-unnecessary-base-rule-list)
  (setq skk-rom-kana-base-rule-list
	(skk-del-alist str skk-rom-kana-base-rule-list)))

;; skk-rom-kana-rule-list $B$+$iJQ495,B'$r:o=|$9$k(B
(let ((del-list '("hh" "mm")))
  (dolist (str del-list)
    (setq skk-rom-kana-rule-list
	  (skk-del-alist str skk-rom-kana-rule-list))))

;; ACT $BFCM-$NJQ495,B'$rDI2C$9$k(B
(dolist (rule skk-act-additional-rom-kana-rule-list)
  (add-to-list 'skk-rom-kana-rule-list rule))

;; for jisx0201
(eval-after-load "skk-jisx0201"
  '(progn
     (dolist (str skk-act-unnecessary-base-rule-list)
       (setq skk-jisx0201-base-rule-list
	     (skk-del-alist str skk-jisx0201-base-rule-list)))

     (let ((del-list '("hh" "mm")))
       (dolist (str del-list)
	 (setq skk-jisx0201-base-rule-list
	       (skk-del-alist str skk-jisx0201-base-rule-list))))

     (dolist (rule skk-act-additional-rom-kana-rule-list)
       (add-to-list 'skk-jisx0201-rule-list
		    (if (listp (nth 2 rule))
			(list (nth 0 rule) (nth 1 rule)
			      (japanese-hankaku (car (nth 2 rule))))
		      rule)))

     (setq skk-jisx0201-base-rule-tree
	   (skk-compile-rule-list skk-jisx0201-base-rule-list
				  skk-jisx0201-rule-list))))

(run-hooks 'skk-act-load-hook)

(provide 'skk-act)
;;; skk-act.el ends here
