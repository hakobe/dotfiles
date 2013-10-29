(el-get 'sync 'flymake)

;; GUIの警告は表示しない
;(setq flymake-gui-warnings-enabled nil)

;; 全てのファイルで flymakeを有効化
;(add-hook 'find-file-hook 'flymake-find-file-hook)

;; face
(set-face-background 'flymake-errline nil)
(set-face-foreground 'flymake-errline nil)
(set-face-inverse-video 'flymake-errline nil)
(set-face-underline 'flymake-errline "red")
(set-face-bold 'flymake-errline t)
