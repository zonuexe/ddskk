;;; skk-cus.el -- SKK $B$N4JC1$+$9$?$^$$$:;n:nIJ(B
;; Copyright (C) 2001 SKK Development Team

;; Maintainer: SKK Development Team <skk@ring.gr.jp>
;; Keywords: japanese

;; This file is part of Daredevil SKK.

;; Daredevil SKK is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation; either versions 2, or (at your option) any later
;; version.

;; Daredevil SKK is distributed in the hope that it will be useful but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
;; more details.

;; You should have received a copy of the GNU General Public License along with
;; Daredevil SKK, see the file COPYING.  If not, write to the Free Software
;; Foundation Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

;;; Commentary:

;; ~/.skk $B$K(B

;; (require 'skk-cus)
;; (skk-cus-setup)

;; $B$H=q$/!#(B

;; SKK $B5/F08e$O(B M-x skk-customize $B$G@_Dj$9$k!#(B

;;; Code:

(eval-when-compile
  (require 'skk-macs))

(require 'skk-vars)
(require 'wid-edit)

(defvar skk-custom-file "~/.skk-cus")
(defvar skk-custom-params nil)
(defvar skk-custom-alist nil)
(defvar skk-custom-buffer-original nil)

(defconst skk-cus-params-visual
  '((skk-use-face
     (const :tag "$BJQ49Cf$K?'$r$D$1$k(B" t) "")
    (skk-use-color-cursor
     (const :tag "$B%+!<%=%k$K?'$r$D$1$k(B" t) "")
    (skk-japanese-message-and-error
     (const :tag "$B%a%C%;!<%8$OF|K\8l$GDLCN$9$k(B" t) "")
    (skk-show-annotation
     (const :tag "$BJQ49;~$KCp<a$rI=<($9$k(B" t) "")))

(defconst skk-cus-params-ui
  '((skk-egg-like-newline
     (const :tag "Return [Enter] $B%-!<$G3NDj$9$k(B" t) "")
    (skk-kakutei-early
     (const :tag "$BL@<(E*$J3NDj$r>JN,2DG=$K$9$k(B" t) "")
    (skk-delete-implies-kakutei
     (const :tag "$B"'%b!<%I$G(B BS $B$r2!$7$?$i3NDj$9$k(B" t) "")
    (skk-auto-insert-paren
     (const :tag "$BJD3g8L$r<+F0E*$KA^F~$9$k(B" t) "")))

(defconst skk-cus-params-henkan
  '((skk-auto-start-henkan
     (const :tag "$BFCDj$NJ8;z$NF~NO;~$K<+F0E*$KJQ49$r3+;O$9$k(B" t) "")
    (skk-henkan-okuri-strictly
     (const :tag "$BAw$j2>L>$,87L)$K@5$7$$8uJd$N$_I=<($9$k(B" t) "")
    (skk-henkan-strict-okuri-precedence
     (const :tag "$BAw$j2>L>$,87L)$K@5$7$$8uJd$rM%@h$7$FI=<($9$k(B" t) "")
    (skk-check-okurigana-on-touroku
     (choice :tag "$B<-=qEPO?;~$NM>7W$JAw$j2>L>$N<+F0=hM}$O!)(B"
      (const :tag "Auto" auto)
      (const :tag "Query" ask)
      (const :tag "Do Nothing" nil))
     "")))

(defconst skk-cus-params-search
  '((skk-use-look
     (const :tag "$BJd40$N;~$K(B look $B%3%^%s%I$r;H$&(B" t) "")
    (skk-auto-okuri-process
     (const :tag "$BAw$j$J$7JQ49$GAw$j$"$j8uJd$b8!:w$9$k(B" t) "")))

(defconst skk-cus-params-input
  '((skk-use-jisx0201-input-method
     (const :tag "$BH>3Q%+%J$rF~NO2DG=$K$9$k(B" t) "")
    (skk-use-kana-keyboard
     (const :tag "$B$+$JF~NO$r2DG=$K$9$k(B" t) "")))

(defconst skk-cus-params-misc
  '((skk-share-private-jisyo
     (const :tag "$BJ#?t$N(B SKK $B$,8D?M<-=q$r6&M-$9$k(B" t) "")))

(defun skk-custom-mode ()
  (kill-all-local-variables)
  (setq major-mode 'skk-custom-mode
	mode-name "SKK $B$N@_Dj(B")
  (use-local-map widget-keymap)
  (run-hooks 'skk-custom-mode-hook))

(defun skk-cus-info (params)
  (delq nil
	(mapcar
	 #'(lambda (el)
	     (let ((val (symbol-value (car el))))
	       (and val
		    (cons (car el) val))))
	 params)))

(defun skk-customize ()
  (interactive)
  (dolist (param (append skk-cus-params-visual
			 skk-cus-params-ui
			 skk-cus-params-henkan
			 skk-cus-params-search
			 skk-cus-params-input
			 skk-cus-params-misc))
    (let ((var (car param)))
      (when (and (eq 'const (caadr param))
		 (symbol-value var))
	(set var t))))
  (setq skk-custom-buffer-original (current-buffer))
  (let (
	(visual (mapcar #'(lambda (entry)
			   `(cons :format "%v%h\n"
				  :doc ,(nth 2 entry)
				  (const :format "" ,(nth 0 entry))
				  ,(nth 1 entry)))
		       skk-cus-params-visual))
	(ui (mapcar #'(lambda (entry)
			   `(cons :format "%v%h\n"
				  :doc ,(nth 2 entry)
				  (const :format "" ,(nth 0 entry))
				  ,(nth 1 entry)))
		       skk-cus-params-ui))
	(henkan (mapcar #'(lambda (entry)
			   `(cons :format "%v%h\n"
				  :doc ,(nth 2 entry)
				  (const :format "" ,(nth 0 entry))
				  ,(nth 1 entry)))
		       skk-cus-params-henkan))
	(search (mapcar #'(lambda (entry)
			   `(cons :format "%v%h\n"
				  :doc ,(nth 2 entry)
				  (const :format "" ,(nth 0 entry))
				  ,(nth 1 entry)))
		       skk-cus-params-search))
	(input (mapcar #'(lambda (entry)
			   `(cons :format "%v%h\n"
				  :doc ,(nth 2 entry)
				  (const :format "" ,(nth 0 entry))
				  ,(nth 1 entry)))
		       skk-cus-params-input))
	(misc (mapcar #'(lambda (entry)
			   `(cons :format "%v%h\n"
				  :doc ,(nth 2 entry)
				  (const :format "" ,(nth 0 entry))
				  ,(nth 1 entry)))
		       skk-cus-params-misc))
	(info (append
	       (skk-cus-info skk-cus-params-visual)
	       (skk-cus-info skk-cus-params-ui)
	       (skk-cus-info skk-cus-params-henkan)
	       (skk-cus-info skk-cus-params-search)
	       (skk-cus-info skk-cus-params-input)
	       (skk-cus-info skk-cus-params-misc))))
    (kill-buffer (get-buffer-create "*SKK $B$N4pK\@_Dj(B*"))
    (switch-to-buffer (get-buffer-create "*SKK $B$N4pK\@_Dj(B*"))
    (skk-custom-mode)
    (widget-insert "SKK $B$N4pK\@_Dj!#=*$o$C$?$i(B ")
    (widget-create 'push-button
		   :tag "done"
		   :help-echo "$B=*$o$C$?$i%\%/$r2!$7$F!#(B"
		   :action 'skk-customize-done)
    (widget-insert " $B$r2!$7$F$/$@$5$$!#(B\n\n")
    (setq skk-custom-params
	  (list
	   (widget-create 'group
			  :value info
			  `(set :inline t
				:greedy t
				:tag "$BI=<($K4X$9$k@_Dj(B"
				:format "%t:\n%h%v"
				:doc ""
				,@visual))
	   (widget-create 'group
			  :value info
			  `(set :inline t
				:greedy t
				:tag "$B4pK\E*$J%f!<%6!&%$%s%?!<%U%'!<%9(B"
				:format "%t:\n%h%v"
				:doc ""
				,@ui))
	   (widget-create 'group
			  :value info
			  `(set :inline t
				:greedy t
				:tag "$BJQ49$K4X$9$k@_Dj(B"
				:format "%t:\n%h%v"
				:doc ""
				,@henkan))
	   (widget-create 'group
			  :value info
			  `(set :inline t
				:greedy t
				:tag "$B<-=q8!:w$K4X$9$k@_Dj(B"
				:format "%t:\n%h%v"
				:doc ""
				,@search))
	   (widget-create 'group
			  :value info
			  `(set :inline t
				:greedy t
				:tag "$BF~NOJ}<0$K4X$9$k@_Dj(B"
				:format "%t:\n%h%v"
				:doc ""
				,@input))
	   (widget-create 'group
			  :value info
			  `(set :inline t
				:greedy t
				:tag "$B$=$NB>$N@_Dj(B"
				:format "%t:\n%h%v"
				:doc ""
				,@misc))))
    (use-local-map widget-keymap)
    (local-set-key "q" 'bury-buffer)
    (widget-setup)
    (goto-char (point-min))))

(defun skk-customize-done (&rest args)
  (interactive)
  (dolist (params skk-custom-params)
    (setq skk-custom-alist (append skk-custom-alist
				   (widget-value params))))
  (dolist (param (append skk-cus-params-visual
			 skk-cus-params-ui
			 skk-cus-params-henkan
			 skk-cus-params-search
			 skk-cus-params-input
			 skk-cus-params-misc))
    (set (car param)
	 (let ((el (assq (car param) skk-custom-alist)))
	   (if el
	       (cdr el)
	     nil))))
  (with-temp-buffer
    (insert "(setq skk-custom-alist '"
	    (prin1-to-string skk-custom-alist)
	    ")\n")
    (write-region (point-min) (point-max) skk-custom-file))
  (bury-buffer)
  (unless (eq skk-custom-buffer-original (current-buffer))
    (switch-to-buffer skk-custom-buffer-original))
  (skk-adjust-user-option))

;;;###autoload
(defun skk-cus-setup ()
  (let ((file (expand-file-name skk-custom-file)))
    (when (file-readable-p file)
      (load-file file))
    (when skk-custom-alist
      (dolist (param skk-custom-alist)
	(set (car param) (cdr param))))))

;;

(require 'product)
(product-provide
    (provide 'skk-cus)
  (require 'skk-version))

;;; skk-cus.el ends here
