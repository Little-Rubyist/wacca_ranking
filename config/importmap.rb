# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "popper", to: 'popper.js', preload: true
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.4/lib/assets/compiled/rails-ujs.js"
pin "bootstrap-table", to: "https://ga.jspm.io/npm:bootstrap-table@1.21.1/dist/bootstrap-table.min.js", preload: true
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.1/dist/jquery.js"
