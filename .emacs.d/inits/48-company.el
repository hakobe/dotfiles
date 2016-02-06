(el-get-bundle company-mode
  (global-company-mode +1)

  (with-eval-after-load-feature 'company
    (global-set-key (kbd "C-M-i") 'company-complete)
    (setq company-idle-delay 0) ; デフォルトは0.5
    (setq company-minimum-prefix-length 2) ; デフォルトは4
    (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

    ;; C-n, C-pで補完候補を次/前の候補を選択
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (define-key company-search-map (kbd "C-n") 'company-select-next)
    (define-key company-search-map (kbd "C-p") 'company-select-previous)

    ;; C-sで絞り込む
    (define-key company-active-map (kbd "C-s") 'company-filter-candidates)

    ;; TABで候補を設定
    (define-key company-active-map (kbd "C-i") 'company-complete-selection)

    ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
    (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
))
