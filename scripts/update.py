from scripts.helpers.packages import (
    update_alpine_packages,
    update_base_images,
    update_python_packages,
)
from scripts.helpers.update_feature_packages import update_s6, update_netcore


update_netcore("3.1")
update_netcore("5.0")
update_s6()
update_base_images()
update_alpine_packages()
update_python_packages()
