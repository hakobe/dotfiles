(el-get-bundle company-mode
  ; (global-company-mode +1)

  (with-eval-after-load-feature 'company
    (setq company-idle-delay 0) ; デフォルトは0.5
    (setq company-minimum-prefix-length 1) ; デフォルトは4
    (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

    (define-key company-active-map (kbd "M-n") nil)
    (define-key company-active-map (kbd "M-p") nil)
    (define-key company-search-map (kbd "M-n") nil)
    (define-key company-search-map (kbd "M-p") nil)

    ;; C-n, C-pで補完候補を次/前の候補を選択
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
    (define-key company-search-map (kbd "C-n") 'company-select-next)
    (define-key company-search-map (kbd "C-p") 'company-select-previous)

    ;;; C-hがデフォルトでドキュメント表示にmapされているので、文字を消せるようにmapを外す
    (define-key company-active-map (kbd "C-h") nil)

    ;; C-sで絞り込む
    (define-key company-active-map (kbd "C-s") 'company-filter-candidates)

    ;;; 1つしか候補がなかったらtabで補完、複数候補があればtabで次の候補へ行くように
    (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
    ;;; ドキュメント表示
    (define-key company-active-map (kbd "M-d") 'company-show-doc-buffer)
))
