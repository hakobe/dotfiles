;; ~/.emacs.d下に入れたファイルをload,require等で読み込めるようにする
(setq load-path (cons "~/.emacs.d" load-path))

;; ~/.emacs.d/site-lisp下に入れたファイルを(サブディレクトリ内のものも
;; 含め)load,require等で読み込めるようにする
(when (fboundp 'normal-top-level-add-subdirs-to-load-path)
  (let* ((dir "~/.emacs.d/site-lisp")
         (default-directory dir))
    (when (file-directory-p dir)
      (setq load-path (cons dir load-path))
      (normal-top-level-add-subdirs-to-load-path))))

;; emacs directory
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

; el-get
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(setq-default el-get-dir (locate-user-emacs-file "el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "http://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; fix evil.rcp
(add-to-list 'el-get-sources '(:name evil :build (("make" "all")) :info nil))

;; el-get 
(el-get 'sync
  '(evil anything auto-complete color-theme-solarized magit))

;; evil
(require 'evil)
(evil-mode 1)

;; color theme solalized
(load-theme 'solarized-dark t)

;; font
(set-face-attribute 'default nil

                    :family "monaco"
                    :height 140)
(set-fontset-font
 (frame-parameter nil 'font)
 'japanese-jisx0208
 '("Hiragino Maru Gothic Pro" . "iso10646-1"))
(set-fontset-font
 (frame-parameter nil 'font)
 'japanese-jisx0212
 '("Hiragino Maru Gothic Pro" . "iso10646-1"))
(set-fontset-font
 (frame-parameter nil 'font)
 'mule-unicode-0100-24ff
 '("monaco" . "iso10646-1"))
(setq face-font-rescale-alist
     '(("^-apple-hiragino.*" . 1.2)
       (".*osaka-bold.*" . 1.2)
       (".*osaka-medium.*" . 1.2)
       (".*courier-bold-.*-mac-roman" . 1.0)
       (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
       (".*monaco-bold-.*-mac-roman" . 0.9)
       ("-cdac$" . 1.3)))

;; 起動時に表示されるメッセージ, *scratch*バッファのメッセージ等を表示しない
(setq inhibit-startup-message t
      inhibit-startup-screen t
      initial-scratch-message nil)

;;;;;; キーバインド ;;;;;;

;; C-h to delete
(global-set-key "\C-h" 'delete-backward-char)

;;;;;;

;; デフォルトタブ幅4, タブはスペースを挿入
(setq-default tab-width 4
              indent-tabs-mode nil)

;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; Backup fileの場所指定
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/.backup"))
            backup-directory-alist))

;; yes/noではなくy/nで訊くようにする
(fset 'yes-or-no-p 'y-or-n-p)

;; カーソル位置の行番号と桁数を表示する
(setq column-number-mode t)

;; ツールバーを非表示にする
(tool-bar-mode 0)

;; メニューバーを非表示にする
;;(menu-bar-mode 0)

;; メニューバーにファイルパスを表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 対応する括弧をハイライトする
(show-paren-mode t)

;; 選択範囲を表示する
(setq transient-mark-mode t)

;; 範囲選択中にバックスペースで選択範囲を削除する
(delete-selection-mode t)

;; 行番号を(常に)表示する
;; (global-linum-mode)

;; カーソル位置の行をハイライトする
(global-hl-line-mode)

;; カーソルを点滅しない
(blink-cursor-mode nil)

;;windowの設定
(setq default-frame-alist
      (append (list
               '(width . 160)
               '(height . 55)
               '(top . 30)
               '(left . 80)
               '(alpha . (100 60)))
              default-frame-alist))


;; 長い行を折り返したときに記号(»)を表示する
(defface wrap-face
  '((((class color) (min-colors 88) (background dark))
     :foreground "aquamarine4")
    (((class color) (min-colors 88) (background light))
     :foreground "aquamarine2")
    (((class color) (min-colors 16))
     :foreground "DarkCyan")
    (((class color) (min-colors 8))
     :foreground "gray")
    (((type tty) (class mono))
     :inverse-video t))
  "Face of the wrap."
  :group 'convenience)
(set-display-table-slot standard-display-table 'wrap
                        (make-glyph-code #xbb 'wrap-face))

;; 行末の空白をハイライトする
(setq-default show-trailing-whitespace t)

;; バッファの範囲を示すマークを表示する
(setq-default indicate-buffer-boundaries 'left)

;; C-x C-bでバッファ選択画面を開く
(global-set-key (kbd "C-x C-b") 'bs-show)

;; IntelliSenseのような自動補完
;; [補完候補のキーバインド]
;;   M-n  次の候補
;;   M-p  前の候補
;;   TAB  候補の確定
;;   C-m  候補の確定
(when (require 'auto-complete nil t)
  (global-auto-complete-mode t)
  (setq ac-auto-show-menu 0.5))

;; 様々なものの選択を賢くする
;; [候補選択のキーバインド]
;;   C-n    次の候補
;;   Down   次の候補
;;   C-p    前の候補
;;   Up     前の候補
;;   Left   次の生成元
;;   Right  前の生成元
(when (require 'anything-config nil t)
  (setq dired-bind-jump nil) ; prevent binding to C-x C-j

  ;; ファイル選択で使うファイルリストの生成元
  (setq anything-for-files-prefered-list
      '(anything-c-source-buffers+
        anything-c-source-ffap-line
        anything-c-source-ffap-guesser
        anything-c-source-recentf
        anything-c-source-bookmarks
        anything-c-source-files-in-current-dir+
        anything-c-source-locate))


  ;; M-xでanythingを有効にする
  (when (require 'anything-complete nil t)(setq anything-complete-sort-candidates t)
    (substitute-key-definition 'execute-extended-command
                               'anything-execute-extended-command global-map)))


;; 元に戻す/やり直しをツリー状に管理
;; [キーバインド]
;;   C-/    元に戻す
;;   M-_    やり直し
;;   C-x u  編集履歴ツリーを表示
;;     p    ツリーを上る (元に戻す)
;;     n    ツリーを下る (やり直し)
;;     f    右の枝を選択
;;     b    左の枝を選択
;;     q    ツリーを閉じる
(when (require 'undo-tree nil t)
  (global-undo-tree-mode)
  (setq undo-tree-mode-lighter nil))


;; evil settings
(setq-default evil-auto-indent t
              evil-shift-with 4
              evil-cross-lines t
              evil-echo-state nil
              evil-want-C-i-jump nil
              evil-want-fine-undo t
              evil-search-module 'evil-search
              evil-ex-search-vim-style-regexp t)

(defun evil-swap-key (map key1 key2)
  "Swap KEY1 and KEY2 in MAP."
  (let ((def1 (lookup-key map key1))
        (def2 (lookup-key map key2)))
    (define-key map key1 def2)
    (define-key map key2 def1)))

;; move cursor visually by default
(evil-swap-key evil-motion-state-map "j" "gj")
(evil-swap-key evil-motion-state-map "k" "gk")

;; ファイルやバッファの切り替え
(define-key evil-normal-state-map (kbd ",f") #'anything-filelist+)
(define-key evil-normal-state-map (kbd ",b") #'anything-filelist+)

