
;; color theme solalized
;; (el-get-bundle color-theme-solarized
;;   (custom-set-variables
;;     '(frame-background-mode (quote dark)))
;;   (load-theme 'solarized t))

(load-theme 'wombat t)

;; font
(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 160)

(set-fontset-font
 (frame-parameter nil 'font)
 'japanese-jisx0208
 '("Ricty" . "iso10646-1"))
(set-fontset-font
 (frame-parameter nil 'font)
 'japanese-jisx0212
 '("Ricty" . "iso10646-1"))
(set-fontset-font
 (frame-parameter nil 'font)
 'mule-unicode-0100-24ff
 '("Ricty" . "iso10646-1"))

;(setq face-font-rescale-alist
;     '(("^-apple-hiragino.*" . 0.8)
;       (".*osaka-bold.*" . 1.2)
;       (".*osaka-medium.*" . 1.2)
;       (".*courier-bold-.*-mac-roman" . 1.0)
;       (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;       (".*monaco-bold-.*-mac-roman" . 0.9)
;       ("-cdac$" . 1.3)))
;(add-to-list 'face-font-rescale-alist
;             '(".*Ricty.*" . 1.2))

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

;; オートセーブファイルの保存先
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/.backup/") t)))

;; オートセーブファイルは無効化
(setq auto-save-default nil)

;; 開いているバッファは常に最新になる
(global-auto-revert-mode 1)

;; Backup fileの場所指定
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/.backup"))
            backup-directory-alist))

;; yes/noではなくy/nで訊くようにする
(fset 'yes-or-no-p 'y-or-n-p)

;; カーソル位置の行番号と桁数を表示しない
;;(setq column-number-mode f)

;; 1行ずつスクロール
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t) ;; for shell-mode

;; スクロールバーは表示しない
(scroll-bar-mode 0)

;; ツールバーを非表示にする
(tool-bar-mode 0)

;; メニューバーにファイルパスを表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 選択範囲を表示する
(setq transient-mark-mode t)

;; 範囲選択中にバックスペースで選択範囲を削除する
(delete-selection-mode t)

;; 行番号を(常に)表示する
;;(global-linum-mode)
(setq linum-format "%4d ")

;; カーソル位置の行をハイライトする
;; (global-hl-line-mode)

;; カーソルを点滅しない
(blink-cursor-mode nil)

;; 最後のカーソル位置を記録
(load "saveplace")
(setq-default save-place t)

;; 対応するカーソルをハイライト
(show-paren-mode t)

;; ファイルの末尾には必ず改行をいれる
(setq require-final-newline t)

;; status-barに時間表示
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-string-forms
      '(month "/" day " " 24-hours ":" minutes " "))
(display-time-mode 1)

;; which-func
(require 'which-func)
(which-func-mode t)
(setq which-func-modes t)

;;windowの設定
(setq default-frame-alist
      (append (list
               '(width . 120)
               '(height . 35)
               '(top . 10)
               '(left . 10)
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

;; 保存時に行末の空白を削除する
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; バッファの範囲を示すマークを表示する
(setq-default indicate-buffer-boundaries 'left)

;; Mac環境でのバックスラッシュ入力対策
(define-key global-map [?\¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

;; 単語境界に_は含めない
(modify-syntax-entry ?_ "w" (standard-syntax-table))

;; システムのクリップボードを使う
(setq x-select-enable-clipboard t)

;; eldoc
(setq-default eldoc-idle-delay 0.1
              eldoc-echo-area-use-multiline-p t
              flycheck-display-errors-delay 0.2)
(el-get-bundle eldoc-extension)
