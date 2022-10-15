"""Update alpine."""

from common_image import update_image


update_image("alpine", lambda v: not v.release_candidate)
