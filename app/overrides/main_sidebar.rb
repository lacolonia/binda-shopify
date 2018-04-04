Deface::Override.new  :virtual_path => "layouts/binda/_sidebar",
                      :name => 'main_sidebar',
                      :insert_before => "[data-hook='main-sidebar-log-out']",
                      :partial => 'shared/synchronize'
