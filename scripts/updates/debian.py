"""Update debian."""

from common_image import update_image


update_image("debian", lambda v: v.section(0) >= 10, "slim")
