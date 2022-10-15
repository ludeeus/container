"""Version module."""

from awesomeversion import (
    AwesomeVersion,
    AwesomeVersionCompareException,
    AwesomeVersionStrategy,
)
from awesomeversion.typing import VersionType


def _get_first_match_version(version: VersionType) -> AwesomeVersion:
    return AwesomeVersion(
        version,
        ensure_strategy=[
            AwesomeVersionStrategy.SEMVER,
            AwesomeVersionStrategy.SIMPLEVER,
        ],
        find_first_match=True,
    )


class Version(AwesomeVersion):
    """Version object."""

    @property
    def tags(self):
        """Get all tags."""
        tags = ["latest"]
        tags.append(str(self.section(0)))
        if self.sections > 1:
            tags.append(f"{self.section(0)}.{self.section(1)}")
        if self.sections > 2:
            tags.append(f"{self.section(0)}.{self.section(1)}.{self.section(2)}")
        return tags

    def __lt__(self, compareto: VersionType) -> bool:
        """Check if less than."""
        try:
            return super().__lt__(compareto)
        except AwesomeVersionCompareException:
            # "11.5-slim" has the AwesomeVersionStrategy.UNKNOWN and with that strategy __lt__ is not working
            # Using this as workaround by ignoring modifier
            return _get_first_match_version(self) < _get_first_match_version(compareto)

    def __gt__(self, compareto: VersionType) -> bool:
        """Check if greater than."""
        return not self.__le__(compareto)
