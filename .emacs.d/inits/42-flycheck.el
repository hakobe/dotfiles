(add-to-list 'el-get-sources
    '(:name flycheck
           :type github
           :pkgname "lunaryorn/flycheck"
           :description "On-the-fly syntax checking extension"
           :depends (s dash cl-lib f pkg-info)))

(el-get 'sync 'flycheck)
